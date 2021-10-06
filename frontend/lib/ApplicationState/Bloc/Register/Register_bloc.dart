import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/ApplicationState/Bloc/Register/Register_event.dart';
import 'package:frontend/Repository/MainRepository.dart';
import 'blocs.dart';
import 'package:frontend/Models/models.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterIntial());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisteringUser) {
      yield Registering();

      try {
        User newuser = await AuthRepository.RegisterUserRepo(event.user);
        print(newuser.tojson());
        var incommingValue = newuser.tojson();
        if (incommingValue['emailAddress'] == '') {
          yield AccountUpdateRegsiterFailed(message: "Failed to register");
        } else if (incommingValue['emailAddress'] != '') {
          yield Registered(newuser);
          await Future.delayed(Duration(seconds: 2));
          yield RegisterIntial();
        }
      } catch (e) {
        yield AccountUpdateRegsiterFailed(message: "Failed to register");
        await Future.delayed(Duration(seconds: 2));
        yield RegisterIntial();
      }
    }
    if (event is UpdateAccount) {
      yield Registering();
      try {
        var message = await AuthRepository.updateAccount(event.user);
        print("update message:$message");
        if (message != "") {
          yield AccountUpdated(message: message);
        } else {
          yield AccountUpdateRegsiterFailed(
              message: "Failed to Update Account");
          await Future.delayed(Duration(seconds: 2));
          yield RegisterIntial();
        }
      } catch (e) {
        yield AccountUpdateRegsiterFailed(message: e.toString());
        await Future.delayed(Duration(seconds: 2));
        yield RegisterIntial();
      }
    }
  }
}
