import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pharmacy_talk/on_bording_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 5), (() {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => OnBordingScreen()));
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/happy.png" , width: double.infinity , height: double.infinity,)//CircleAvatar,
      ),
    );
  }
}