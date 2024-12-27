// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:notkk/Services/ac.dart';
import 'package:notkk/Services/sound.dart';
import 'package:notkk/Services/speaker.dart';
import 'package:notkk/Services/tt.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: MediaQuery.of(context).size.height / 7,
              width: MediaQuery.of(context).size.width / 3,
              child: Image.asset(
                'lib/image/نطق.png',
              ),
            ),
            const Text(
              "الخدمات الصوتية ",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: .8,
                children: [
                  inkgrid(
                    img: 'lib/image/eng.svg',
                    txt: "نطق الحروف بالانجليزية",
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => MyGrid1()));
                    },
                  ),
                  inkgrid(
                    img: 'lib/image/ara.svg',
                    txt: "نطق الحروف بالعربيه",
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => MyGrid()));
                    },
                  ),
                  inkgrid(
                    img: 'lib/image/Group.svg',
                    txt: "قياس الصوت",
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SoundWithGauge()));
                    },
                  ),
                  inkgrid(
                    img: 'lib/image/conv.svg',
                    txt: "تحويل الكلام الي نص",
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Speaker()));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class inkgrid extends StatelessWidget {
  const inkgrid(
      {super.key,
      required this.img,
      required this.txt,
      required this.onPressed});
  final String img;
  final String txt;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(12),
        height: MediaQuery.of(context).size.height / 1.5,
        width: 120,
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
            color: const Color(0xff1EA3CD),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: SvgPicture.asset(
                img,
                height: MediaQuery.of(context).size.height / 3,
                width: 150,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 1,
              child: Text(
                txt,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
