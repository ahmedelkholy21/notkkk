import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:notkk/sign/newpassword.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
class Forgetconferm extends StatefulWidget {
  const Forgetconferm({super.key, required this.otp, required this.id});
  final String otp;
  final String id;
  @override
  // ignore: library_private_types_in_public_api
  _ForgetconfermState createState() => _ForgetconfermState();
}

class _ForgetconfermState extends State<Forgetconferm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Center(
                child: Image.asset(
                  'lib/image/نطق.png',
                  height: 100,
                  width: 100,
                ),
              ),
              const Text(
                "  هل نسيت كلمة السر",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontSize: 28,
                  color: Color(0xff1EA3CD),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                textAlign: TextAlign.center,
                "الرجاء إدخال عنوان بريدك الإلكتروني المسجل لإعادة تعيين كلمة المرور الخاصة بك",
                textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 30),
              OTPTextField(
                length: 6,
                width: MediaQuery.of(context).size.width,
                fieldWidth: MediaQuery.of(context).size.width * 0.1,
                style: TextStyle(
                    fontSize: 17, color: Theme.of(context).primaryColorDark),
                keyboardType: TextInputType.number,
                margin: const EdgeInsets.all(4),
                otpFieldStyle: OtpFieldStyle(
                    borderColor: Theme.of(context).primaryColorDark,
                    enabledBorderColor: Theme.of(context).primaryColorDark,
                    disabledBorderColor: Theme.of(context).primaryColorDark,
                    errorBorderColor: Colors.red,
                    focusBorderColor: Theme.of(context).primaryColor),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.box,
                onCompleted: (pin) {
                  if (pin == widget.otp) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>   NewPass(id:widget.id ,)));
                  }
                   else{
                            AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
              btnCancelColor: Color(0xff1EA3CD),
                            btnOkColor: Color(0xff1EA3CD),
            animType: AnimType.rightSlide,
            title: 'نطق',titleTextStyle: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
           desc:  "الكود غير صحيح",descTextStyle: TextStyle(fontSize: 18),
            btnCancelOnPress: () {},
            btnOkOnPress: () {},
            ).show();
                          }
                },
                onChanged: (value) {},
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
