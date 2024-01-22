import 'package:anggaran/shared/theme.dart';
import 'package:anggaran/widgets/custom_ellipse.dart';
import 'package:anggaran/widgets/menu_deck.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/dashboard_pengaturan.dart';

class ProfileAppbar extends StatelessWidget {
  final Widget menu;
  const ProfileAppbar({
    super.key,
    required this.menu,
  });

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Column(
          children: [
            Container(
              height: 270, // before is 300
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    lightBlue,
                    blue,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(70),
                ),
              ),
              child: Stack(
                children: [
                  const Positioned(
                    top: -40,
                    left: -40,
                    child: CustomEllipse(),
                  ),
                  const Positioned(
                    bottom: -80,
                    right: -80,
                    child: CustomEllipse(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hallo Selamat Datang',
                                style: regularTS.copyWith(
                                  fontSize: 15,
                                  color: Colors.white,
                                  height: 1.8,
                                ),
                              ),
                              Text(
                                user!.email!.split('@')[0],
                                style: boldTS.copyWith(
                                  fontSize: 32,
                                  color: Colors.white,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const Pengaturan(),
                              ),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                radius: 36,
                                backgroundImage:
                                    AssetImage('assets/images/profile.jpg'),
                                backgroundColor: Colors.white,
                              ),
                              Text(
                                'Atur Profil',
                                style: boldTS.copyWith(
                                  fontSize: 12,
                                  color: Colors.white,
                                  height: 1.8,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
        MenuDeck(
          child: menu,
        ),
      ],
    );
  }
}
