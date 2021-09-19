class LoginModel {
  String? emailAddress;
  String? password;

  LoginModel(this.emailAddress, this.password);

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      json['emailAddress'],
      json['password'],
    );
  }

  Map<String, dynamic> tojson() {
    return {
      "emailAddress": emailAddress,
      "password": password,
    };
  }
}
