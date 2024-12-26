import 'package:flutter/material.dart';
import 'package:notkk/tools/Animation.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class MyGrid extends StatefulWidget {
  const MyGrid({super.key});

  @override
  _MyGridState createState() => _MyGridState();
}

class _MyGridState extends State<MyGrid> {
  final List<Map<String, String>> items = [
    {'letter': 'ا', 'image': 'lib/image/ا.jpg'},
    {'letter': 'ب', 'image': 'lib/image/ب.jpg'},
    {'letter': 'ت', 'image': 'lib/image/ت.jpg'},
    {'letter': 'ث', 'image': 'lib/image/ث.jpg'},
    {'letter': 'ج', 'image': 'lib/image/ج.jpg'},
    {'letter': 'ح', 'image': 'lib/image/ح.jpg'},
    {'letter': 'خ', 'image': 'lib/image/خ.jpg'},
    {'letter': 'د', 'image': 'lib/image/د.jpg'},
    {'letter': 'ذ', 'image': 'lib/image/ذ.jpg'},
    {'letter': 'ر', 'image': 'lib/image/ر.jpg'},
    {'letter': 'ز', 'image': 'lib/image/ز.jpg'},
    {'letter': 'س', 'image': 'lib/image/س.jpg'},
    {'letter': 'ش', 'image': 'lib/image/ش.jpg'},
    {'letter': 'ص', 'image': 'lib/image/ص.jpg'},
    {'letter': 'ض', 'image': 'lib/image/ض.jpg'},
    {'letter': 'ط', 'image': 'lib/image/ط.jpg'},
    {'letter': 'ظ', 'image': 'lib/image/ظ.jpg'},
    {'letter': 'ع', 'image': 'lib/image/ع.jpg'},
    {'letter': 'غ', 'image': 'lib/image/غ.jpg'},
    {'letter': 'ف', 'image': 'lib/image/ف.jpg'},
    {'letter': 'ق', 'image': 'lib/image/ق.jpg'},
    {'letter': 'ك', 'image': 'lib/image/ك.jpg'},
    {'letter': 'ل', 'image': 'lib/image/ل.jpg'},
    {'letter': 'م', 'image': 'lib/image/م.jpg'},
    {'letter': 'ن', 'image': 'lib/image/ن.jpg'},
    {'letter': 'ه', 'image': 'lib/image/ه.jpg'},
    {'letter': 'و', 'image': 'lib/image/و.jpg'},
    {'letter': 'ي', 'image': 'lib/image/ي.jpg'},
  ];

  String userInput = '';
  late stt.SpeechToText _speech;
  bool _isListening = false;
  Map<String, int> letterCount = {}; // لتخزين عدد مرات ذكر كل حرف

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _initializeSpeech();
    
    // تهيئة عدد مرات ذكر كل حرف
    for (var item in items) {
      letterCount[item['letter']!] = 0;
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
          userInput = recognizedWords[0]; 
          // زيادة عدد مرات ذكر الحرف
          if (letterCount.containsKey(userInput)) {
            letterCount[userInput] = letterCount[userInput]! + 1;
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Spacer(flex: 1),
            Image.asset(
              'lib/image/نطق.png',
              height: 50,
              width: 70,
            ),
            Spacer(flex: 8),
            Text("نطق الحروف بالعربيه", style: TextStyle(fontSize: 22)),
            Spacer(flex: 15)
          ],
        ),
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
                    int count = letterCount[item['letter']!] ?? 0;
                    Color cardColor;

                    // تحديد لون الخلفية بناءً على عدد مرات ذكر الحرف
                    if (count >= 10) {
                      cardColor = Colors.green; // اللون الأخضر إذا تم ذكره 10 مرات
                    } else if (userInput == item['letter']) {
                      cardColor = Colors.blue; // اللون الأزرق إذا تم ذكره مرة واحدة
                    } else {
                      cardColor = Colors.white; // اللون الافتراضي
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
                            Image.asset(item['image']!, width: 100, height: 100),
                            const SizedBox(height: 8),
                            Text(
                              item['letter']!,
                              style: const TextStyle(fontSize: 24),
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