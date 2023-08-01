import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tockto_assignment/models/quiz_data.dart';
import 'package:tockto_assignment/screens/quiz_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QuizData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const QuizScreen(),
      ),
    );
  }
}
