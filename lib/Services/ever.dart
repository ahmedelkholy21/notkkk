import 'package:flutter/material.dart';

class Every extends StatelessWidget {
  const Every({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("تواصل معنا "),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          textAlign: TextAlign.right,
            '''  “مبادرة سلمى البراك” تهدف إلى دعم ومساعدة ذوي الإعاقة السمعية على النطق، من خلال تقديم التوجيه والبرامج التي تساعدهم على تحسين مهارات التواصل.
      
      للتواصل معنا:
        •	البريد الإلكتروني: notkcontact@gmail.com
        •	رقم الجوال: 0542309930 ''',style: TextStyle(fontSize: 18),),
      ),
    );
  }
}
