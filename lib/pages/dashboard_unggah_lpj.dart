import 'dart:io';

import 'package:anggaran/models/anggaran_model.dart';
import 'package:anggaran/shared/method.dart';
import 'package:anggaran/widgets/custom_button.dart';
import 'package:anggaran/widgets/profile_appbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/anggaran/anggaran_bloc.dart';
import '../shared/theme.dart';
import '../widgets/custom_field.dart';
import 'dashboard.dart';

class UploadLPJ extends StatefulWidget {
  final AnggaranModel model;
  const UploadLPJ({super.key, required this.model});

  @override
  State<UploadLPJ> createState() => _UploadLPJState();
}

class _UploadLPJState extends State<UploadLPJ> {
  File? fileLPJ;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => AnggaranBloc(),
        child: BlocConsumer<AnggaranBloc, AnggaranState>(
          listener: (context, state) {
            if (state is AnggaranSuccess) {
              // Navigate to Home and show message
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const Dashboard(),
                ),
                (route) => false,
              ).then(
                (_) => showSnackbar(context, message: 'LPJ berhasil disubmit!'),
              );
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
                        widget.model.namaKegiatan.toString(),
                        style: boldTS.copyWith(fontSize: 24, color: blue),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Form(
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Upload LPJ',
                              style:
                                  regularTS.copyWith(fontSize: 15, height: 2),
                            ),
                          ),
                          DisabledFieldWithButton(
                            text: fileLPJ != null
                                ? fileLPJ!.path.split('/').last
                                : 'LPJ.pdf',
                            iconUrl: 'assets/icons/upload.png',
                            onTap: () async {
                              await FilePicker.platform.pickFiles(
                                type: FileType.custom,
                                allowedExtensions: ['pdf'],
                              ).then((value) {
                                if (value != null) {
                                  setState(() {
                                    fileLPJ = File(value.files.single.path!);
                                  });
                                }
                              });
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          CustomButton(
                            title: 'KIRIM LPJ',
                            onTap: () {
                              if (fileLPJ != null) {
                                context.read<AnggaranBloc>().add(
                                      UpdateLPJEvent(
                                        docId: widget.model.idDoc.toString(),
                                        fileLPJ: fileLPJ!,
                                      ),
                                    );
                              } else {
                                showSnackbar(context,
                                    message: 'Harap masukkan file!');
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
