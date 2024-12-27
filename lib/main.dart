import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:notkk/splach/intro_1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const <LocalizationsDelegate<Object>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const <Locale>[Locale('en', ''), Locale('ar', '')],
      localeResolutionCallback: (locales, supportedLocales) {
        return supportedLocales.last;
      },
      localeListResolutionCallback: (locales, supportedLocales) {
        return supportedLocales.last;
      },
      debugShowCheckedModeBanner: false,
      title: 'نطق',
      theme: ThemeData(fontFamily: 'tajawal'),
      home: SplashScreen(),
    );
  }
}
