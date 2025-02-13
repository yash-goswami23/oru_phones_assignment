import 'package:oru_phones_assignment/data/models/auth_models/user_model.dart';

class UserLoggedIn {
  final bool isLoggedIn;
  final String? sessionId;
  final User? user;
  final String? csrfToken;

  UserLoggedIn({
    required this.isLoggedIn,
    this.sessionId,
    this.user,
    this.csrfToken,
  });

  factory UserLoggedIn.fromJson(Map<String, dynamic> json) {
    return UserLoggedIn(
      isLoggedIn: json['isLoggedIn'] ?? false, // Default to false if null
      sessionId: json['sessionId'],
      user: json['user'] != null
          ? User.fromJson(json['user'])
          : null, // Handle null user
      csrfToken: json['csrfToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isLoggedIn': isLoggedIn,
      'sessionId': sessionId,
      'user': user?.toJson(), // Handle null user
      'csrfToken': csrfToken,
    };
  }
}
