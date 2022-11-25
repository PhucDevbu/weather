import 'package:flutter/material.dart';

class DotWidget extends StatelessWidget {
  final bool? isActive;
  const DotWidget({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: isActive! ? 20 : 10,
      height: 5,
      decoration: BoxDecoration(
          color: isActive! ? Colors.white : Colors.white54,
          borderRadius: const BorderRadius.all(Radius.circular(5))),
    );
  }
}
