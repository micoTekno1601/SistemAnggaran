import 'package:anggaran/shared/theme.dart';
import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? hintText;
  final bool isPassword;
  final bool enabled;
  final VoidCallback? onTap;
  const CustomField({
    super.key,
    this.controller,
    this.keyboardType,
    this.hintText,
    this.isPassword = false,
    this.enabled = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      enabled: enabled,
      decoration: InputDecoration(
        fillColor: grey,
        filled: true,
        hintText: hintText,
        hintStyle: regularTS.copyWith(fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
      ),
    );
  }
}

class DisabledFieldWithButton extends StatelessWidget {
  final String text;
  final String iconUrl;
  final VoidCallback? onTap;
  const DisabledFieldWithButton(
      {super.key, required this.text, required this.iconUrl, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: grey,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              text,
              style: regularTS,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Image.asset(
              iconUrl,
              scale: 2,
            ),
          ),
        ],
      ),
    );
  }
}
