// import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:teest/tools/Animation.dart';

// class SoundEng extends StatefulWidget {
//   @override
//   _SoundEngState createState() => _SoundEngState();
// }

// class _SoundEngState extends State<SoundEng> {
//   final List<Map<String, String>> images = [
//     {'name': 'A', 'path': 'lib/image/A.jpg'},
//     {'name': 'B', 'path': 'lib/image/B.jpg'},
//     {'name': 'C', 'path': 'lib/image/C.jpg'},
//     {'name': 'D', 'path': 'lib/image/D.jpg'},
//     {'name': 'E', 'path': 'lib/image/E.jpg'},
//     {'name': 'F', 'path': 'lib/image/F.jpg'},
//     {'name': 'G', 'path': 'lib/image/G.jpg'},
//     {'name': 'H', 'path': 'lib/image/H.jpg'},
//     {'name': 'I', 'path': 'lib/image/I.jpg'},
//     {'name': 'J', 'path': 'lib/image/J.jpg'},
//     {'name': 'K', 'path': 'lib/image/K.jpg'},
//     {'name': 'L', 'path': 'lib/image/L.jpg'},
//     {'name': 'M', 'path': 'lib/image/M.jpg'},
//     {'name': 'N', 'path': 'lib/image/N.jpg'},
//     {'name': 'O', 'path': 'lib/image/O.jpg'},
//     {'name': 'P', 'path': 'lib/image/P.jpg'},
//     {'name': 'Q', 'path': 'lib/image/Q.jpg'},
//     {'name': 'R', 'path': 'lib/image/R.jpg'},
//     {'name': 'S', 'path': 'lib/image/S.jpg'},
//     {'name': 'T', 'path': 'lib/image/T.jpg'},
//     {'name': 'U', 'path': 'lib/image/U.jpg'},
//     {'name': 'V', 'path': 'lib/image/V.jpg'},
//     {'name': 'W', 'path': 'lib/image/W.jpg'},
//     {'name': 'X', 'path': 'lib/image/X.jpg'},
//     {'name': 'Y', 'path': 'lib/image/Y.jpg'},
//     {'name': 'Z', 'path': 'lib/image/Z.jpg'},
//   ];

//   String userInput = ''; 
//   late stt.SpeechToText _speech;
//   bool _isListening = false;

//   @override
//   void initState() {
//     super.initState();
//     _speech = stt.SpeechToText();
//     _initializeSpeech();
//   }

//   // تهيئة speech-to-text
//   void _initializeSpeech() async {
//     bool available = await _speech.initialize(
//       onStatus: (status) => print('onStatus: $status'),
//       onError: (errorNotification) => print('onError: $errorNotification'),
//     );
//     if (available) {
//       print('Speech recognition available');
//     } else {
//       print('Speech recognition not available');
//     }
//   }

//   // بدء الاستماع من الميكروفون
//   void _startListening() {
//     _speech.listen(
//       onResult: (result) {
//         setState(() {
//           String recognizedWords = result.recognizedWords;
//            if (RegExp(r'^[A-Za-z]+$').hasMatch(recognizedWords)) {
//              userInput = recognizedWords[0].toUpperCase();
//             _updateLetterCount(userInput);
//           }
//         });
//       },
//       localeId: 'en_US',  
//     );
//     setState(() {
//       _isListening = true;
//     });
//   }

//   // إيقاف الاستماع
//   void _stopListening() {
//     _speech.stop();
//     setState(() {
//       _isListening = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(Icons.arrow_back),
//         ),
//         title: Image.asset(
//           'lib/image/نطق.png',
//           height: 50,
//           width: 70,
//         ),
//       ),
//       body: Stack(
//         children: [
//           Column(
//             children: [
//               Expanded(
//                 child: GridView.builder(
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 3,
//                     childAspectRatio: 0.7,
//                   ),
//                   itemCount: images.length,
//                   itemBuilder: (context, index) {
//                     final item = images[index];
//                     int count = letterCount[item['name']] ?? 0; // عدد الحروف المتكررة
//                     Color cardColor;

//                     // تعيين لون البطاقة بناءً على ما إذا كان الحرف متطابق مع المدخل
//                     if (userInput == item['name']) {
//                       cardColor = const Color(0xff73CBE6); // اللون عند المطابقة
//                     } else {
//                       cardColor = Colors.white;
//                     }

//                     return Container(
//                       decoration: BoxDecoration(
//                         color: cardColor,  // تغيير اللون إلى الأزرق إذا كان الحرف المدخل مطابق
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Card(
//                         elevation: 0,
//                         color: Colors.transparent,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Image.asset(item['path']!, width: 100, height: 100),
//                             const SizedBox(height: 8),
//                             Text(
//                               item['name']!,
//                               style: const TextStyle(fontSize: 24),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//           Positioned(
//             left: MediaQuery.of(context).size.width / 2 - 30,
//             bottom: MediaQuery.of(context).size.height * 0.05,
//             child: GestureDetector(
//               onTap: () {
//                 if (_isListening) {
//                   print(userInput);
//                   _stopListening();
//                 } else {
//                   _startListening();
//                 }
//               },
//               child: Avatar(iconn: _isListening ? Icons.stop : Icons.mic),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }