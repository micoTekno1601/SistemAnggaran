import 'package:anggaran/blocs/auth/auth_bloc.dart';
import 'package:anggaran/pages/dashboard.dart';
import 'package:anggaran/pages/login.dart';
import 'package:anggaran/pages/register.dart';
import 'package:anggaran/shared/method.dart';
import 'package:anggaran/shared/theme.dart';
import 'package:anggaran/widgets/custom_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const Dashboard(),
              ),
              (route) => false,
            );
          }
          if (state is AuthError) {
            showSnackbar(context, message: state.e);
          }
        },
        child: Scaffold(
          backgroundColor: blue,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/login_illustration.png',
                    scale: 2,
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Text(
                    'Selamat Datang',
                    style: boldTS.copyWith(fontSize: 32, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Sistem Pengajuan Anggaran',
                    style: boldTS.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Anggaran Tepat, Kinerja Meningkat',
                    style: italicTS.copyWith(color: Colors.white, height: 1.6),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  LoginWithGoogle(
                    onTap: () {
                      context.read<AuthBloc>().add(AuthGoogleSignIn());
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    title: 'Buat Akun',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      );
                    },
                    borderColor: Colors.white,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: Text.rich(
                      TextSpan(
                        text: 'Sudah memiliki akun? ',
                        style: regularTS.copyWith(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(
                            text: 'Masuk',
                            style: boldTS.copyWith(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
