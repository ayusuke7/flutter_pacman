import 'package:flutter/material.dart';
import 'package:pacman_flutter/board.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({ super.key });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Pacman',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BoardGame(),
    );
  }
}
