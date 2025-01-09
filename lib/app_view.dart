// v1.0 -- non-dynamic version

import 'package:flutter/material.dart';
import 'package:sma_app/screens/home/views/home_screen.dart';

class MyAppView extends StatelessWidget{
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Expense Tracker",
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          surface: Colors.grey.shade200,
          onSurface: Colors.black,
          primary: const Color(0xFF00B2E7),
          secondary: const Color(0xFFE064F7),
          tertiary: const Color(0xFFF67BE7),
          outline: Colors.grey.shade700
        )
      ),
      home: const HomeScreen(),
    );
  }
}