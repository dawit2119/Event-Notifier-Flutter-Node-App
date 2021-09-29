import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/ApplicationState/Bloc/Holyplace/blocs.dart';
import 'package:frontend/ApplicationState/Bloc/Login/blocs.dart';
import 'package:frontend/ApplicationState/Bloc/Schedule/Schedule_bloc.dart';
import 'package:frontend/ApplicationState/Bloc/Schedule/Schedule_event.dart';
import 'package:frontend/Widgets/widgets.dart';
import 'package:frontend/Models/models.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final emailCont = TextEditingController();
  final passwordCont = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String roleDropDownValue = 'User';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Login"),
          iconTheme: IconThemeData(color: Colors.black87),
          backgroundColor: Colors.white),
      body: Center(
        child: Stack(
          children: [
            Image.asset("assets/images/background.jpg",
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover),
            ListView(
              shrinkWrap: false,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 110, 0, 0),
                      child: Text(
                        'Log in',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 40, 0, 0),
                      child: Text(
                        '.',
                        style: TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomTextField(
                        isValid: (value) {
                          if (!EmailValidator.validate(value!)) {
                            return "Email is not valid";
                          }
                          return null;
                        },
                        labelText: "Email Address",
                        textEditingController: emailCont,
                        icondata: Icon(Icons.email),
                      ),
                      CustomTextField(
                        isValid: (value) {
                          if (value!.isEmpty) {
                            return "password is required";
                          }
                          return null;
                        },
                        labelText: "Password",
                        textEditingController: passwordCont,
                        icondata: Icon(Icons.password),
                      ),
                      BlocConsumer<LoginBloc, LoginState>(
                        listener: (_, state) {
                          if (state is Logedin) {
                            emailCont.text = "";
                            passwordCont.text = "";
                            var currentuser = state.loggedinUserinfo.tojson();
                            String role = currentuser['userRole'];

                            if (role == "Representative") {
                              Navigator.pushNamed(context, '/repmainscreen');
                            } else if (role == "User") {
                              BlocProvider.of<ScheduleBloc>(context).add(
                                GetNotSeenNumber(state.loggedinUserinfo.id!),
                              );
                              BlocProvider.of<HolyPlaceBloc>(context)
                                  .add(LoadingHolyPlacesEvent());
                              Navigator.pushNamed(context, '/mainscreen');
                            } else if (role == "Admin") {
                              Navigator.pushNamed(context, '/adminpage');
                            }
                          }
                        },
                        builder: (_, state) {
                          if (state is Loging) {
                            return SpinKitDualRing(
                              color: Colors.black,
                              size: 50,
                            );
                          }
                          if (state is FaildLoging) {
                            return Text(
                              "Email or password incorrect!",
                              style: TextStyle(fontSize: 25, color: Colors.red),
                            );
                          }
                          return Hero(
                            tag: "loginTag",
                            child: CustomRoundButton(
                              onPressedfun: () async {
                                var form = _formKey.currentState;
                                if (form!.validate()) {
                                  LoginModel loginModel = LoginModel(
                                      emailCont.text, passwordCont.text);
                                  LoginEvent loginEvent =
                                      LogingUserEvent(loginModel);
                                  BlocProvider.of<LoginBloc>(context)
                                      .add(loginEvent);
                                }
                              },
                              backroundcolor: Colors.redAccent,
                              displaytext: Text(
                                "Log in ",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
