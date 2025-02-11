import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oru_phones_assignment/core/config/routes.dart';
import 'package:oru_phones_assignment/core/network/api_client.dart';
import 'package:oru_phones_assignment/core/network/api_endpoints.dart';
import 'package:oru_phones_assignment/data/repositories/auth_repository.dart';
import 'package:oru_phones_assignment/data/repositories/shared_prefs.dart';
import 'package:oru_phones_assignment/data/services/notifaction_services.dart';
import 'package:oru_phones_assignment/presentation/blocs/auth_bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Request Notification Permissions at Startup
  await NotificationServices().requestNotificationPermission();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final SharedPrefs sharedPrefs = SharedPrefs.instance;
    final ApiClient apiClient = ApiClient(APIEndpoints.appUrl);
    final AuthRepository authRepository = AuthRepository(apiClient);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AuthBloc(sharedPrefs, authRepository)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Your App',
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
