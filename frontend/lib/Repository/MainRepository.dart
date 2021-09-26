import 'package:frontend/DataProvider/Auth/Auth.dart';
import 'package:frontend/Models/LoginModel.dart';
import 'package:frontend/Models/User.dart';

class AuthRepository {
  //Register Repo

  static Future<User> RegisterUserRepo(User user) async {
    print("passed auth repo");
    return await ClientAuthDataProvider.register(user);
  }


  //Login Repo

  static Future<Map<String, dynamic>> LoginUserRepo(
      LoginModel loginModel) async {
    return await ClientAuthDataProvider.login(loginModel);
  }

  //Delete repo
  static Future<String> DeleteUserRepo(User user, String accesstoken) async {
    print("Delete User Repo!");
    return await ClientAuthDataProvider.deleteaccount(user, accesstoken);
  }
  static Future<String> updateAccount(User user)async{
    return await ClientAuthDataProvider.update(user);
  }
}
