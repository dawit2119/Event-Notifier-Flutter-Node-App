import 'package:frontend/ApplicationState/Bloc/Login/blocs.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:frontend/ApplicationState/Bloc/Register/blocs.dart';
import 'package:frontend/Models/models.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
    implements LoginBloc {}

void main() {
  LoginModel mockLoginModel = LoginModel("se.alemu@gmail.com", "alemu");
  User mockUser = User("se.alemu@gmail.com", "alemu23",
      fullName: "kebede",
      userName: "miko",
      confirmPassword: "alemu23",
      userRole: "user",
      id: "2");
  group('LoginBloc test', () {
    // before injected
    blocTest<LoginBloc, LoginState>(
      'emits [] when nothing is added before injected',
      build: () {
        return LoginBloc();
      },
      expect: () => <LoginState>[],
    );
    // build is where we instantite and prepare our bloc under test
    // act is used to add an event to the bloc which is tested
    // expect is Iterable<state> the bloc will emit after bloc executed
    blocTest<LoginBloc, LoginState>(
      'When Login user event is added',
      build: () {
        return LoginBloc();
      },
      act: (bloc) {
        return bloc.add(LogingUserEvent(mockLoginModel));
      },
      wait: const Duration(milliseconds: 1000),
      expect: () {
        return [Loging(), FaildLoging(), LoggedOut()];
      },
    );
    blocTest<LoginBloc, LoginState>(
      'Logout submitted',
      build: () {
        return LoginBloc();
      },
      act: (bloc) {
        return bloc.add(LogoutEvent());
      },
      wait: const Duration(milliseconds: 1000),
      expect: () {
        return [isA<LoginState>()];
      },
    );
  });
}
