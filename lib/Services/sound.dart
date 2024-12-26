import 'package:flutter/material.dart';
import 'package:notkk/tools/Animation.dart';
 import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:syncfusion_flutter_gauges/gauges.dart';
 
class SoundWithGauge extends StatefulWidget {
  const SoundWithGauge({super.key});

  @override
  State<SoundWithGauge> createState() => _SoundWithGaugeState();
}

class _SoundWithGaugeState extends State<SoundWithGauge> {
  stt.SpeechToText _speech = stt.SpeechToText();
  String userInput = '';
  bool _isListening = false;
  double _soundLevel = 0.0;
  double _previousSoundLevel = 0.0;   

  @override
  void initState() {
    super.initState();
    _initializeSpeech();
  }

  void _initializeSpeech() async {
    await _speech.initialize();
  }

  void _startListening() {
    _speech.listen(onResult: (result) {
      setState(() {
        userInput = result.recognizedWords;
        double currentLevel = _calculateSoundLevel(result.recognizedWords);
         if (currentLevel > _previousSoundLevel) {
          _soundLevel = currentLevel;
        } else {
          _soundLevel = (_soundLevel - 2).clamp(0, 150);
        }
        _previousSoundLevel = currentLevel;
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

  double _calculateSoundLevel(String recognizedWords) {
     return recognizedWords.length.toDouble();  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar: AppBar(
        title: const Text("قياس الصوت"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            const Spacer(flex: 1),
            // const SizedBox(height: 30),
            Expanded(
              flex: 2,
              child: SfRadialGauge(
                
                axes: <RadialAxis>[
                  RadialAxis(showLabels: false, showAxisLine: false, showTicks: false,
                        minimum: 0, maximum: 99, radiusFactor: 1.2,
                        ranges: <GaugeRange>[GaugeRange(startValue: 0, endValue: 33,
                            color: Color(0xffBAE6FD), label: ' منخفض',
                            sizeUnit: GaugeSizeUnit.factor,
                            labelStyle: GaugeTextStyle(fontFamily: 'Times', fontSize:  20),
                            startWidth: 0.35, endWidth: 0.35
                        ),GaugeRange(startValue: 33, endValue: 66,
                          color:Color(0xff73CBE6), label: 'متوسط',
                          labelStyle: GaugeTextStyle(fontFamily: 'Times', fontSize:   20),
                          startWidth: 0.35, endWidth: 0.35, sizeUnit: GaugeSizeUnit.factor,
                        ),
                          GaugeRange(startValue: 66, endValue: 99,
                            color:Color(0xff137E9F), label: 'مرتفع',
                            labelStyle: GaugeTextStyle(fontFamily: 'Times', fontSize:   20),
                            sizeUnit: GaugeSizeUnit.factor,
                            startWidth: 0.35, endWidth: 0.35,
                          ),
              
                    ],
                    pointers: <GaugePointer>[
                      NeedlePointer(
                        value: _soundLevel,
                        enableAnimation: true,
                      )
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Text(
                          "${_soundLevel.toStringAsFixed(0)}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        positionFactor: 0.5,
                        angle: 90,
                      )
                    ],
                  )
                ],
              ),
            ),
            const Spacer(flex: 2,),
             Expanded(
              flex: 0,
               child: GestureDetector(
                onTap: () {
                  if (_isListening) {
                    _stopListening();
                  } else {
                    _startListening();
                  }
                },
                child:  Avatar(iconn: _isListening ? Icons.stop : Icons.mic,),
                           ),
             ),
           const Spacer(flex: 1,)
          ],
        ),
      ),
    );
  }
}
