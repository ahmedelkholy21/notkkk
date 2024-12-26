// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';

class SoundWaveScreen extends StatefulWidget {
  @override
  _SoundWaveScreenState createState() => _SoundWaveScreenState();
}

class _SoundWaveScreenState extends State<SoundWaveScreen> with TickerProviderStateMixin {
  final int numBars = 15;
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List<AnimationController>.generate(
      numBars,
      (index) => AnimationController(
        duration: Duration(milliseconds: 300 + (index * 200)),
        vsync: this,
      )..repeat(reverse: true),
    );

    _animations = _controllers.map((controller) {
      return Tween<double>(begin: 10, end: 60).animate(controller);
    }).toList();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return   Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(numBars, (index) {
            return AnimatedBuilder(
              animation: _animations[index],
              builder: (context, child) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  width: 4,
                  height: _animations[index].value,
                  color: Colors.black,
                );
              },
            );
          }),
        ),
      );
   }
}