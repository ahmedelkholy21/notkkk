// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:notkk/Services/ever.dart';
import 'package:notkk/Services/privite.dart';
import 'package:notkk/sign/login.dart';
import 'package:notkk/tools/contprofile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class More extends StatelessWidget {
  const More({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
            child: Text(
          "الاعدادات",
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
      ),
      body: Column(
        children: [
          // SizedBox(
          //   height: MediaQuery.of(context).size.height/20,
          // ),
          ContProfile(
              con: 'lib/image/Group 36165.svg',
              txt: "تغير كلمة السر",
              onPressed: () {}),
          ContProfile(
              con: 'lib/image/syasa.svg',
              txt: "سياسة الخصوصية",
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Privite()));
              }),
          ContProfile(
              con: 'lib/image/conect.svg',
              txt: "تواصل معنا",
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Every()));
              }),
          ContProfile(
              con: 'lib/image/passcet.svg', txt: "حذف حساب ", onPressed: () {}),
          ContProfile(
              con: 'lib/image/sign-out-alt (1) 1.svg',
              txt: "تسجيل الخروج",
              onPressed: () async {
                await AwesomeDialog(
                  context: context,
                  dialogType: DialogType.noHeader,
                  //   animType: AnimType.rightSlide,
                  btnCancelText: "الغاء",
                  buttonsTextStyle: TextStyle(
                    color: Colors.white,
                  ),
                  btnOkText: "تسجيل خروج",

                  btnCancelColor: Color(0xff1EA3CD),
                  btnOkColor: Color(0xff1EA3CD),
                  title: 'تسجيل الخروج',
                  titleTextStyle:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  desc:
                      "هل انت متأكد من تسجيل الخروج ؟\n____________________________",
                  descTextStyle: TextStyle(fontSize: 18),
                  btnCancelOnPress: () {},
                  btnOkOnPress: () async {
                    SharedPreferences sp =
                        await SharedPreferences.getInstance();
                    sp.setBool('login', false);
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Login()));
                  },
                ).show();
              }),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
