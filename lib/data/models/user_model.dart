class User {
  final String userName;
  final String email;
  final String profilePicPath;
  final String city;
  final String state;
  final String mobileNumber;
  final bool isAccountExpired;
  final String createdDate;
  final List<String> favListings;
  final String userType;
  final bool WAOptIn;
  final List<dynamic> userListings;

  User({
    required this.userName,
    required this.email,
    required this.profilePicPath,
    required this.city,
    required this.state,
    required this.mobileNumber,
    required this.isAccountExpired,
    required this.createdDate,
    required this.favListings,
    required this.userType,
    required this.WAOptIn,
    required this.userListings,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userName: json['userName'],
      email: json['email'],
      profilePicPath: json['profilePicPath'],
      city: json['city'],
      state: json['state'],
      mobileNumber: json['mobileNumber'],
      isAccountExpired: json['isAccountExpired'],
      createdDate: json['createdDate'],
      favListings: List<String>.from(json['favListings']),
      userType: json['userType'],
      WAOptIn: json['WAOptIn'],
      userListings: List<dynamic>.from(json['userListings']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'email': email,
      'profilePicPath': profilePicPath,
      'city': city,
      'state': state,
      'mobileNumber': mobileNumber,
      'isAccountExpired': isAccountExpired,
      'createdDate': createdDate,
      'favListings': favListings,
      'userType': userType,
      'WAOptIn': WAOptIn,
      'userListings': userListings,
    };
  }
}
