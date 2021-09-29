import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/ApplicationState/Bloc/subscription/subscription_bloc.dart';

class AllSubscription extends StatelessWidget {
  const AllSubscription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<SubscriptionBloc, SubscriptionState>(
        builder: (context, state) {
          if (state is SubscriptionInProgress) {
            return Center(
              child: SpinKitDualRing(
                color: Colors.blueGrey,
                size: 50,
              ),
            );
          }
          if (state is AllSubscriptionsFetched) {
            return state.allSubscriptions.length == 0
                ? Center(
                    child: Text(
                    "You are not subscribed to any place",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.pinkAccent,
                      fontFamily: 'Montserrat',
                    ),
                                    ))
                : ListView.builder(
                    itemCount: state.allSubscriptions.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        margin: EdgeInsets.symmetric(vertical: 5),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2,
                        child: Card(
                          elevation: 10,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                state.allSubscriptions[index]['name'],
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.pinkAccent,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              Image.network(
                                  (state.allSubscriptions[index]['image'] !=
                                          null)
                                      ? state.allSubscriptions[index]['image']
                                      : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROGVlwDhbC-6RixbdgEwDrABJ6BD3hhM2eJA&usqp=CAU",
                                  height: 150,fit: BoxFit.contain, errorBuilder: (context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                return const Text('Sorry Image not found ');
                              }),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(color: Colors.grey),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      simpleText(
                                          label: "Location: ", fontSize: 20),
                                      simpleText(
                                          label: state.allSubscriptions[index]
                                              ['location'],
                                          fontSize: 20),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(color: Colors.grey),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      simpleText(
                                          label: "History: ", fontSize: 20),
                                      simpleText(
                                          label: state.allSubscriptions[index]
                                              ['history'],
                                          fontSize: 20),
                                    ],
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("Back"),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.pinkAccent),
                              )
                            ],
                          ),
                        ),
                      );
                    });
          }
          return Center(
              child: Container(
            child: Text("Failed to fetch subscriptions"),
          ));
        },
      ),
    );
  }

  Widget simpleText({required String label, required double fontSize}) {
    return Expanded(
      child: Text(
        "$label",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.pinkAccent,
            fontFamily: 'Montserrat',
            fontSize: fontSize),
      ),
    );
  }
}
