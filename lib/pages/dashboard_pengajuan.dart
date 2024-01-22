import 'dart:io';

import 'package:anggaran/blocs/anggaran/anggaran_bloc.dart';
import 'package:anggaran/pages/dashboard.dart';
import 'package:anggaran/shared/method.dart';
import 'package:anggaran/shared/theme.dart';
import 'package:anggaran/widgets/custom_button.dart';
import 'package:anggaran/widgets/custom_field.dart';
import 'package:anggaran/widgets/profile_appbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../blocs/auth/auth_bloc.dart';

class AjukanAnggaran extends StatefulWidget {
  const AjukanAnggaran({super.key});

  @override
  State<AjukanAnggaran> createState() => _AjukanAnggaranState();
}

class _AjukanAnggaranState extends State<AjukanAnggaran> {
  final namaKegiatanController = TextEditingController();
  DateTime tanggalKegiatan = DateTime.now();
  final jumlahAnggaranController = TextEditingController();
  final dosenPJController = TextEditingController();
  File? fileRAB;

  bool checkFields() {
    return namaKegiatanController.text.isEmpty ||
        jumlahAnggaranController.text.isEmpty ||
        dosenPJController.text.isEmpty ||
        fileRAB == null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => AnggaranBloc(),
        child: BlocConsumer<AnggaranBloc, AnggaranState>(
          listener: (context, state) {
            if (state is AnggaranSuccess) {
              // Navigate to Home and Show Message
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const Dashboard(),
                ),
                (route) => false,
              ).then((_) {
                showSnackbar(context, message: 'Proposal berhasil disubmit!');
              });
            }
            if (state is AnggaranError) {
              showSnackbar(context, message: state.e);
            }
          },
          builder: (context, state) {
            if (state is AnggaranLoading) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(color: blue),
                ),
              );
            }
            return Scaffold(
              body: ListView(
                children: [
                  ProfileAppbar(
                    menu: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Text(
                        'Pengajuan Anggaran',
                        style: boldTS.copyWith(fontSize: 24, color: blue),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Form(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Nama Kegiatan
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Nama Kegiatan',
                              style:
                                  regularTS.copyWith(fontSize: 15, height: 2),
                            ),
                          ),
                          CustomField(
                            controller: namaKegiatanController,
                            hintText: 'Expo Academic',
                          ),

                          // Tanggal Kegiatan
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Tanggal Kegiatan',
                              style:
                                  regularTS.copyWith(fontSize: 15, height: 2),
                            ),
                          ),
                          DisabledFieldWithButton(
                            text: DateFormat('dd/MM/yyyy')
                                .format(tanggalKegiatan),
                            iconUrl: 'assets/icons/calendar.png',
                            onTap: () {
                              // Show date picker
                              showDatePicker(
                                context: context,
                                initialDate: tanggalKegiatan,
                                firstDate: DateTime(1970),
                                lastDate: DateTime(2070),
                              ).then((value) {
                                // Set the date
                                if (value != null) {
                                  setState(() => tanggalKegiatan = value);
                                }
                              });
                            },
                          ),

                          // Jumlah Anggaran
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Jumlah Anggaran',
                              style:
                                  regularTS.copyWith(fontSize: 15, height: 2),
                            ),
                          ),
                          CustomField(
                            controller: jumlahAnggaranController,
                            keyboardType: TextInputType.number,
                            hintText: 'Masukkan jumlah dana anggaran',
                          ),

                          // Dosen PJ
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Dosen Penanggung Jawab',
                              style:
                                  regularTS.copyWith(fontSize: 15, height: 2),
                            ),
                          ),
                          CustomField(
                            controller: dosenPJController,
                            hintText: 'Masukkan nama dosen penanggung jawab',
                          ),

                          // RAB File
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Upload RAB',
                              style:
                                  regularTS.copyWith(fontSize: 15, height: 2),
                            ),
                          ),
                          DisabledFieldWithButton(
                            text: fileRAB != null
                                ? fileRAB!.path.split('/').last
                                : 'RAB.pdf',
                            iconUrl: 'assets/icons/upload.png',
                            onTap: () async {
                              await FilePicker.platform.pickFiles(
                                type: FileType.custom,
                                allowedExtensions: ['pdf'],
                              ).then((value) {
                                if (value != null) {
                                  setState(() {
                                    fileRAB = File(value.files.single.path!);
                                  });
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  )
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
                        title: 'AJUKAN ANGGARAN',
                        onTap: () {
                          if (!checkFields()) {
                            context.read<AnggaranBloc>().add(
                                  SubmitProposalEvent(
                                    namaKegiatan: namaKegiatanController.text,
                                    tanggalKegiatan: tanggalKegiatan,
                                    jumlahAnggaran: num.tryParse(
                                        jumlahAnggaranController.text)!,
                                    dosenPJ: dosenPJController.text,
                                    fileRAB: fileRAB!,
                                  ),
                                );
                          } else {
                            showSnackbar(context,
                                message: 'Harap isi semua bagian form!');
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () =>
                              context.read<AuthBloc>().add(AuthSignOut()),
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
            );
          },
        ),
      ),
    );
  }
}
