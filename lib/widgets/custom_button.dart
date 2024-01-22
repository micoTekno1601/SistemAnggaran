import 'package:anggaran/shared/theme.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool disabled;
  final Color? borderColor;
  final double? padding;
  const CustomButton({
    super.key,
    required this.title,
    this.onTap,
    this.disabled = false,
    this.borderColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: disabled ? 0.4 : 1,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(padding ?? 10),
          decoration: BoxDecoration(
            color: blue,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderColor ?? blue),
          ),
          child: Text(
            title,
            style: boldTS.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class LoginWithGoogle extends StatelessWidget {
  final VoidCallback? onTap;
  const LoginWithGoogle({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: blue),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/icons/google.png',
              scale: 2,
            ),
            Text(
              'Masuk dengan Google',
              style: boldTS,
              textAlign: TextAlign.center,
            ),
            Container(),
          ],
        ),
      ),
    );
  }
}
