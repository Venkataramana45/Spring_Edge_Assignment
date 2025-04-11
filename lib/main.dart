import 'package:flutter/material.dart';
import 'package:spring_edge_assignment/constraints/const.dart';
import 'package:spring_edge_assignment/screens/home.dart';
import 'package:spring_edge_assignment/screens/no_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Colors.blue, primary: blue),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.grey),
        ),
      ),
      home: LayoutBuilder(builder: (context, constraints) {
        if (constraints.minWidth > 1200 && constraints.minHeight > 700) {
          return const Home();
        } else {
          return const NoSize();
        }
      }),
    );
  }
}
