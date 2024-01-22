import 'package:anggaran/blocs/anggaran/anggaran_bloc.dart';
import 'package:anggaran/firebase_options.dart';
import 'package:anggaran/pages/dashboard.dart';
import 'package:anggaran/pages/landing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/auth/auth_bloc.dart';
import 'repositories/auth_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              auth: RepositoryProvider.of<AuthRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => AnggaranBloc(),
          ),
        ],
        child: MaterialApp(
          title: 'Anggaran App',
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const Dashboard();
              }
              return const LandingPage(); // if snapshot hasn't data (no session)
            },
          ),
        ),
      ),
    );
  }
}
