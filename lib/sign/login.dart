// ignore_for_file: use_build_context_synchronously

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

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _isChecked = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0, right: 30, left: 30),
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
                  Column(
                    children: [
                      TextFiledconst(
                        controller: email,
                        text: "البريد الاكتروني",
                        validator: (p0) {
                          if (p0 == null) {
                            return 'الحقل فارغ';
                          }
                          if (p0.isEmpty) {
                            return 'الحقل فارغ';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 30,
                      ),
                      TextFiledconst(
                        controller: password,
                        text: "كلمه المرور",
                        pw: true,
                        validator: (p0) {
                          if (p0 == null) {
                            return 'الحقل فارغ';
                          }
                          if (p0.isEmpty) {
                            return 'الحقل فارغ';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 70,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: _isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _isChecked = value!;
                                  });
                                },
                                activeColor: _isChecked
                                    ? Color(0xff1EA3CD)
                                    : Color(0xff1EA3CD),
                                checkColor: Colors.white,
                              ),
                              Text("ذكرني"),
                            ],
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
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 30,
                      ),
                      CustomBtn(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            waiting(context: context);
                            Map<String, dynamic> log =
                                await loginn(password.text, email.text);
                            pOP(context);
                            if (log['success']) {
                              SharedPreferences sp =
                                  await SharedPreferences.getInstance();
                              sp.setString('userData',
                                  jsonEncode(log['data']['account']));
                              if (_isChecked) {
                                sp.setBool('login', true);
                              }

                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Welcomescreen()));
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
