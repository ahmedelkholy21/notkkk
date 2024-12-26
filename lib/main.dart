import 'package:flutter/material.dart';
import 'package:notkk/Services/welcome.dart';
 import 'package:notkk/splach/intro_1.dart';
 
void main() {
  runApp(const MyApp());
}

 class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,home: SplashScreen(),);
  }
}