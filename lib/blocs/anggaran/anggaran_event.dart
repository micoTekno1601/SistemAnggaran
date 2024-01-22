part of 'anggaran_bloc.dart';

sealed class AnggaranEvent extends Equatable {
  const AnggaranEvent();

  @override
  List<Object> get props => [];
}

class SubmitProposalEvent extends AnggaranEvent {
  final String namaKegiatan;
  final DateTime tanggalKegiatan;
  final num jumlahAnggaran;
  final String dosenPJ;
  final File fileRAB;

  const SubmitProposalEvent({
    required this.namaKegiatan,
    required this.tanggalKegiatan,
    required this.jumlahAnggaran,
    required this.dosenPJ,
    required this.fileRAB,
  });

  @override
  List<Object> get props => [
        namaKegiatan,
        tanggalKegiatan,
        jumlahAnggaran,
        dosenPJ,
        fileRAB,
      ];
}

class UpdateLPJEvent extends AnggaranEvent {
  final String docId;
  final File fileLPJ;

  const UpdateLPJEvent({
    required this.docId,
    required this.fileLPJ,
  });

  @override
  List<Object> get props => [docId, fileLPJ];
}

class StreamAnggaranEvent extends AnggaranEvent {}
