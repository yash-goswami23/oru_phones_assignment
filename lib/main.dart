import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oru_phones_assignment/core/config/routes.dart';
import 'package:oru_phones_assignment/core/network/api_client.dart';
import 'package:oru_phones_assignment/core/network/api_endpoints.dart';
import 'package:oru_phones_assignment/data/repositories/auth_repository.dart';
import 'package:oru_phones_assignment/data/repositories/home_repository.dart';
import 'package:oru_phones_assignment/data/repositories/shared_prefs.dart';
import 'package:oru_phones_assignment/data/services/notifaction_services.dart';
import 'package:oru_phones_assignment/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:oru_phones_assignment/presentation/blocs/home_bloc/home_bloc.dart';

@pragma('vm:entry-point')
Future<void> _firebaseBackgroundNotificationHandle(
    RemoteMessage message) async {
  await Firebase.initializeApp();
  print("📩 Background Message Received: ${message.notification?.title}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundNotificationHandle);
  await NotificationService.initialize();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final SharedPrefs sharedPrefs = SharedPrefs.instance;
    final ApiClient apiClient = ApiClient(APIEndpoints.appUrl);
    final AuthRepository authRepository = AuthRepository(apiClient);
    final HomeRepository homeRepository = HomeRepository(apiClient);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AuthBloc(sharedPrefs, authRepository)),
        BlocProvider(
            create: (context) => HomeBloc(homeRepository, sharedPrefs)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: Routes.splashScreen,
        onGenerateRoute: Routes.onGenerateRoute,
      ),
    );
  }
}
