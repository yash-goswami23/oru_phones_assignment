import 'package:oru_phones_assignment/data/models/user_model.dart';

class UserLoggedIn {
  final bool isLoggedIn;
  final String sessionId;
  final User user;
  final String csrfToken;

  UserLoggedIn({
    required this.isLoggedIn,
    required this.sessionId,
    required this.user,
    required this.csrfToken,
  });

  factory UserLoggedIn.fromJson(Map<String, dynamic> json) {
    return UserLoggedIn(
      isLoggedIn: json['isLoggedIn'],
      sessionId: json['sessionId'],
      user: User.fromJson(json['user']),
      csrfToken: json['csrfToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isLoggedIn': isLoggedIn,
      'sessionId': sessionId,
      'user': user.toJson(),
      'csrfToken': csrfToken,
    };
  }
}
