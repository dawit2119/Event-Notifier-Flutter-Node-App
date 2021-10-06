import 'package:equatable/equatable.dart';
import 'package:frontend/Models/User.dart';

class RegisterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterIntial extends RegisterState {}

class Registering extends RegisterState {}

class AccountUpdateRegsiterFailed extends RegisterState {
  final String message;

  AccountUpdateRegsiterFailed({required this.message});
}

class Registered extends RegisterState {
  final User registeredUser;
  Registered(this.registeredUser);
  @override
  List<Object?> get props => [registeredUser];
}

class AccountUpdated extends RegisterState {
  final String message;
  AccountUpdated({required this.message});
  @override
  List<Object?> get props => [message];
}

