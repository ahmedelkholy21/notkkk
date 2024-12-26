// ignore_for_file: camel_case_types, use_build_context_synchronously

import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
 import 'package:notkk/Services/welcome.dart';
import 'package:notkk/base.dart';
import 'package:notkk/sign/Register.dart';
import 'package:notkk/sign/forgetpassword.dart';
import 'package:notkk/tools/TextFiledconst.dart';
import 'package:notkk/tools/customBtn.dart';
import 'package:notkk/waiting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _loadCheckboxState();
  }

  // تحميل حالة الـ Checkbox من SharedPreferences
  void _loadCheckboxState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isChecked = prefs.getBool('remember_me') ?? false;
    });
  }

  // حفظ حالة الـ Checkbox في SharedPreferences
  void _saveCheckboxState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('remember_me', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 0, right: 30, left: 30, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Image.asset(
                        'lib/image/نطق.png',
                        height: MediaQuery.of(context).size.height / 5,
                        width: MediaQuery.of(context).size.width / 2.5,
                      ),
                    ),
                    const Text(
                      "مرحبًا بعودتك",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          fontSize: 28,
                          color: Color(0xff1EA3CD),
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    const Text(
                      textAlign: TextAlign.center,
                      "الرجاء إدخال معرف البريد الإلكتروني الخاص بك أو كلمة المرور لتسجيل الدخول",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20, top: 10),
                child: Column(
                  children: [
                    TextFiledconst(controller: email, text: "البريد الاكتروني"),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                    TextFiledconst(
                      controller: password,
                      text: "كلمه المرور",
                      pw: true,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 70,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(
                          flex: 1,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Forgetpass()));
                            },
                            child: Text(
                              "هل نسيت كلمه السر",
                              style:
                                  TextStyle(fontSize: 17, color: Colors.blue),
                            )),
                        Spacer(
                          flex: 50,
                        ),
                        Text("ذكرني"),
                        Padding(
                          padding: const EdgeInsets.only(right: 2.0),
                          child: Checkbox(
                            value: _isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                _isChecked = value!;
                              });
                              _saveCheckboxState(_isChecked);  // حفظ الحالة في SharedPreferences
                            },
                            activeColor: _isChecked
                                ? Color(0xff1EA3CD)
                                : Color(0xff1EA3CD),
                            checkColor: Colors.white,
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                    CustomBtn(
                      onPressed: () async {
                        waiting(context: context);
                        Map<String, dynamic> log =
                            await loginn(password.text, email.text);
                        pOP(context);
                        if (log['success']) {
                          SharedPreferences sp =
                              await SharedPreferences.getInstance();
                          sp.setString(
                              'userData', jsonEncode(log['data']['account']));
                          
                          // إذا تم تفعيل خانة "ذكرني"، انتقل إلى صفحة الـ Welcomescreen مباشرة
                          if (_isChecked) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const Welcomescreen()));
                          } else {
                            // انتقل إلى صفحة تسجيل الدخول في حال لم يتم تفعيل "ذكرني"
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>   login()));
                          }
                        } else {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'نطق',
                            titleTextStyle: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                            desc: log['message'],
                            descTextStyle: TextStyle(fontSize: 16),
                            btnCancelOnPress: () {},
                            btnCancelColor: Color(0xff1EA3CD),
                            btnOkColor: Color(0xff1EA3CD),
                            btnOkOnPress: () {},
                          ).show();
                        }
                      },
                      text: "تسجيل دخول",
                      width: 2,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 40,
                    ),
                    const Text(
                      "إن لم تمتلك حساب ؟",
                      style: TextStyle(fontSize: 18),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Register()));
                        },
                        child: const Text(
                          "قم بإنشاء حساب",
                          style: TextStyle(
                              color: Color(0xff1EA3CD),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
