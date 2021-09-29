import 'package:flutter/material.dart';
import 'package:frontend/Models/models.dart';
import 'package:frontend/Routes/Routes.dart';
import 'screens.dart';
import 'package:frontend/Widgets/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final List<String> image_list = [
    "https://i.pinimg.com/236x/18/3a/a8/183aa8c43002bd1ea592211dc1baf87c.jpg",
    "https://i.pinimg.com/236x/33/00/d3/3300d3068ea887185ff025eb9ad7fd43.jpg",
    "https://i.pinimg.com/236x/68/29/16/6829163469056c898d686dbf24865a22.jpg",
    "https://i.pinimg.com/236x/28/85/cb/2885cb3a0b18ae38908ac1cff7773ba1.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent.withAlpha(200),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text(
              "Religious Daily Schedule Notifier",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 23,
              ),
            ),
          ),
          Container(
              child: CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height / 2,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 2),
              autoPlayCurve: Curves.slowMiddle,
              enlargeCenterPage: false,
            ),
            items: image_list
                .map((item) => Container(
                      margin: EdgeInsets.all(10),
                      child: Center(
                          child: Image.network(item,
                              fit: BoxFit.cover, width: 1000)),
                    ))
                .toList(),
          )),
          Hero(
            tag: "loginTag",
            child: CustomRoundButton(
              onPressedfun: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              backroundcolor: Colors.red,
              displaytext: Text(
                "Login",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          Hero(
            tag: "Registertag",
            child: CustomRoundButton(
              onPressedfun: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterController(
                      argument: AuthArgument(user: User("",""),update: false),
                    ),
                  ),
                );
              },
              backroundcolor: Colors.blue,
              displaytext: Text(
                "Register",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
