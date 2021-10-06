import 'package:equatable/equatable.dart';
import 'package:frontend/Models/User.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisteringUser extends RegisterEvent {
  final User user;

  RegisteringUser(this.user);
  @override
  List<Object?> get props => [user];
}

class UpdateAccount extends RegisterEvent{
    final User user;

  UpdateAccount({required this.user});
  @override
  List<Object?> get props => [user];
}
class DeleteAccount extends RegisterEvent{
      final User user;

  DeleteAccount({required this.user});
  @override
  List<Object?> get props => [user];
}