import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:yoyo/screens/home_screens.dart';
import 'package:yoyo/screens/welcome_screens.dart';

void main(){
  runApp(myApp());
}



class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: welcome()),);
  }
}
