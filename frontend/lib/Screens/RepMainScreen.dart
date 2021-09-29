import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/Widgets/widgets.dart';
import 'package:frontend/ApplicationState/Bloc/Login/blocs.dart';
import 'package:frontend/Models/models.dart';
import 'package:frontend/ApplicationState/Bloc/Schedule/blocs.dart';

class RepMainScreen extends StatelessWidget {
  RepMainScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var controller3 = TextEditingController();
  var controller4 = TextEditingController();
  var controller5 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String userId = "";
    var loginstate = BlocProvider.of<LoginBloc>(context).state;
    if (loginstate is Logedin) {
      userId = loginstate.loggedinUserinfo.id!;
    }
    return Scaffold(
      drawer: Drawer(
          child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: Stack(
              children: [
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 130, left: 20),
                  child: Text(
                    "AMP final project",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30, left: 20),
                  child: CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.person),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Account Setting"),
            onTap: () {
              Navigator.pushNamed(context, '/accountsettings');
            },
          ),
        ],
      )),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white12,
        iconTheme: IconThemeData(color: Colors.black87),
        title: Text("Search",
            style: TextStyle(
              color: Colors.black,
            )),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: PopupMenuButton(
                onSelected: (value) {
                  switch (value) {
                    case 1:
                      BlocProvider.of<LoginBloc>(context).add(LogoutEvent());
                      Navigator.pushNamed(context, '/');
                      break;
                    case 2:
                      Navigator.pushNamed(context, "/accountsettings");
                      break;
                    case 3:
                      Navigator.pushNamed(context, "/addholyplace");
                      break;
                    case 4:
                      Navigator.pushNamed(context, "/addschudule");
                      break;
                    case 5:
                      BlocProvider.of<ScheduleBloc>(context).add(
                        GetRepSchedules(userId),
                      );
                      Navigator.pushNamed(context, "/allprograms");
                      break;
                  }
                },
                offset: Offset(5, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Color(0xff757575),
                elevation: 10,
                icon: Icon(
                  Icons.circle,
                  size: 40,
                  color: Colors.blueGrey,
                ),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                        value: 1,
                        child: Text(
                          "logout",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        )),
                    PopupMenuItem(
                      value: 2,
                      child: Text(
                        "my Account",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    PopupMenuItem(
                        value: 3,
                        child: Text(
                          "Add holypalce",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        )),
                    PopupMenuItem(
                        value: 4,
                        child: Text(
                          "add schedule",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        )),
                    PopupMenuItem(
                        value: 5,
                        child: Text(
                          "posted Schedules",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        )),
                  ];
                }),
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset('assets/images/background.jpg',
                  fit: BoxFit.cover)),
          Center(
            child: Text(
              "Representive screen.",
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 23,
              ),
            ),
          )
        ],
      ),
    );
  }
}
