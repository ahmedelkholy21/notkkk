import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Child extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  Child({Key? key, required this.txt1, required this.txt2, required this.img})
      : super(key: key);

  final String txt1;
  final String txt2;
  final String img;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 8,left: 8),
          child: Column(
            //      mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/image/نطق.png',
                height: MediaQuery.of(context).size.height/6,
                width: MediaQuery.of(context).size.width/2,
              ),
              SvgPicture.asset(
                img,
                height: MediaQuery.of(context).size.height/3,
                width: 300,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                txt1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
     );
  }
}
