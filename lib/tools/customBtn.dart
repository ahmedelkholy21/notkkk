// ignore: file_names
import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final double width;

  const CustomBtn(
      {super.key,
      required this.onPressed,
      required this.text,
      this.width = 0.3});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      elevation: 10,
      minWidth: MediaQuery.of(context).size.width * width,
      height: 60,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30.0),
        ),
        borderSide: BorderSide(
          color: Color(0xff1EA3CD),
          width: 2.0,
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 19,
            color: Color(0xff1EA3CD),
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
