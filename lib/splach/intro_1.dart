// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:notkk/Services/welcome.dart';
import 'package:notkk/sign/login.dart';
import 'package:notkk/splach/intro_2.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool introShown = prefs.getBool('intro_shown') ?? false;
    bool remmber = prefs.getBool('login') ?? false;

    if (introShown) {
      if (remmber) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Welcomescreen(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Intro(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff48b7d9),
      body: Center(
        child: Image.asset(
          'lib/image/intr-removebg-preview.png',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
