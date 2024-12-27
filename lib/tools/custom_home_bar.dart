// ignore_for_file: slash_for_doc_comments, deprecated_member_use

import 'package:flutter/material.dart';

class CustomBottomBar extends StatefulWidget {
  final PageController pageController;
  const CustomBottomBar({super.key, required this.pageController});

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  int currentIndex = 0;
  setBottomBarIndex(index) {
    widget.pageController.jumpToPage(index);
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        ClipPath(
          clipper: BNBCustomClipper(),
          child: Container(
            decoration: BoxDecoration(
                color: Color(0xff1EA3CD),
                borderRadius: BorderRadius.circular(15)),
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.all(10),
            width: size.width,
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: size.width * 0.35,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: currentIndex == 0
                            ? Colors.white.withOpacity(0.2)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(15)),
                    child: GestureDetector(
                      onTap: () {
                        setBottomBarIndex(0);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.home, size: 25, color: Colors.white),
                          Visibility(
                              visible: currentIndex == 0,
                              child: const SizedBox(width: 4)),
                          Visibility(
                            visible: currentIndex == 0,
                            child: Text(
                              'الرئيسيه',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.35,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: currentIndex == 2
                            ? Colors.white.withOpacity(0.2)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(15)),
                    child: GestureDetector(
                      onTap: () {
                        setBottomBarIndex(2);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person, size: 25, color: Colors.white),
                          Visibility(
                              visible: currentIndex == 2,
                              child: const SizedBox(width: 4)),
                          Visibility(
                            visible: currentIndex == 2,
                            child: Text(
                              "حسابي",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Center(
          heightFactor: 0.2,
          child: GestureDetector(
            onTap: () {
              setBottomBarIndex(1);
            },
            child: Container(
              width: size.width * 0.24,
              height: size.height * 0.072,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff73CBE6),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.settings, size: 40, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

class BNBCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 0);
    path.arcToPoint(
      Offset(size.width * 0.60, 10),
      radius: const Radius.circular(10.0),
      clockwise: false,
    );
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 10);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
