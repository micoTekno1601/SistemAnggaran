import 'package:flutter/material.dart';

class CustomEllipse extends StatelessWidget {
  const CustomEllipse({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 205,
      width: 205,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white10,
      ),
    );
  }
}
