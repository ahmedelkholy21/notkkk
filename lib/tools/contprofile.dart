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
   Color _containerColor = Colors.transparent;

   void _changeColorTemporarily() {
    setState(() {
      _containerColor = Color(0xff1EA3CD);  
    });

     Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _containerColor = Colors.transparent;   
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
         _changeColorTemporarily();

         if (widget.onPressed != null) {
          widget.onPressed!();
        }
      },
      child: Container(
        margin:   EdgeInsets.only(top: 20,bottom: 7, left: 15, right: 15),
        decoration: BoxDecoration(
          color: _containerColor,  
          border: Border.all(color: Color(0xff1EA3CD)),  
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const Spacer(
              flex: 1,
            ),
                Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset(
                widget.con,
                
                height:  MediaQuery.of(context).size.height/25,
                width: 40,
              ),
            ),
          
            const Spacer(
              flex: 22,
            ),
              Text(
              widget.txt,
              style: const TextStyle(fontSize: 24),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: SvgPicture.asset(
            //     widget.con,
                
            //     height:  MediaQuery.of(context).size.height/30,
            //     width: 30,
            //   ),
            // ),
            const SizedBox(
              width: 15,
            )
          ],
        ),
      ),
    );
  }
}
