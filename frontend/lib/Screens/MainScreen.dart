import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/ApplicationState/Bloc/Holyplace/blocs.dart';
import 'package:frontend/ApplicationState/Bloc/Holyplace/holyplace_bloc.dart';
import 'package:frontend/ApplicationState/Bloc/Login/blocs.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/ApplicationState/Bloc/Schedule/Schedule_bloc.dart';
import 'package:frontend/ApplicationState/Bloc/Schedule/blocs.dart';
import 'package:frontend/ApplicationState/Bloc/subscription/subscription_bloc.dart';
import 'package:frontend/Models/models.dart';
import 'package:frontend/Screens/DetailPage.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    String id = "";
    var loginstate = BlocProvider.of<LoginBloc>(context).state;
    var holyplacesstate = BlocProvider.of<HolyPlaceBloc>(context);
    if (loginstate is Logedin) {
      id = loginstate.loggedinUserinfo.id!;
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
              title: Text("Account Settings"),
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
              child: BlocBuilder<ScheduleBloc, ScheduleState>(
                builder: (context, state) {
                  if (state is NotSeenNumberFound) {
                    return Stack(children: [
                      IconButton(
                        icon: Icon(Icons.notifications,
                            size: 40, color: Colors.grey),
                        onPressed: () {
                          BlocProvider.of<ScheduleBloc>(context)
                              .add(GetNotSeenSchedules(id));
                          Navigator.pushNamed(context, '/allprograms');
                        },
                      ),
                      state.notSeenNumber > 0
                          ? Positioned(
                              right: 1,
                              top: 20,
                              child: new Container(
                                padding: EdgeInsets.all(2),
                                decoration: new BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 14,
                                  minHeight: 14,
                                ),
                                child: Text(
                                  '${state.notSeenNumber}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          : Container(),
                    ]);
                  }
                  return Container();
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 10),
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state is Logedin) {
                    return PopupMenuButton(
                        onSelected: (value) {
                          switch (value) {
                            case 1:
                              BlocProvider.of<LoginBloc>(context)
                                  .add(LogoutEvent());
                              Navigator.pushNamed(context, '/');
                              break;
                            case 2:
                              Navigator.pushNamed(context, "/accountsettings");
                              break;
                            case 3:
                              BlocProvider.of<SubscriptionBloc>(context).add(
                                  GetlAllSubscriptions(
                                      id: state.loggedinUserinfo.id!));

                              Navigator.pushNamed(context, "/allscubscription");
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
                                  "All Subscription ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ))
                          ];
                        });
                  }
                  return Container();
                },
              ),
            )
          ],
        ),
        body: Container(
          child: BlocBuilder(
            bloc: holyplacesstate,
            builder: (BuildContext context, HolyPlaceState state) {
              if (state is LoadingHolyPlaces) {
                return Center(
                  child: SpinKitDualRing(
                    color: Colors.black,
                    size: 50,
                  ),
                );
              }

              if (state is OnHolyPlaceLoadSuccess) {
                return Container(
                  margin: EdgeInsets.only(top: 10),
                  child: ListView.builder(
                    itemCount: state.allholyplaces.length,
                    itemBuilder: (context, int index) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(15),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2,
                        child: Card(
                          elevation: 15,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Text(
                                  "${state.allholyplaces[index]['name']}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.pinkAccent,
                                      fontFamily: 'Montserrat',
                                      fontSize: 25),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Image.network(
                                      (state.allholyplaces[index]['image'] !=
                                              null)
                                          ? state.allholyplaces[index]['image']
                                          : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROGVlwDhbC-6RixbdgEwDrABJ6BD3hhM2eJA&usqp=CAU",
                                      fit: BoxFit.cover, errorBuilder: (context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                    return const Text('Sorry Image not found ');
                                  }),
                                ),
                              ),
                              BlocBuilder<LoginBloc, LoginState>(
                                builder: (context, ontapState) {
                                  if (ontapState is Logedin) {
                                    return Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          print(
                                              "representative ${state.allholyplaces[index]['createdby']}");
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => DetailPage(
                                                  hollyplace: state
                                                      .allholyplaces[index],
                                                  userId: ontapState
                                                      .loggedinUserinfo.id!,
                                                  subscribed: state
                                                      .allholyplaces[index]
                                                          ['createdby']
                                                          ['allsubscriber']
                                                      .contains(ontapState
                                                          .loggedinUserinfo
                                                          .id)),
                                            ),
                                          );
                                          // Navigator.pushNamed(
                                          //   context,
                                          //   '/detailpage',
                                          // );
                                        },
                                        child: Text(
                                          "more ...",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    );
                                  }
                                  return Container();
                                },
                              ),
                              BlocListener<SubscriptionBloc, SubscriptionState>(
                                listener: (_, subState) {
                                  if (subState is Subscribed) {
                                    // ScaffoldMessenger.of(context).showSnackBar(
                                    //   SnackBar(
                                    //     elevation: 10,
                                    //     duration:Duration(seconds: 2),
                                    //     content: Text(
                                    //       "Subscirption sucess",
                                    //       style: TextStyle(
                                    //           backgroundColor: Colors.green),
                                    //     ),
                                    //   ),
                                    // );
                                    BlocProvider.of<HolyPlaceBloc>(context)
                                        .add(LoadingHolyPlacesEvent());
                                    BlocProvider.of<ScheduleBloc>(context)
                                        .add(GetNotSeenNumber(id));
                                  }
                                },
                                child: BlocBuilder<LoginBloc, LoginState>(
                                  builder: (context, logedInState) {
                                    if (logedInState is Logedin) {
                                      return Expanded(
                                        child: Container(
                                          child: ElevatedButton(
                                            child: state.allholyplaces[index]
                                                        ['createdby']
                                                        ['allsubscriber']
                                                    .contains(logedInState
                                                        .loggedinUserinfo.id)
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Icon(Icons.check),
                                                      Text("subscribed")
                                                    ],
                                                  )
                                                : Text("Subscribe"),
                                            onPressed:
                                                state.allholyplaces[index]
                                                            ['createdby']
                                                            ['allsubscriber']
                                                        .contains(logedInState
                                                            .loggedinUserinfo
                                                            .id)
                                                    ? () {}
                                                    : () {
                                                        print(
                                                            "allHolyPlaces: ${state.allholyplaces}");
                                                        User currentUser =
                                                            logedInState
                                                                .loggedinUserinfo;
                                                        BlocProvider.of<
                                                                    SubscriptionBloc>(
                                                                context)
                                                            .add(
                                                          Subscribe(
                                                            subscriptionModel:
                                                                SubscriptionModel(
                                                                    state.allholyplaces[index]
                                                                            [
                                                                            'createdby']
                                                                        ['_id'],
                                                                    currentUser
                                                                        .id),
                                                          ),
                                                        );
                                                      },
                                            style: ElevatedButton.styleFrom(
                                              primary: state
                                                      .allholyplaces[index]
                                                          ['createdby']
                                                          ['allsubscriber']
                                                      .contains(logedInState
                                                          .loggedinUserinfo.id)
                                                  ? Colors.blueAccent
                                                  : Colors.red,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    return Container();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
              return Text("noting found!");
            },
          ),
        ));
  }
}
