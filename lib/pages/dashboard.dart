import 'package:anggaran/blocs/auth/auth_bloc.dart';
import 'package:anggaran/pages/dashboard_notifikasi.dart';
import 'package:anggaran/pages/dashboard_pengajuan.dart';
import 'package:anggaran/pages/dashboard_pengaturan.dart';
import 'package:anggaran/pages/landing.dart';
import 'package:anggaran/shared/theme.dart';
import 'package:anggaran/widgets/anggaran_card.dart';
import 'package:anggaran/widgets/custom_button.dart';
import 'package:anggaran/widgets/profile_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/anggaran/anggaran_bloc.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UnAuthenticated) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const LandingPage(),
              ),
              (route) => false,
            );
          }
        },
        child: Scaffold(
          body: Column(
            children: [
              ProfileAppbar(
                menu: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HomeMenu(
                      title: 'Pengajuan',
                      imageUrl: 'assets/images/pengajuan.png',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const AjukanAnggaran(),
                          ),
                        );
                      },
                    ),
                    HomeMenu(
                      title: 'Notifikasi',
                      imageUrl: 'assets/images/notifikasi.png',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const Notifikasi(),
                          ),
                        );
                      },
                    ),
                    HomeMenu(
                      title: 'Pengaturan',
                      imageUrl: 'assets/images/pengaturan.png',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const Pengaturan(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: BlocProvider(
                  create: (context) =>
                      AnggaranBloc()..add(StreamAnggaranEvent()),
                  child: BlocBuilder<AnggaranBloc, AnggaranState>(
                    builder: (context, state) {
                      if (state is StreamAnggaranSuccess) {
                        return ListView(
                          padding: const EdgeInsets.all(20),
                          children: state.data.map((anggaran) {
                            return AnggaranCard(model: anggaran);
                          }).toList(),
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          color: blue,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(0, -20),
                    blurRadius: 15,
                    spreadRadius: -10,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomButton(
                    title: 'Ajukan Anggaran Baru',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AjukanAnggaran(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => context.read<AuthBloc>().add(AuthSignOut()),
                      child: Text(
                        'Logout',
                        style: semiboldTS.copyWith(color: blue),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeMenu extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final String imageUrl;
  const HomeMenu({
    super.key,
    this.onTap,
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 90,
        width: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: blue,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imageUrl,
              scale: 2,
            ),
            Text(
              title,
              style: boldTS.copyWith(
                fontSize: 12,
                color: Colors.white,
                height: 1.5,
              ),
            )
          ],
        ),
      ),
    );
  }
}
