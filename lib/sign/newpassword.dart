import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:notkk/base.dart';
import 'package:notkk/sign/Register.dart';
import 'package:notkk/tools/TextFiledconst.dart';
import 'package:notkk/tools/customBtn.dart';
import 'package:notkk/waiting.dart';

class NewPass extends StatefulWidget {
  const NewPass({super.key,required this.id}) ;
 final String id;
  @override
  State<NewPass> createState() => _NewPassState();
}

class _NewPassState extends State<NewPass> {
  TextEditingController newpassword = TextEditingController();
  TextEditingController connewpassword = TextEditingController();

  String _newPasswordError = '';
  String _confirmPasswordError = '';

  void _validateNewPassword(String value) {
    setState(() {
      if (value.isEmpty) {
        _newPasswordError = 'يرجى إدخال كلمة المرور الجديدة';
      } else if (value.length < 8 || value.length > 20) {
        _newPasswordError = 'يجب أن يتراوح الطول بين 8 إلى 20 حرفًا';
      } else if (!RegExp(r'[A-Z]').hasMatch(value) ||
          !RegExp(r'[a-z]').hasMatch(value) ||
          !RegExp(r'[0-9]').hasMatch(value) ||
          !RegExp(r'[@#\$%!&*]').hasMatch(value)) {
        _newPasswordError =
            'يجب أن تحتوي على مزيج من الأحرف الكبيرة والصغيرة والأرقام وأحرف خاصة';
      } else {
        _newPasswordError = '';
      }
    });
  }

  void _validateConfirmPassword(String value) {
    setState(() {
      if (value.isEmpty) {
        _confirmPasswordError = 'يرجى إدخال تأكيد كلمة المرور';
      } else if (value != newpassword.text) {
        _confirmPasswordError = 'تأكيد كلمة المرور غير متطابق';
      } else {
        _confirmPasswordError = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 20,),
              Center(
                  child: Image.asset(
                'lib/image/نطق.png',
                height: 100,
                width: 100,
              )),
              const Center(
                child: Text(
                  "إنشاء كلمة مرور جديدة",
                  style: TextStyle(
                    fontSize: 28,
                    color: Color(0xff1EA3CD),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Text(
                textAlign: TextAlign.center,
                "قم بتعيين كلمة المرور الجديدة حتى تتمكن من تسجيل الدخول والوصول إلى حسابك",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: TextFiledconst(
                  onChanged: _validateNewPassword,
                  controller: newpassword,
                  text: "كلمة المرور الجديدة",
                  pw: true,
                ),
              ),
              if (_newPasswordError.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    _newPasswordError,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: TextFiledconst(
                  onChanged: _validateConfirmPassword,
                  controller: connewpassword,
                  text: "تأكيد كلمة المرور",
                  pw: true,
                ),
              ),
              if (_confirmPasswordError.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    _confirmPasswordError,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              const SizedBox(height: 40),
              Center(
                child: CustomBtn(
                  onPressed: () async{
                    waiting(context: context);
                       Map<String, dynamic> new1 = await forgetpw2(
                              widget.id, newpassword.text);
                          pOP(context);
                            if (new1['success']) {
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>  Register ()));
                          }
                          else{
                            AwesomeDialog(
            // ignore: use_build_context_synchronously
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            title: 'نطق',
            desc: new1['message'],
            btnCancelOnPress: () {},
            btnOkOnPress: () {},
            ).show();
                          }
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (context) => Register()));
                  },
                  text: "تأكيد",
                  width: .4,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                "سياسة كلمة المرور",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text(
                textAlign: TextAlign.end,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                "يجب أن يتراوح الطول بين 8 إلى 20 حرفًا، ويجب أن يكون مزيجًا من الأحرف الكبيرة والصغيرة، ويجب أن يحتوي على أحرف وأرقام، ويجب أن يكون هناك حرف خاص مثل @ و# و! و* و\$.",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
