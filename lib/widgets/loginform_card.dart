import 'package:anggaran/shared/theme.dart';
import 'package:flutter/material.dart';

class LoginCard extends StatelessWidget {
  final String title;
  final Widget child;
  const LoginCard({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 44),
          child: Text(
            title,
            style: boldTS.copyWith(
              fontSize: 36,
              height: 2,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(40),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(40),
            ),
            color: Colors.white,
          ),
          child: child,
        ),
      ],
    );
  }
}
