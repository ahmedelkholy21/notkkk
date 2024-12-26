import 'package:flutter/material.dart';
import 'package:notkk/Services/Home.dart';
import 'package:notkk/Services/more.dart';
import 'package:notkk/Services/profile.dart';

class Welcomescreen extends StatefulWidget {
  const Welcomescreen({super.key});

  @override
  State<Welcomescreen> createState() => _WelcomescreenState();
}

class _WelcomescreenState extends State<Welcomescreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const Home(),
    ProfilePage(),
    More(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // منع العودة للخلف
  Future<bool> _onWillPop() async {
    return false; // عدم السماح بالرجوع إلى الخلف
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop, // ربط حدث الرجوع
      child: Scaffold(
        extendBody: true,
        body: _pages[_currentIndex],
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xff1EA3CD),
          onPressed: () {
            setState(() {
              _currentIndex = 2; // التنقل إلى صفحة الإعدادات عند الضغط على الزر العائم
            });
          },
          child: const Icon(Icons.settings, color: Colors.white),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 70,
          color: const Color(0xff1EA3CD),
          shape: const CircularNotchedRectangle(),
          notchMargin: 7,
          child: Padding(
            padding: const EdgeInsets.only(right: 25, left: 25),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    _onItemTapped(0); // التنقل إلى الصفحة الرئيسية
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.home,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 8),
                          Visibility(
                            visible: _currentIndex == 0,
                            child: const Text(
                              "الرئيسيه",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _onItemTapped(1); // التنقل إلى صفحة الملف الشخصي
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 8),
                          Visibility(
                            visible: _currentIndex == 1,
                            child: const Text(
                              "الملف الشخصي",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
