import 'package:anggaran/blocs/auth/auth_bloc.dart';
import 'package:anggaran/widgets/custom_button.dart';
import 'package:anggaran/widgets/custom_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/theme.dart';
import '../widgets/profile_appbar.dart';

class Pengaturan extends StatelessWidget {
  const Pengaturan({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            ProfileAppbar(
              menu: Padding(
                padding: const EdgeInsets.all(25),
                child: Text(
                  'Pengaturan',
                  style: boldTS.copyWith(fontSize: 24, color: blue),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(30),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Anda login menggunakan :',
                      style: regularTS.copyWith(fontSize: 15, height: 2),
                    ),
                  ),
                  CustomField(
                    hintText: FirebaseAuth.instance.currentUser!.email,
                    enabled: false,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomButton(
                    title: 'Logout',
                    onTap: () => context.read<AuthBloc>().add(AuthSignOut()),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
