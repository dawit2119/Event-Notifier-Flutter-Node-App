import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/ApplicationState/Bloc/Login/blocs.dart';
import 'package:frontend/ApplicationState/Bloc/Schedule/blocs.dart';
import 'package:frontend/Models/Schedule.dart';
import 'package:frontend/Widgets/Button.dart';
import 'package:frontend/Widgets/CustomTextField.dart';

class AddOrUpdateSchedule extends StatelessWidget {
  AddOrUpdateSchedule({Key? key, required this.scheduleArgument})
      : super(key: key);
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final programOneController = TextEditingController();
  final programTwoController = TextEditingController();
  final ProgramThreeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ScheduleArgument scheduleArgument;

  @override
  Widget build(BuildContext context) {
    Schedule sch;
    bool isUpdate = scheduleArgument.update;
    if (isUpdate) {
      sch = scheduleArgument.schedule!;
      var allPrograms = sch.allprograms!.split(',');
      titleController.text = sch.title!;
      descriptionController.text = sch.description!;
      programOneController.text = allPrograms[0];
      programTwoController.text = allPrograms[1];
      ProgramThreeController.text = allPrograms[2];
    } else
      sch = Schedule('', '');
    String userId = '';
    LoginState userState = BlocProvider.of<LoginBloc>(context).state;
    if (userState is Logedin) {
      userId = userState.loggedinUserinfo.id!;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isUpdate ? "UPdate Schedule" : "Add Schedule",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Card(
            elevation: 10,
            child: ListView(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  isUpdate ? "Update Schedule" : "Add Schedule",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.pinkAccent,
                    fontFamily: 'Montserrat',
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 100,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomTextField(
                        labelText: "title",
                        textEditingController: titleController,
                        icondata: Icon(Icons.title),
                        isValid: (value) {
                          if (value!.isEmpty) {
                            return "provide conscise title";
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        labelText: "description",
                        textEditingController: descriptionController,
                        icondata: Icon(Icons.description),
                        isValid: (value) {
                          if (value!.isEmpty) {
                            return "provide description";
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        labelText: "program one,specify time",
                        textEditingController: programOneController,
                        icondata: Icon(Icons.schedule),
                        isValid: (value) {
                          if (value!.isEmpty) {
                            return "this field is required";
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        labelText: "program two,specify time",
                        textEditingController: programTwoController,
                        icondata: Icon(Icons.schedule),
                        isValid: (value) {
                          if (value!.isEmpty) {
                            return "this field is required";
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        labelText: "program three,specify time",
                        textEditingController: ProgramThreeController,
                        icondata: Icon(Icons.schedule),
                        isValid: (value) {
                          if (value!.isEmpty) {
                            return "this field is required";
                          }
                          return null;
                        },
                      ),
                      CustomRoundButton(
                          backroundcolor:
                              isUpdate ? Colors.yellowAccent : Colors.blue,
                          displaytext: Text(
                              isUpdate ? "Update Schedule" : "Add Schdule"),
                          onPressedfun: () {
                            var form = _formKey.currentState;
                            if (form!.validate()) {
                              var schedule = Schedule(
                                  userId,
                                  [
                                    programOneController.text,
                                    programTwoController.text,
                                    ProgramThreeController.text
                                  ].join(','),
                                  id: sch.id,
                                  title: titleController.text,
                                  description: descriptionController.text);
                              isUpdate
                                  ? BlocProvider.of<ScheduleBloc>(context)
                                      .add(UpdateSchedule(schedule))
                                  : BlocProvider.of<ScheduleBloc>(context)
                                      .add(AddScheduleEvent(schedule));
                            }
                          }),
                    ],
                  ),
                ),
                BlocConsumer<ScheduleBloc, ScheduleState>(
                  listener: (context, state) {
                    BlocProvider.of<ScheduleBloc>(context).add(
                      GetRepSchedules(userId),
                    );
                    if (state is ScheduleCrudSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  builder: (_, state) {
                    if (state is ScheduleOperationsInProgress) {
                      return SpinKitDualRing(
                        color: Colors.black,
                        size: 50,
                      );
                    }
                    if (state is ScheduleCrudFailed) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(state.message),
                          InkWell(
                              onTap: () =>
                                  BlocProvider.of<ScheduleBloc>(context)
                                      .add(GetInitialState()),
                              child: Text(
                                " Try again",
                                style: TextStyle(color: Colors.blue),
                              )),
                          InkWell(
                              onTap: () => Navigator.pop(context),
                              child: Text(
                                " back",
                                style: TextStyle(color: Colors.pinkAccent),
                              ))
                        ],
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
