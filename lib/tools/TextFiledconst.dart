// ignore_for_file: file_names

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFiledconst extends StatefulWidget {
  const TextFiledconst(
      {super.key,
      this.pw = false,
      this.onChanged,
      this.validator,
      required this.controller,
      required this.text});
  final TextEditingController controller;
  final String text;
  final bool pw;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;

  // final IconData icon;

  @override
  State<TextFiledconst> createState() => _TextFiledconstState();
}

class _TextFiledconstState extends State<TextFiledconst> {
  bool obs = true;

  @override
  void initState() {
    obs = widget.pw;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      onChanged: widget.onChanged,
      style: const TextStyle(fontSize: 20),
      obscureText: obs,
      decoration: InputDecoration(
          suffixIcon: widget.pw
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      obs = !obs;
                    });
                  },
                  icon: Icon(obs
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined),
                  color: Color(0xff1EA3CD),
                )
              : null,
          hintText: widget.text,
          hintTextDirection: TextDirection.rtl,
          hintStyle: const TextStyle(
              fontSize: 18, color: Color.fromARGB(255, 94, 86, 86))),
    );
  }
}
