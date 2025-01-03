// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:notkk/tools/Animation.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class MyGrid1 extends StatefulWidget {
  const MyGrid1({super.key});

  @override
  _MyGrid1State createState() => _MyGrid1State();
}

class _MyGrid1State extends State<MyGrid1> {
  final List<Map<String, String>> items = [
    {'name': 'A', 'path': 'lib/image/A.jpg', 'test': 'اي'},
    {'name': 'B', 'path': 'lib/image/B.jpg', 'test': 'بي'},
    {'name': 'C', 'path': 'lib/image/C.jpg', 'test': 'سي'},
    {'name': 'D', 'path': 'lib/image/D.jpg', 'test': 'دي'},
    {'name': 'E', 'path': 'lib/image/E.jpg', 'test': 'اه'},
    {'name': 'F', 'path': 'lib/image/F.jpg', 'test': 'اف'},
    {'name': 'G', 'path': 'lib/image/G.jpg', 'test': 'جي'},
    {'name': 'H', 'path': 'lib/image/H.jpg', 'test': 'اتش'},
    {'name': 'I', 'path': 'lib/image/I.jpg', 'test': 'أي'},
    {'name': 'J', 'path': 'lib/image/J.jpg', 'test': 'جاي'},
    {'name': 'K', 'path': 'lib/image/K.jpg', 'test': 'كا'},
    {'name': 'L', 'path': 'lib/image/L.jpg', 'test': 'ال'},
    {'name': 'M', 'path': 'lib/image/M.jpg', 'test': 'ام'},
    {'name': 'N', 'path': 'lib/image/N.jpg', 'test': 'ان'},
    {'name': 'O', 'path': 'lib/image/O.jpg', 'test': 'وو'},
    {'name': 'P', 'path': 'lib/image/P.jpg', 'test': 'بي'},
    {'name': 'Q', 'path': 'lib/image/Q.jpg', 'test': 'كيو'},
    {'name': 'R', 'path': 'lib/image/R.jpg', 'test': 'او'},
    {'name': 'S', 'path': 'lib/image/S.jpg', 'test': 'إس'},
    {'name': 'T', 'path': 'lib/image/T.jpg', 'test': 'تي'},
    {'name': 'U', 'path': 'lib/image/U.jpg', 'test': 'يو'},
    {'name': 'V', 'path': 'lib/image/V.jpg', 'test': 'في'},
    {'name': 'W', 'path': 'lib/image/W.jpg', 'test': 'دب'},
    {'name': 'X', 'path': 'lib/image/X.jpg', 'test': 'اكس'},
    {'name': 'Y', 'path': 'lib/image/Y.jpg', 'test': 'واي'},
    {'name': 'Z', 'path': 'lib/image/Z.jpg', 'test': 'زد'},
  ];

  String userInput = '';
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String? matchedItem;
  Map<String, int> letterCount = {};

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _initializeSpeech();

    for (var item in items) {
      letterCount[item['name']!] = 0;
    }
  }

  void _initializeSpeech() async {
    await _speech.initialize();
  }

  void _startListening() {
    _speech.listen(onResult: (result) {
      setState(() {
        String recognizedWords = result.recognizedWords;

        if (recognizedWords.isNotEmpty) {
          userInput = recognizedWords;
          matchedItem = items.firstWhere(
            (item) => recognizedWords.contains(item['test']!),
            orElse: () => {'name': '', 'path': '', 'test': ''},
          )['name'];

          if (matchedItem != null && matchedItem!.isNotEmpty) {
            letterCount[matchedItem!] = letterCount[matchedItem!]! + 1;
          }

          _stopListening();
        }
      });
    });
    setState(() {
      _isListening = true;
    });
  }

  void _stopListening() {
    _speech.stop();
    setState(() {
      _isListening = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text("نطق الحروف بالنجليزية",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        actions: [
          Image.asset(
            'lib/image/نطق.png',
            height: 50,
            width: 70,
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    bool isMatched = matchedItem == item['name'];
                    int count = letterCount[item['name']!] ?? 0;
                    Color cardColor;

                    if (count > 10) {
                      cardColor = Colors.green;
                    } else if (isMatched) {
                      cardColor = Colors.blue;
                    } else {
                      cardColor = Colors.white;
                    }

                    return Container(
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Card(
                        elevation: 0,
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(item['path']!, width: 100, height: 100),
                            const SizedBox(height: 8),
                            Text(
                              item['name']!,
                              style: TextStyle(
                                fontSize: 24,
                                color: isMatched ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 2 - 30,
            bottom: 20,
            child: GestureDetector(
              onTap: () {
                if (_isListening) {
                  _stopListening();
                } else {
                  _startListening();
                }
              },
              child: Avatar(iconn: _isListening ? Icons.stop : Icons.mic),
            ),
          ),
        ],
      ),
    );
  }
}
