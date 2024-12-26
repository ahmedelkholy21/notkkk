// ignore_for_file: file_names

 import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
    Avatar({super.key,required this.iconn});

   final IconData iconn;

  @override
  Widget build(BuildContext context) {
    return  
         Center(
      child: AvatarGlow(
        
        glowColor: Colors.blue,
        duration: const Duration(milliseconds: 2000),
        repeat: true,
        child: Material(
          elevation: 8.0,
          shape: const CircleBorder(),
          child: CircleAvatar(
            backgroundColor: Colors.grey[100],
            radius: 30.0,
            // _isListening ? Icons.stop : Icons.mic,
            child: Icon(  iconn,)
             
          ),
        ),
      ),
    );
  }
}
