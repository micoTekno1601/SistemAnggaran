import 'dart:io';

import 'package:anggaran/models/anggaran_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AnggaranRepository {
  final _user = FirebaseAuth.instance.currentUser;
  final _firestore = FirebaseFirestore.instance.collection('anggaran');
  final _storage = FirebaseStorage.instance;

  Future<String> uploadRAB({
    required String name,
    required File file,
  }) async {
    final storageRef = _storage.ref().child('anggaran/rab/$name.pdf');
    final uploadTask = storageRef.putFile(file);

    final snapshot = await uploadTask;
    final downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }

  Future<void> uploadProposal({
    required AnggaranModel model,
    required File file,
  }) async {
    // Upload the Data
    await _firestore.add(model.toJson()).then((doc) async {
      // Upload File RAB
      await uploadRAB(name: doc.id, file: file).then((linkRAB) async {
        // Update the document id and RAB file link
        await _firestore.doc(doc.id).update({
          'idDoc': doc.id,
          'linkRAB': linkRAB,
        });
      });
    });
  }

  Future<String> uploadLPJ({
    required String name,
    required File file,
  }) async {
    final storageRef = _storage.ref().child('anggaran/lpj/$name.pdf');
    final uploadTask = storageRef.putFile(file);

    final snapshot = await uploadTask;
    final downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }

  Future<void> updateLPJ({
    required String docId,
    required File file,
  }) async {
    // Upload File LPJ
    await uploadLPJ(name: docId, file: file).then((linkLPJ) async {
      // Update the LPJ file link
      await _firestore.doc(docId).update({
        'linkLPJ': linkLPJ,
      });
    });
  }

  Stream<List<AnggaranModel>> streamMyAnggaran() {
    return _firestore
        .where('uid', isEqualTo: _user!.uid)
        .snapshots()
        .asyncMap((anggaranSnapshot) {
      List<AnggaranModel> anggaranList = [];

      for (QueryDocumentSnapshot doc in anggaranSnapshot.docs) {
        final anggaran =
            AnggaranModel.fromJson(doc.data() as Map<String, dynamic>);
        anggaranList.add(anggaran);
      }
      return anggaranList;
    });
  }
}
