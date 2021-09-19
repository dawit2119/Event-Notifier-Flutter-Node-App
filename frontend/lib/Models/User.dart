class User {
  String? fullName;
  String? userName;
  String? emailAddress;
  String? password;
  String? confirmPassword;
  String? userRole;
  String? id;

  User(this.emailAddress, this.password,
      {this.fullName,
      this.userName,
      this.confirmPassword,
      this.userRole,
      this.id});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(json['emailAddress'], json['password'],
        id: json['id'],
        fullName: json['fullNmme'],
        userName: json['userName'],
        confirmPassword: json['confirmPassword'],
        userRole: json['userRole']);
  }

  Map<String, dynamic> tojson() {
    return {
      "fullName": fullName,
      "userName": userName,
      "emailAddress": emailAddress,
      "password": password,
      "confirmPassword": confirmPassword,
      "userRole": userRole,
      "id": id,
    };
  }
}
