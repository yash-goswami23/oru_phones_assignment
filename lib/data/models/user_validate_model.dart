import 'package:oru_phones_assignment/data/models/user_model.dart';

class UserValidate {
  final String reason;
  final String status;
  final DataObject dataObject;
  final User user;

  UserValidate({
    required this.reason,
    required this.status,
    required this.dataObject,
    required this.user,
  });

  factory UserValidate.fromJson(Map<String, dynamic> json) {
    return UserValidate(
      reason: json['reason'],
      status: json['status'],
      dataObject: DataObject.fromJson(json['dataObject']),
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reason': reason,
      'status': status,
      'dataObject': dataObject.toJson(),
      'user': user.toJson(),
    };
  }
}

class DataObject {
  final int submitCountIncrement;
  final String maxRetryCount;

  DataObject({
    required this.submitCountIncrement,
    required this.maxRetryCount,
  });

  factory DataObject.fromJson(Map<String, dynamic> json) {
    return DataObject(
      submitCountIncrement: json['submitCountIncrement'],
      maxRetryCount: json['maxRetryCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'submitCountIncrement': submitCountIncrement,
      'maxRetryCount': maxRetryCount,
    };
  }
}
