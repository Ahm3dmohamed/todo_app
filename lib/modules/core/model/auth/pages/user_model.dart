class UserModel {
  String userId;
  String userName;
  String userEmail;
  String userPhone;
  String userPassword;
  UserModel({
    this.userId = "",
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.userPassword,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : this(
            userId: json["userId"],
            userName: json["userName"],
            userEmail: json["userEmail"],
            userPhone: json["userPhone"],
            userPassword: json["userPassword"]);

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "userName": userName,
      "userEmail": userEmail,
      "userPhone": userPhone,
      "userPassword": userPassword,
    };
  }
}
