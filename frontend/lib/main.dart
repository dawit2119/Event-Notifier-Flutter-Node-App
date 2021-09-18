import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/ApplicationState/Bloc/subscription/subscription_bloc.dart';
import 'package:frontend/Screens/screens.dart';
import 'ApplicationState/Bloc/Login/blocs.dart';
import 'ApplicationState/Bloc/Register/blocs.dart';
import 'ApplicationState/Bloc/Schedule/blocs.dart';
import 'ApplicationState/Bloc/Holyplace/blocs.dart';
import 'bloc_observer.dart';
import 'Routes/Routes.dart';

void main() {
  Bloc.observer = MyObserver();
  runApp(AppStarter());
}

class AppStarter extends StatelessWidget {
  const AppStarter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HolyPlaceBloc>(
          create: (BuildContext context) => HolyPlaceBloc(),
        ),
        BlocProvider<SubscriptionBloc>(
          create: (BuildContext context) => SubscriptionBloc(),
        ),
        BlocProvider<ScheduleBloc>(
          create: (BuildContext context) => ScheduleBloc(),
        ),
        BlocProvider<LoginBloc>(
          create: (BuildContext context) => LoginBloc(),
        ),
        BlocProvider<RegisterBloc>(
          create: (BuildContext context) => RegisterBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Religious Daily Schedule Notifer app",
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
