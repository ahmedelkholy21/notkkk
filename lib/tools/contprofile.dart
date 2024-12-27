// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContProfile extends StatefulWidget {
  ContProfile({
    super.key,
    required this.con,
    required this.txt,
    required this.onPressed,
  });

  String con;
  void Function()? onPressed;
  String txt;

  @override
  // ignore: library_private_types_in_public_api
  _ContProfileState createState() => _ContProfileState();
}

class _ContProfileState extends State<ContProfile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onPressed != null) {
          widget.onPressed!();
        }
      },
      child: Container(
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
        margin: EdgeInsets.only(top: 7, bottom: 7, left: 15, right: 15),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Color(0xff1EA3CD)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.txt,
              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            SvgPicture.asset(
              widget.con,
              height: MediaQuery.of(context).size.height / 25,
              width: 40,
            ),
          ],
        ),
      ),
    );
  }
}
