import 'package:flutter/material.dart';

class Pixel extends StatelessWidget {

  final Widget? child;
  final Color? color;

  const Pixel({
    super.key,
    this.child,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: Colors.black,
          width: 2.5
        )
      ),
      child: child,
    );
  }
}