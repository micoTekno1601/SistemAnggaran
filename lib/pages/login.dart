import 'package:anggaran/pages/dashboard.dart';
import 'package:anggaran/shared/method.dart';
import 'package:anggaran/shared/theme.dart';
import 'package:anggaran/widgets/custom_button.dart';
import 'package:anggaran/widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_bloc.dart';
import '../widgets/loginform_card.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool areFieldsEmpty = true;

  @override
  void initState() {
    super.initState();
    emailController.addListener(updateFieldState);
    passwordController.addListener(updateFieldState);
  }

  @override
  void dispose() {
    emailController.removeListener(updateFieldState);
    passwordController.removeListener(updateFieldState);
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void updateFieldState() {
    setState(() {
      areFieldsEmpty =
          emailController.text.isEmpty || passwordController.text.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AuthBloc, AuthState>(
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
        builder: (context, state) {
          if (state is AuthLoading) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(color: blue),
              ),
            );
          }
          return Scaffold(
            backgroundColor: blue,
            body: ListView(
              children: [
                Stack(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 25,
                          ),
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Image.asset(
                              'assets/icons/back_button.png',
                              scale: 2,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Image.asset(
                          'assets/images/ellipse.png',
                          scale: 2,
                        ),
                      ],
                    ),
                  ],
                ),
                LoginCard(
                  title: 'Masuk',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat Datang Kembali',
                        style: boldTS.copyWith(fontSize: 24, height: 1.5),
                      ),
                      Text(
                        'Hallo Sobat Tekno, masuk untuk melanjutkan!',
                        style: regularTS.copyWith(height: 1.5),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Username atau email',
                        style: regularTS.copyWith(height: 1.5),
                      ),
                      CustomField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'Masukkan email Anda',
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Password',
                        style: regularTS.copyWith(height: 1.5),
                      ),
                      CustomField(
                        controller: passwordController,
                        hintText: 'Masukkan password Anda',
                        isPassword: true,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Lupa Kata Sandi?',
                        style: boldTS,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        title: 'Masuk',
                        disabled: areFieldsEmpty,
                        onTap: () {
                          if (!areFieldsEmpty) {
                            context.read<AuthBloc>().add(
                                  AuthSignIn(
                                    emailController.text,
                                    passwordController.text,
                                  ),
                                );
                          }
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      LoginWithGoogle(
                        onTap: () {
                          context.read<AuthBloc>().add(AuthGoogleSignIn());
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
