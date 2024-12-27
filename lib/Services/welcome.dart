import 'package:flutter/material.dart';
import 'package:notkk/Services/Home.dart';
import 'package:notkk/Services/more.dart';
import 'package:notkk/Services/profile.dart';
import 'package:notkk/tools/custom_home_bar.dart';

class Welcomescreen extends StatefulWidget {
  const Welcomescreen({super.key});

  @override
  State<Welcomescreen> createState() => _WelcomescreenState();
}

class _WelcomescreenState extends State<Welcomescreen> {
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: [
                const Home(),
                More(),
                ProfilePage(),
              ],
            ),
          ),
          CustomBottomBar(pageController: _pageController)
        ],
      ),
    );
  }
}
