import 'dart:async';

import 'package:flutter/material.dart';
import 'package:market_watch/view/bottom_nav/main_bottom.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
        return BottomNavFirstPage();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        //splash screen image
        child: Image.asset(
        'assets/splash1.png', 
           width: MediaQuery.of(context).size.width, 
        height: MediaQuery.of(context).size.height, 
        fit: BoxFit.cover, 
        ),
      ),
    );
  }
}
