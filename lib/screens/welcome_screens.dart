import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:yoyo/screens/home_screens.dart';

class welcome extends StatefulWidget {
  const welcome({super.key});

  @override
  State<welcome> createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {

  @override
  void initState(){
    super.initState();
    startTime();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0XFF444446),
        body: SafeArea(
          child: Stack(
            children: [
              RiveAnimation.asset('assets/background.riv'),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 100, sigmaX: 100),
                child: RiveAnimation.asset('assets/document.riv'),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width/15,
                top: MediaQuery.of(context).size.width/1.7,
                child: Card(
                  color: Colors.transparent,
                  elevation: 500,
                  child:Text(
                    'Yoyo',
                    style: TextStyle(fontSize: 100, color: Colors.white),
                  ),

                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width/8,
                top: MediaQuery.of(context).size.width/1.1,
                child: Card(
                  color: Colors.transparent,
                  elevation: 500,
                  shadowColor: Colors.black,
                  child: Text(
                    'Your trusted notepad',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),

                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future<Timer> startTime() async {
    var duration =  Duration(seconds: 5);
    return  Timer(duration, route);
  }

  route(){
    Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context)=> homeScreens()));
  }
}
