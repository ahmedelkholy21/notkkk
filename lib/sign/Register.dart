  
import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:notkk/Services/privite.dart';
import 'package:notkk/base.dart';
import 'package:notkk/sign/login.dart';
import 'package:notkk/tools/TextFiledconst.dart';
import 'package:notkk/tools/customBtn.dart';
import 'package:notkk/waiting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController phone = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController conpassword = TextEditingController();

  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 00, right: 0, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                        child: Image.asset(
                      'lib/image/نطق.png',
                      height: 100,
                      width: 100,
                    )),
                    const Text(
                      "سجل الان",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          fontSize: 22,
                          color: Color(0xff1EA3CD),
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      textAlign: TextAlign.center,
                      "الرجاء إدخال معرف البريد الإلكتروني الخاص بك للتسجيل.",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    TextFiledconst(controller: email, text: "البريد الاكتروني"),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFiledconst(
                      controller: password,
                      text: "كلمه المرور",
                      pw: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFiledconst(
                      controller: conpassword,
                      text: "تأكيد كلمه المرور",
                      pw: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFiledconst(controller: phone, text: "رقم الجوال"),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFiledconst(
                      controller: name,
                      text: "الأسم",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Privite()));
                              },
                              child: Column(
                                children: [
                                   Text("أؤكد أنني قرأت شروط الاستخدام ", style:
                                    TextStyle(fontSize: 16, ),),
                                  Text(
                                    "سياسة الخصوصية",
                                    style:
                                        TextStyle(fontSize: 20, color: Colors.blue),
                                  ),
                                  
                                ],
                              )),
                         
                          Padding(
                            padding: const EdgeInsets.only(right: 0),
                            child: Checkbox(
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
                          ),
                        ],
                      ),
                    ),
                    CustomBtn(
                      onPressed: () async {
                        if (!_isChecked) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'يرجى الموافقة على شروط الاستخدام وسياسة الخصوصية!'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } else if (password.text.length < 8) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'يجب أن تكون كلمة المرور 8 أحرف على الأقل!'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } else if (password.text != conpassword.text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'كلمة المرور وتأكيد كلمة المرور يجب أن تتطابق!'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } else {
                          waiting(context: context);

                          Map<String, dynamic> create = await createaccount(
                              name.text, password.text, email.text, phone.text);
                          pOP(context);
                          if (create['success']) {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.success,
                                btnCancelColor: Color(0xff1EA3CD),
                            btnOkColor: Color(0xff1EA3CD),
                              animType: AnimType.rightSlide,
                              title: 'نطق',titleTextStyle: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
                              desc: "تم انشاء الحساب",descTextStyle: TextStyle(fontSize: 18),
                              btnCancelOnPress: () {},
                              btnOkOnPress: () {},
                            ).show();
                            email.clear();
                            name.clear();
                            phone.clear();
                            password.clear();
                            conpassword.clear();
                          } else {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'نطق',
                              desc: create['message'],
                              btnCancelOnPress: () {},
                              btnOkOnPress: () {},
                            ).show();
                          }
                        }
                      },
                      text: "انشاء حساب",
                      width: 2,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      " هل لديك حساب بلفعل؟",
                      style: TextStyle(fontSize: 18),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => login()),
                        );
                      },
                      child: const Text(
                        "سجل الان",
                        style: TextStyle(
                            color: Color(0xff1EA3CD),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<Map<String, dynamic>> getUserData() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  return jsonDecode(sp.getString('userData') ?? '{}');
}
