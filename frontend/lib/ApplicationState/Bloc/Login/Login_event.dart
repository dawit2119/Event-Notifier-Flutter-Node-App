import 'package:equatable/equatable.dart';
// import 'package:frontend/Models/User.dart';
import 'package:frontend/Models/LoginModel.dart';
import 'package:frontend/Models/User.dart';

class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LogingUserEvent extends LoginEvent {
  final LoginModel loginModel;
  LogingUserEvent(this.loginModel);

  @override
  List<Object?> get props => [loginModel];
}

class LogoutEvent extends LoginEvent {}

class DeleteUserEvent extends LoginEvent {
  User user;
  String accesstoken;
  DeleteUserEvent(this.user, this.accesstoken);

  @override
  List<Object?> get props => [user, accesstoken];
}
