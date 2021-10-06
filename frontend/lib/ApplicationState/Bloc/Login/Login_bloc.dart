import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/Repository/MainRepository.dart';
import 'blocs.dart';
import 'package:frontend/Models/models.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoggedOut());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LogingUserEvent) {
      yield Loging();
      try {
        Map<String, dynamic> incommingvalue =
            await AuthRepository.LoginUserRepo(event.loginModel);

        User user = User(
          incommingvalue['currentuser']['emailAddress'],
          incommingvalue['currentuser']['password'],
          fullName: incommingvalue['currentuser']['fullName'],
          userName: incommingvalue['currentuser']['userName'],
          userRole: incommingvalue['currentuser']['userRole'],
          id: incommingvalue['currentuser']['_id'],
        );
        print("passed bloc");
        yield Logedin(user, incommingvalue['access_token']);
      } catch (e) {
        yield FaildLoging();
        await Future.delayed(Duration(seconds: 2));
        yield LoggedOut();
      }
    }

    if (event is LogoutEvent) {
      User logoutuser = User("", "",
          fullName: "", confirmPassword: "", userRole: "", userName: "");
      yield Logedin(logoutuser, "");
    }

    if (event is DeleteUserEvent) {
      try {
        print("at bloc");
        String response =
            await AuthRepository.DeleteUserRepo(event.user, event.accesstoken);
        print(response);
        // yield LoginState();
      } catch (e) {}
    }
  }
}
