import 'package:cloud_firestore/cloud_firestore.dart';

class AnggaranModel {
  final String? uid;
  final String? idDoc;
  final String? namaKegiatan;
  final DateTime? tanggalKegiatan;
  final num? jumlahAnggaran;
  final String? dosenPJ;
  final String? linkRAB;
  final String? linkLPJ;

  AnggaranModel({
    this.uid,
    this.idDoc,
    this.namaKegiatan,
    this.tanggalKegiatan,
    this.jumlahAnggaran,
    this.dosenPJ,
    this.linkRAB,
    this.linkLPJ,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid ?? '',
      'idDoc': idDoc ?? '',
      'namaKegiatan': namaKegiatan ?? '',
      'tanggalKegiatan': tanggalKegiatan,
      'jumlahAnggaran': jumlahAnggaran ?? 0,
      'dosenPJ': dosenPJ ?? '',
      'linkRAB': linkRAB ?? '',
      'linkLPJ': linkLPJ ?? '',
    };
  }

  factory AnggaranModel.fromJson(Map<String, dynamic> json) {
    return AnggaranModel(
      uid: json['uid'] ?? '',
      idDoc: json['idDoc'] ?? '',
      namaKegiatan: json['namaKegiatan'] ?? '',
      tanggalKegiatan: (json['tanggalKegiatan'] as Timestamp).toDate(),
      jumlahAnggaran: json['jumlahAnggaran'] ?? 0,
      dosenPJ: json['dosenPJ'] ?? '',
      linkRAB: json['linkRAB'] ?? '',
      linkLPJ: json['linkLPJ'] ?? '',
    );
  }
}
