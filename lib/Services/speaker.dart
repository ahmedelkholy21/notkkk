import 'package:flutter/material.dart';
import 'package:notkk/Services/wave.dart'; // تأكد من أن هذه المكتبة موجودة
import 'package:notkk/tools/Animation.dart'; // تأكد من أن هذه المكتبة موجودة
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'dart:async';

class Speaker extends StatefulWidget {
  const Speaker({super.key});

  @override
  State<Speaker> createState() => _SpeakerState();
}

class _SpeakerState extends State<Speaker> {
  String userInput = '';

  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _timeSpent = '00:00';
  late Stopwatch _stopwatch;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _initializeSpeech();
    _stopwatch = Stopwatch();
  }

  void _initializeSpeech() async {
    await _speech.initialize();
  }

  void _startListening() {
    _speech.listen(onResult: (result) {
      setState(() {
        userInput = result.recognizedWords;
      });

      if (!_stopwatch.isRunning) {
        _startTimer();
      }
    }, onSoundLevelChange: (level) {
      if (level == 0.0 && _stopwatch.isRunning) {
        _stopTimer();
      } else if (level > 0.0 && !_stopwatch.isRunning) {
        _startTimer();
      }
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
    _stopTimer();
  }

  void _clearText() {
    setState(() {
      userInput = '';
      _stopwatch.reset();
      _timeSpent = '00:00';
    });
  }

  void _startTimer() {
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_stopwatch.isRunning) {
        setState(() {
          int seconds = _stopwatch.elapsed.inSeconds;
          int minutes = seconds ~/ 60;
          seconds = seconds % 60;
          _timeSpent =
              '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
        });
      }
    });
  }

  void _stopTimer() {
    _stopwatch.stop();
    _timer.cancel();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: _clearText, icon: const Icon(Icons.refresh)),
        ],
        title: const Text("تحويل الكلام إلى نص"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 1),

              Text(
                _timeSpent,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Spacer(flex: 1),
              Text(
                userInput,
                style: const TextStyle(fontSize: 22),
              ),
              const Spacer(flex: 2),

              // فقط عندما يكون الميكروفون مفتوحًا يتم عرض SoundWaveScreen
              Visibility(
                visible: _isListening,
                child:   SoundWaveScreen(),
              ),

              const Spacer(flex: 2),

              GestureDetector(
                onTap: () {
                  if (_isListening) {
                    _stopListening();
                  } else {
                    _startListening();
                  }
                },
                child: Avatar(iconn: _isListening ? Icons.stop : Icons.mic),
              ),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
