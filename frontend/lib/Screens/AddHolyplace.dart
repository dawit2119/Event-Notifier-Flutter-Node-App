import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/ApplicationState/Bloc/Holyplace/blocs.dart';
import 'package:frontend/ApplicationState/Bloc/Login/blocs.dart';
import 'package:frontend/Models/models.dart';
import 'package:frontend/Widgets/Button.dart';
import 'package:frontend/Widgets/CustomTextField.dart';


class HolyPlace extends StatelessWidget {
  HolyPlace({Key? key}) : super(key: key);
  var hollyPlaceController = TextEditingController();
  var locationController = TextEditingController();
  var historyController = TextEditingController();
  var imageUrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String userId = '';
    LoginState userState = BlocProvider.of<LoginBloc>(context).state;
    if (userState is Logedin) {
      userId = userState.loggedinUserinfo.id!;
    }
    return Scaffold(
      appBar: AppBar(),
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
                  "Holyplace form",
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
                        textEditingController: hollyPlaceController,
                        labelText: "Enter name of holyplace",
                        icondata: Icon(Icons.place),
                        isValid: (value) {
                          if (value!.isEmpty) {
                            return "Enter name of holyplace";
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        textEditingController: locationController,
                        labelText: "Enter location ",
                        icondata: Icon(Icons.location_city),
                        isValid: (value) {
                          if (value!.isEmpty) {
                            return "Enter location";
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        textEditingController: historyController,
                        labelText: "Enter  History",
                        icondata: Icon(Icons.history),
                        isValid: (value) {
                          if (value!.isEmpty) {
                            return "Enter  History";
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        textEditingController: imageUrlController,
                        labelText: "Enter Image URL",
                        icondata: Icon(Icons.image),
                        isValid: (value) {
                          if (value!.isEmpty) {
                            return "Enter Image URL";
                          }
                          return null;
                        },
                      ),
                      CustomRoundButton(
                          backroundcolor: Colors.blue,
                          displaytext: Text("Add Holyplace"),
                          onPressedfun: () {
                            var form = _formKey.currentState;
                            if (form!.validate()) {
                              String nameofHolyplace =
                                  hollyPlaceController.text.toString();
                              String location =
                                  locationController.text.toString();
                              String history =
                                  historyController.text.toString();
                              String imageurl =
                                  imageUrlController.text.toString();
                              HolyplaceModel holyplaceModel = HolyplaceModel(
                                userId,
                                nameofHolyplace,
                                history: history,
                                location: location,
                                image: imageurl,
                              );
                              BlocProvider.of<HolyPlaceBloc>(context)
                                  .add(createHolyplaceEvent(holyplaceModel));
                            }
                          }),
                    ],
                  ),
                ),
                BlocConsumer<HolyPlaceBloc, HolyPlaceState>(
                  listener: (context, state) {
                    if (state is onCreateHolyPlaceSucess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Holpyplace added Successfully"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  builder: (_, state) {
                    if (state is LoadingHolyPlaces) {
                      return SpinKitDualRing(
                        color: Colors.black,
                        size: 50,
                      );
                    }
                    if (state is FaildtoCreateHolyplace) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Failed to Add Holyplace"),
                          InkWell(
                            onTap: ()=>BlocProvider.of<HolyPlaceBloc>(context).add(GetIntialState()),
                            child: Text(" Try again",style: TextStyle(color: Colors.blue),))
                          ,InkWell(
                            onTap: ()=>Navigator.pop(context),
                            child: Text(" back",style: TextStyle(color: Colors.pinkAccent),))

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
