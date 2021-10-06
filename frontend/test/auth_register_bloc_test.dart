import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/ApplicationState/Bloc/Register/blocs.dart';
import 'package:frontend/Models/models.dart';

void main(){
   User mockUser = User("se.alemus@gmail.com", "alemu23",
      fullName: "kebede",
      userName: "miko",
      confirmPassword: "alemu23",
      userRole: "user",
      );
  group("RegisterAuth bloc test", () {
    blocTest<RegisterBloc, RegisterState>(
      'emits nothing when nothing added',
      build: () {
        return RegisterBloc();
      },
      expect: () => <RegisterState>[],
    );

    blocTest<RegisterBloc, RegisterState>(
      'Register submitted',
      build: () {
        return RegisterBloc();
      },
      act: (bloc) {
        return bloc.add(RegisteringUser(mockUser));
      },
      wait: const Duration(milliseconds: 1000),
      expect: () {
        return [
          isA<RegisterState>(),
          isA<RegisterState>(),
        ];
      },
    );

    blocTest<RegisterBloc, RegisterState>(
      'Account updated',
      build: () {
        return RegisterBloc();
      },
      act: (bloc) {
        return bloc.add(UpdateAccount(user: mockUser));
      },
      wait: const Duration(milliseconds: 1000),
      expect: () {
        return [
          isA<RegisterState>(),
          isA<RegisterState>(),
          isA<RegisterState>(),
        ];
      },
    );
  });
}