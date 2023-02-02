import 'package:flutter/material.dart';

class Enemy extends StatelessWidget {
  
  const Enemy({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/imgs/red-enemy.png');
  }
}
