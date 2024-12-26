 import 'package:flutter/material.dart';
import 'package:notkk/sign/Register.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
        title: const Text("الملف الشخصي"),
        backgroundColor: const Color(0xff73CBE6),
      ),
      body: FutureBuilder(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final data = snapshot.data!;

            return Stack(children: [
              Column(
                children: [
                  Container(
                    color: const Color(0xff73CBE6),
                    height: MediaQuery.of(context).size.height / 5,
                  ),
                ],
              ),
              Center(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 21),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 1.1,
                            height: MediaQuery.of(context).size.height / 1.9,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              color: const Color(0xff137E9F),
                              margin: const EdgeInsets.only(
                                top: 16,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: const ShapeDecoration(
                                shape: CircleBorder(),
                                color: Colors.white,
                              ),
                              child: CircleAvatar(
                                child: Image.asset('lib/image/avatar.png'),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              data['name'],
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text(
                                  ":البريد الالكتروني",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24,fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 8,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                 SizedBox(
                                  width: MediaQuery.of(context).size.width / 8,
                                ),
                                Text(
                                  data['email'],
                                  style:
                                      TextStyle(color: Colors.white, fontSize: 18),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text(
                                  ":رقم الهاتف ",
                                  style:
                                      TextStyle(color: Colors.white, fontSize: 24,fontWeight: FontWeight.bold),
                                ),
                                 SizedBox(
                                  width: MediaQuery.of(context).size.width / 8,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                 SizedBox(
                                  width: MediaQuery.of(context).size.width / 8,
                                ),
                                Text(
                                  data['phone'],
                                  style:
                                      TextStyle(color: Colors.white, fontSize: 18),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ]);
          }
        },
      ),
    );
  }
}
