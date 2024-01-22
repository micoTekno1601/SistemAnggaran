import 'package:flutter/material.dart';

class MenuDeck extends StatelessWidget {
  final Widget child;
  const MenuDeck({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            offset: Offset(0, 5),
            blurRadius: 15,
            spreadRadius: -8,
          )
        ],
      ),
      child: child,
    );
  }
}
