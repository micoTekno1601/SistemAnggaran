import 'package:anggaran/shared/theme.dart';
import 'package:anggaran/widgets/profile_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/anggaran/anggaran_bloc.dart';

class Notifikasi extends StatelessWidget {
  const Notifikasi({super.key});

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
                  'Notifikasi',
                  style: boldTS.copyWith(fontSize: 24, color: blue),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: BlocProvider(
                create: (context) => AnggaranBloc()..add(StreamAnggaranEvent()),
                child: BlocBuilder<AnggaranBloc, AnggaranState>(
                  builder: (context, state) {
                    if (state is StreamAnggaranSuccess) {
                      return ListView(
                        padding: const EdgeInsets.all(20),
                        children: state.data.map((anggaran) {
                          return ListTile(
                            isThreeLine: true,
                            leading: const Icon(Icons.notifications),
                            title: Text(
                              anggaran.namaKegiatan.toString(),
                            ),
                            subtitle: const Text('Proposal berhasil diunggah.'),
                          );
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
      ),
    );
  }
}
