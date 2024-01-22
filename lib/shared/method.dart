import 'package:anggaran/shared/theme.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, {required String message}) {
  Flushbar(
    margin: const EdgeInsets.all(20),
    padding: const EdgeInsets.all(20),
    borderRadius: BorderRadius.circular(10),
    flushbarPosition: FlushbarPosition.TOP,
    duration: const Duration(seconds: 2),
    backgroundColor: Colors.white,
    messageColor: blue,
    message: message,
  ).show(context);
}
