import 'package:flutter/material.dart';
import 'package:weather_app/Screens/getstarted.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: const GetStarted(),
      debugShowCheckedModeBanner: false,
    );
  }
}
