import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white12,
          iconTheme: IconThemeData(color: Colors.black87),
          // automaticallyImplyLeading: false,
          actions: [Icon(Icons.logout)],
        ),
        body: Column(
          children: [
            Container(
              child: Center(
                child: Text("Dear Admin, Well come back."),
              ),
            ),
          ],
        ));
  }
}
