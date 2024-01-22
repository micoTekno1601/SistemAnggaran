import 'dart:io';

import 'package:anggaran/models/anggaran_model.dart';
import 'package:anggaran/repositories/anggaran_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'anggaran_event.dart';
part 'anggaran_state.dart';

class AnggaranBloc extends Bloc<AnggaranEvent, AnggaranState> {
  AnggaranBloc() : super(AnggaranInitial()) {
    final service = AnggaranRepository();
    final user = FirebaseAuth.instance.currentUser;

    on<SubmitProposalEvent>((event, emit) async {
      emit(AnggaranLoading());
      try {
        await service.uploadProposal(
          model: AnggaranModel(
            uid: user!.uid,
            namaKegiatan: event.namaKegiatan,
            tanggalKegiatan: event.tanggalKegiatan,
            jumlahAnggaran: event.jumlahAnggaran,
            dosenPJ: event.dosenPJ,
          ),
          file: event.fileRAB,
        );
        emit(AnggaranSuccess());
      } catch (e) {
        emit(AnggaranError(e.toString()));
      }
    });

    on<UpdateLPJEvent>((event, emit) async {
      emit(AnggaranLoading());
      try {
        await service.updateLPJ(docId: event.docId, file: event.fileLPJ);
        emit(AnggaranSuccess());
      } catch (e) {
        emit(AnggaranError(e.toString()));
      }
    });

    on<StreamAnggaranEvent>(
      (event, emit) async {
        await emit.onEach(
          service.streamMyAnggaran(),
          onData: (data) => emit(StreamAnggaranSuccess(data)),
          onError: (error, stackTrace) => emit(AnggaranError(error.toString())),
        );
      },
    );
  }
}
