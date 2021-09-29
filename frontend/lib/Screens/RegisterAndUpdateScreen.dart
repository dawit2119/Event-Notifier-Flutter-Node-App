import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/ApplicationState/Bloc/Register/blocs.dart';
import 'package:frontend/Routes/Routes.dart';
import 'package:frontend/Widgets/widgets.dart';
import 'package:frontend/Models/models.dart';

class RegisterController extends StatefulWidget {
  const RegisterController({Key? key, required this.argument})
      : super(key: key);
  final AuthArgument argument;
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<RegisterController> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassword = TextEditingController();
  final fullNameCont = TextEditingController();
  final userNameCont = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _user = {};

  String roleDropDownValue = 'User';
  @override
  Widget build(BuildContext context) {
    final bool isUpdate = widget.argument.update;
    final User user = widget.argument.user!;
    if (isUpdate) {
      emailController.text = user.emailAddress!;
      fullNameCont.text = user.fullName!;
      userNameCont.text = user.userName!;
      roleDropDownValue = user.userRole!;
    }
    return Scaffold(
      appBar: AppBar(
          title: Text(isUpdate ? "Update Account" : "Register"),
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
                        isUpdate ? 'Update Account' : 'Sign Up',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isUpdate ? 30 : 50,
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
                          color: isUpdate ? Colors.yellow : Colors.green,
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
                            return "Email is not correct";
                          }
                          return null;
                        },
                        labelText: "Email Address",
                        textEditingController: emailController,
                        icondata: Icon(Icons.email),
                      ),
                      CustomTextField(
                        isValid: (value) {
                          if (value!.isEmpty) {
                            return "Fullname is required";
                          }
                          return null;
                        },
                        labelText: "Full Name",
                        textEditingController: fullNameCont,
                        icondata: Icon(Icons.person),
                      ),
                      CustomTextField(
                        isValid: (value) {
                          if (value!.isEmpty) {
                            return "Username is required";
                          }
                          return null;
                        },
                        labelText: "User Name",
                        textEditingController: userNameCont,
                        icondata: Icon(Icons.person_outline),
                      ),
                      CustomTextField(
                        isValid: (value) {
                          if (value!.isEmpty) {
                            return "password is required";
                          }
                          if (value.length < 6) {
                            return "too short password";
                          }
                          return null;
                        },
                        labelText: "Password",
                        textEditingController: passwordController,
                        icondata: Icon(Icons.password),
                      ),
                      CustomTextField(
                        labelText: "Confirm Password",
                        textEditingController: confirmPassword,
                        icondata: Icon(Icons.password),
                        isValid: (value) {
                          if (value!.isEmpty ||
                              (passwordController.text !=
                                  confirmPassword.text)) {
                            return "Passwords doesn't match";
                          }
                          return null;
                        },
                      ),
                      Container(
                          margin: EdgeInsets.only(right: 100),
                          child: Row(children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 50),
                                child: Text(
                                  "Role",
                                  style: TextStyle(color: Colors.greenAccent),
                                ),
                              ),
                            ),
                            DropdownButton<String>(
                              value: roleDropDownValue,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              iconSize: 24,
                              style: const TextStyle(color: Colors.pinkAccent),
                              onChanged: (String? newValue) {
                                setState(() {
                                  roleDropDownValue = newValue!;
                                });
                              },
                              items: <String>[
                                'User',
                                'Representative'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ])),
                      BlocConsumer<RegisterBloc, RegisterState>(
                        listener: (_, state) {
                          if (state is Registered) {
                            print("Register success");
                          }
                          if (state is AccountUpdated) {
                            print("Account update success");
                          }
                          if (state is Registered || state is AccountUpdated) {
                            emailController.text = "";
                            fullNameCont.text = "";
                            userNameCont.text = "";
                            passwordController.text = "";
                            confirmPassword.text = "";
                            Navigator.pushNamed(context, '/');
                          }
                        },
                        builder: (_, state) {
                          if (state is Registering) {
                            return SpinKitDualRing(
                              color: Colors.black,
                              size: 50,
                            );
                          }
                          if (state is Registered) {
                            return Text("Signup Sucess! go back and login");
                          }
                          if (state is AccountUpdated) {
                            return Text("Update Sucess! go back and login");
                          }
                          if (state is AccountUpdateRegsiterFailed) {
                            return Text(
                              "${state.message}",
                              style: TextStyle(
                                  color: Colors.redAccent, fontSize: 25),
                            );
                          }
                          return Hero(
                            tag: "Registertag",
                            child: CustomRoundButton(
                              onPressedfun: () async {
                                var form = _formKey.currentState;
                                if (form!.validate()) {
                                  User user = User(
                                    emailController.text,
                                    passwordController.text,
                                    userName: userNameCont.text,
                                    fullName: fullNameCont.text,
                                    userRole: roleDropDownValue,
                                    id: "tempid",
                                    confirmPassword: confirmPassword.text,
                                  );

                                  RegisterEvent registerOrUpdateEvent = isUpdate
                                      ? UpdateAccount(user: user)
                                      : RegisteringUser(user);

                                  BlocProvider.of<RegisterBloc>(context)
                                      .add(registerOrUpdateEvent);
                                }
                              },
                              backroundcolor:
                                  isUpdate ? Colors.yellow : Colors.blue,
                              displaytext: Text(
                                isUpdate ? "Update" : "Register",
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
