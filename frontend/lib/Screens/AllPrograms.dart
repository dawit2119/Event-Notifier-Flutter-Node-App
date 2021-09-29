import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/ApplicationState/Bloc/Login/Login_bloc.dart';
import 'package:frontend/ApplicationState/Bloc/Login/Login_state.dart';
import 'package:frontend/ApplicationState/Bloc/Schedule/blocs.dart';
import 'package:frontend/Models/Schedule.dart';
import 'package:frontend/Screens/screens.dart';
import 'package:frontend/Utilities/textStyles.dart';
import 'package:frontend/Widgets/Button.dart';

class AllPrograms extends StatelessWidget {
  const AllPrograms({Key? key, this.hollyplaceName}) : super(key: key);
  final String? hollyplaceName;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<ScheduleBloc, ScheduleState>(
        builder: (context, state) {
          if (state is LoadingSchedules) {
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SpinKitDualRing(
                  color: Colors.lightBlue,
                  size: 30,
                ),
              ),
            );
          }
          if (state is NotSeenSchedulesAreLoaded) {
            String id = "";
            var loggedUser = BlocProvider.of<LoginBloc>(context).state;
            if (loggedUser is Logedin) {
              id = loggedUser.loggedinUserinfo.id!;
            }
            return state.schedules.length == 0
                ? Scaffold(
                    appBar: AppBar(
                      leading: IconButton(
                        onPressed: () {
                          BlocProvider.of<ScheduleBloc>(context)
                              .add(GetNotSeenNumber(id));
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back),
                      ),
                    ),
                    body: Center(
                      child: Text("There is no new Schedule"),
                    ),
                  )
                : DefaultTabController(
                    length: state.schedules.length,
                    child: Builder(builder: (BuildContext context) {
                      var scheduleLength = state.schedules.length;
                      var plength = [];
                      for (int i = 0; i < scheduleLength; i++) {
                        plength.add(i);
                      }
                      return Scaffold(
                        appBar: AppBar(
                          leading: IconButton(
                            onPressed: () {
                              BlocProvider.of<ScheduleBloc>(context)
                                  .add(GetNotSeenNumber(id));
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back),
                          ),
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "New Schedules",
                                style: TextStyle(
                                    color: Colors.amberAccent, fontSize: 20),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                          iconTheme: IconThemeData(color: Colors.black87),
                          elevation: 0,
                          backgroundColor: Colors.white,
                          bottom: TabBar(
                              indicatorColor: Colors.pinkAccent,
                              indicatorWeight: 4,
                              isScrollable: true,
                              indicatorSize: TabBarIndicatorSize.label,
                              tabs: plength
                                  .map(
                                    (e) => Text(
                                      "${state.schedules[e]['hollyplacename']}", //
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.blueGrey),
                                    ),
                                  )
                                  .toList()),
                        ),
                        body: TabBarView(
                          children: plength
                              .map((e) => Program(
                                      title: state.schedules[e]['_doc']
                                          ['title'],
                                      description: state.schedules[e]['_doc']
                                          ['description'],
                                      createdat: state.schedules[e]['_doc']
                                          ['createdAt'],
                                      programs: [
                                        "${state.schedules[e]['_doc']['programs'][0]}",
                                        "${state.schedules[e]['_doc']['programs'][1]}",
                                        "${state.schedules[e]['_doc']['programs'][2]}",
                                      ])) //this will be state.allschedules[e - 1]['programs']
                              .toList(),
                        ),
                      );
                    }),
                  );
          }

          if (state is OnScheduleLoadSuccess) {
            return DefaultTabController(
              length: state.allschedules.length,
              child: Builder(
                builder: (BuildContext context) {
                  var scheduleLength = state.allschedules.length;
                  var plength = [];
                  for (int i = 0; i < scheduleLength; i++) {
                    plength.add(i + 1);
                  }
                  return state.allschedules.length == 0
                      ? Scaffold(
                          appBar: AppBar(),
                          body: Center(
                            child: Text("No schedule for this holyplace"),
                          ))
                      : Scaffold(
                          appBar: AppBar(
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "All Programms",
                                  style: TextStyle(
                                      color: Colors.amberAccent, fontSize: 20),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "$hollyplaceName",
                                  style: TextStyle(
                                      color: Colors.amberAccent, fontSize: 18),
                                ),
                              ],
                            ),
                            iconTheme: IconThemeData(color: Colors.black87),
                            elevation: 0,
                            backgroundColor: Colors.white,
                            bottom: TabBar(
                                indicatorColor: Colors.pinkAccent,
                                indicatorWeight: 4,
                                isScrollable: true,
                                indicatorSize: TabBarIndicatorSize.label,
                                tabs: plength
                                    .map(
                                      (e) => Text(
                                        "Schedule $e", //
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.blueGrey),
                                      ),
                                    )
                                    .toList()),
                          ),
                          body: TabBarView(
                              children: plength
                                  .map((e) => Program(
                                      title: state.allschedules[e - 1]['title'],
                                      description: state.allschedules[e - 1]
                                          ['description'],
                                      createdat: state.allschedules[e - 1]
                                          ['createdAt'],
                                      programs: state.allschedules[e - 1][
                                          'programs'])) //this will be state.allschedules[e - 1]['programs']
                                  .toList()),
                        );
                },
              ),
            );
          }
          ///////////////////////
          if (state is RepSchedulesAreLoaded) {
            return DefaultTabController(
              length: state.postedSchedules.length,
              child: Builder(
                builder: (BuildContext context) {
                  var scheduleLength = state.postedSchedules.length;
                  var plength = [];
                  for (int i = 0; i < scheduleLength; i++) {
                    plength.add(i + 1);
                  }
                  return state.postedSchedules.length == 0
                      ? Scaffold(
                          appBar: AppBar(),
                          body: Center(
                            child: Text(
                              "You have no posted Schedules",
                              style: KSubtitle,
                            ),
                          ),
                        )
                      : Scaffold(
                          appBar: AppBar(
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Posted Schedules",
                                  style: TextStyle(
                                      color: Colors.amberAccent, fontSize: 20),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${state.postedSchedules[0]['name']}",
                                  style: TextStyle(
                                      color: Colors.amberAccent, fontSize: 18),
                                ),
                              ],
                            ),
                            iconTheme: IconThemeData(color: Colors.black87),
                            elevation: 0,
                            backgroundColor: Colors.white,
                            bottom: TabBar(
                                indicatorColor: Colors.pinkAccent,
                                indicatorWeight: 4,
                                isScrollable: true,
                                indicatorSize: TabBarIndicatorSize.label,
                                tabs: plength
                                    .map(
                                      (e) => Text(
                                        "Schedule $e", //
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.blueGrey),
                                      ),
                                    )
                                    .toList()),
                          ),
                          body: TabBarView(
                              children: plength
                                  .map((e) => Program(
                                        isRep: true,
                                        id: state.postedSchedules[e - 1]['_doc']
                                            ['_id'],
                                        createdby: state.postedSchedules[e - 1]
                                            ['_doc']['createdby'],
                                        title: state.postedSchedules[e - 1]
                                            ['_doc']['title'],
                                        description:
                                            state.postedSchedules[e - 1]['_doc']
                                                ['description'],
                                        programs: state.postedSchedules[e - 1]
                                            ['_doc']['programs'],
                                        createdat: state.postedSchedules[e - 1]
                                            ['_doc']['createdAt'],
                                      ))
                                  .toList()),
                        );
                },
              ),
            );
          }
          if (state is FaildLoadingSchedules) {
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: Text(state.message),
              ),
            );
          }
          ;
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Text("Error"),
            ),
          );
        },
      ),
    );
  }
}

class Program extends StatelessWidget {
  const Program({
    Key? key,
    required this.title,
    required this.description,
    required this.createdat,
    required this.programs,
    this.id,
    this.createdby,
    this.isRep = false,
  }) : super(key: key);
  final String title;
  final String description;
  final String createdat;
  final bool isRep;
  final String? createdby;
  final String? id;
  final List<dynamic> programs;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  'Title: ',
                  style: KTitileStyle.copyWith(
                      decoration: TextDecoration.underline),
                ),
                Text(
                  title,
                  style: KSubtitle,
                )
              ],
            ),
            Column(
              children: [
                Text(
                  "Description",
                  style: KTitileStyle.copyWith(
                      decoration: TextDecoration.underline),
                ),
                Text(
                  description,
                  style: KSubtitle,
                )
              ],
            ),
            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Text(
                          'Program one',
                          style: KTitileStyle.copyWith(
                              decoration: TextDecoration.underline,
                              fontSize: 15),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Program two',
                          style: KTitileStyle.copyWith(
                              decoration: TextDecoration.underline,
                              fontSize: 15),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Program three',
                          style: KTitileStyle.copyWith(
                              decoration: TextDecoration.underline,
                              fontSize: 15),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Text(
                          programs[0],
                          style: KSubtitle,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          programs[1],
                          style: KSubtitle,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          programs[2],
                          style: KSubtitle,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  "created at",
                  style: KTitileStyle.copyWith(
                      decoration: TextDecoration.underline),
                ),
                Text(
                  createdat.split('T')[0],
                  style: KSubtitle,
                )
              ],
            ),
            isRep
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: CustomRoundButton(
                            backroundcolor: Colors.yellow,
                            displaytext: Text("Update"),
                            onPressedfun: () {
                              var schedule = Schedule(
                                  createdby, programs.join(','),
                                  id: id,
                                  description: description,
                                  title: title);
                                 Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => AddOrUpdateSchedule(
                                    scheduleArgument: ScheduleArgument(
                                        schedule: schedule, update: true),
                                  ),
                                ),
                              );
                            }),
                      ),
                      Expanded(
                        child: CustomRoundButton(
                            backroundcolor: Colors.red,
                            displaytext: Text("Delete"),
                            onPressedfun: () {}),
                      )
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
