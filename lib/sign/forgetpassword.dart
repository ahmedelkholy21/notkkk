// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:notkk/base.dart';
import 'package:notkk/sign/forgetconferm.dart';
import 'package:notkk/tools/TextFiledconst.dart';
import 'package:notkk/tools/customBtn.dart';
import 'package:notkk/waiting.dart';

// ignore: must_be_immutable
class Forgetpass extends StatelessWidget {
  Forgetpass({super.key});
  TextEditingController forget = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Center(
                  child: Image.asset(
                'lib/image/نطق.png',
                height: 100,
                width: 100,
              )),
              const Text(
                "  هل نسيت كلمة السر",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    fontSize: 28,
                    color: Color(0xff1EA3CD),
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                textAlign: TextAlign.center,
                "الرجاء إدخال عنوان بريدك الإلكتروني المسجل لإعادة تعيين كلمة المرور الخاصة بك",
                textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: TextFiledconst(
                    controller: forget, text: "البريد الالكتروني"),
              ),
              const SizedBox(
                height: 60,
              ),
              CustomBtn(
                onPressed: () async {
                  waiting(context: context);
                  Map<String, dynamic> forgett = await forgetpw(forget.text);
                  pOP(context);
                  if (forgett['success']) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Forgetconferm(
                              otp: forgett['data']['otp'],
                              id: forgett['data']['id'].toString(),
                            )));
                  } else {
                    AwesomeDialog(
                      descTextStyle:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.rightSlide,
                          btnCancelColor: Color(0xff1EA3CD),
                  btnOkColor: Color(0xff1EA3CD),
                      title: 'نطق',titleTextStyle: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),
                      desc: forgett['message'], 
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {},
                    ).show();
                  }
                },
                text: "تأكيد",
                width: .4,
              )
            ],
          ),
        ),
      ),
    );
  }
}
