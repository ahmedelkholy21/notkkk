// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:notkk/sign/Register.dart';
import 'package:notkk/sign/login.dart';
import 'package:notkk/tools/child.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  PageController controller = PageController();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: PageView(
                  controller: controller,
                  children: [
                    Child(
                      img: "lib/image/intro1.svg",
                      txt1: "معنا يمكنك التواصل\n بسهولة",
                      txt2:
                          "اكتشف العالم من حولك باستخدام أدواتنا لتحويل الصوت إلى نصوص واضحة تدعم فهمك الكامل.",
                    ),
                    Child(
                        img: "lib/image/intro2.svg",
                        txt1: "اجعل العالم مفهوماً\n أكثر",
                        txt2:
                            "قياس قوة الصوت بدقة لمساعدتك على فهم مدى وضوح الصوت من حولك"),
                    Child(
                      img: "lib/image/intro3.svg",
                      txt1: "تعرف على الحروف ولغة\n الاشارة",
                      txt2:
                          "ميزة مميزة لتحليل الحروف المنطوقة وتحديد الكلمات بلغة الاشارة، مما يمنع سوء الفهم.",
                    )
                  ],
                  onPageChanged: (value) {
                    setState(() {
                      index = value;
                    });
                  },
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    effect: const SlideEffect(
                      activeDotColor: Colors.white54,
                      dotHeight: 10,
                      dotColor: Color(0xff1EA3CD),
                      dotWidth: 10,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    onPressed: () {
                      if (index == 2) {
                        _markIntroAsShown();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) =>
                                Register())); // انتقل إلى صفحة إنشاء حساب
                      } else {
                        setState(() {
                          index = index + 1;
                        });
                        controller.animateToPage(index,
                            duration: const Duration(seconds: 1),
                            curve: Curves.linear);
                      }
                    },
                    elevation: 10,
                    minWidth: MediaQuery.of(context).size.width * .8,
                    height: 60,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: Color(0xff1EA3CD),
                    child: Text(
                      index == 2 ? "إنشاء حساب" : "التالي",
                      style: const TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                      onPressed: () async {
                        if (index == 2) {
                          await _markIntroAsShown();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => Login()));
                        } else {
                          setState(() {
                            index = 2;
                          });
                          controller.animateToPage(index,
                              duration: const Duration(seconds: 1),
                              curve: Curves.linear);
                        }
                      },
                      child: Text(
                        index == 2 ? "بالفعل املك حساب " : "تخطي",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff1EA3CD),
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // دالة لتخزين حالة عرض الـ Intro
  Future<void> _markIntroAsShown() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('intro_shown', true);
  }
}
