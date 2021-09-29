import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/ApplicationState/Bloc/Login/blocs.dart';
import 'package:frontend/Models/models.dart';
import 'package:frontend/Routes/Routes.dart';
import 'package:frontend/Screens/screens.dart';
import 'package:frontend/Widgets/Button.dart';

class AccountSetting extends StatelessWidget {
  const AccountSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentLoggedInState = BlocProvider.of<LoginBloc>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
        title: Text(
          "Account Settings",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: BlocBuilder(
            bloc: currentLoggedInState,
            builder: (BuildContext context, state) {
              print("rebuild");
              if (state is Logedin) {
                return Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2,
                    child: Card(
                      elevation: 10,
                      child: BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                        if (state is Logedin) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomRoundButton(
                                  backroundcolor: Colors.yellowAccent,
                                  displaytext: Text('Update'),
                                  onPressedfun: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => RegisterController(
                                                argument: AuthArgument(
                                                    update: true,user: state.loggedinUserinfo))));
                                  }),

                              CustomRoundButton(
                                backroundcolor: Colors.redAccent,
                                displaytext: Text('Delete'),
                                onPressedfun: () => showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: Text(
                                      'Info',
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 15),
                                    ),
                                    content: Text('Are You shure'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancel'),
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(color: Colors.green),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          User user = User(
                                              state.loggedinUserinfo
                                                  .emailAddress,
                                              "");
                                          BlocProvider.of<LoginBloc>(context)
                                              .add(DeleteUserEvent(
                                                  user, state.access_token));
                                          Navigator.pushNamed(context, '/');
                                        },
                                        child: const Text('OK',
                                            style:
                                                TextStyle(color: Colors.red)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              //   BlocBuilder<LoginBloc, LoginState>(
                              //       builder: (context, state) {
                              //     if (state is Logedin) {
                              //       return AlertDialog(
                              //         title: const Text('Info'),
                              //         content: SingleChildScrollView(
                              //           child: ListBody(
                              //             children: const <Widget>[
                              //               Text('Are you Sure'),
                              //             ],
                              //           ),
                              //         ),
                              //         actions: <Widget>[
                              //           TextButton(
                              //             child: const Text('Yes',
                              //                 style:
                              //                     TextStyle(color: Colors.red)),
                              //             onPressed: () {
                              //               User user = User(
                              //                   state.loggedinUserinfo
                              //                       .emailAddress,
                              //                   "");
                              //               BlocProvider.of<LoginBloc>(context)
                              //                   .add(DeleteUserEvent(
                              //                       user, state.access_token));
                              //               Navigator.pushNamed(context, '/');
                              //             },
                              //           ),
                              //           TextButton(
                              //             child: Text(
                              //               "No",
                              //               style:
                              //                   TextStyle(color: Colors.green),
                              //             ),
                              //             onPressed: () {
                              //               print("Hello");
                              //             },
                              //           ),
                              //         ],
                              //       );
                              //     }
                              //     ;
                              //     return Container();
                              //   });
                              // });
                            ],
                          );
                        }
                        return Container();
                      }),
                    ),
                  ),
                );
              }
              return Text("");
            }),
      ),
    );
  }
}

/**
 *                       children: [
                        Container(
                          child: Text(
                              "fullName : ${state.loggedinUserinfo.tojson()['fullName']}"),
                        ),
                        Container(
                          child: Text(
                              "userName : ${state.loggedinUserinfo.tojson()['userName']}"),
                        ),
                        Container(
                          child: Text(
                              "emailAddress : ${state.loggedinUserinfo.tojson()['emailAddress']}"),
                        ),
                        Container(
                          child: Text(
                              "password : ${state.loggedinUserinfo.tojson()['password']}"),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          child: ElevatedButton(
                            child: Text("Delete Account"),
                            onPressed: () {
                              User user =
                                  User(state.loggedinUserinfo.emailAddress, "");
                              BlocProvider.of<LoginBloc>(context)
                                  .add(DeleteUserEvent(user, state.access_token));
                              Navigator.pushNamed(context, '/');
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          child: ElevatedButton(
                            child: Text("Update Account"),
                            onPressed: () {
                              print("update event added!");
                  
                              User user =
                                  User(state.loggedinUserinfo.emailAddress, "");
                            },
                          ),
                        ),
                      ],

 */