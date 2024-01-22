import 'package:anggaran/models/anggaran_model.dart';
import 'package:anggaran/pages/dashboard_unggah_lpj.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../shared/theme.dart';
import 'custom_button.dart';

class AnggaranCard extends StatelessWidget {
  final AnggaranModel model;
  const AnggaranCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            offset: Offset(0, 5),
            blurRadius: 8,
            spreadRadius: -6,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  model.namaKegiatan.toString(),
                  style: semiboldTS.copyWith(fontSize: 18),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  DateFormat('dd/MM/yyyy').format(model.tanggalKegiatan!),
                  style: mediumTS,
                ),
                Text(
                  'Rp ${model.jumlahAnggaran}',
                  style: mediumTS,
                ),
                Text(
                  '${model.dosenPJ}',
                  style: mediumTS,
                )
              ],
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          SizedBox(
            width: 130,
            child: model.linkLPJ!.isEmpty
                ? CustomButton(
                    title: 'Unggah LPJ',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => UploadLPJ(
                            model: model,
                          ),
                        ),
                      );
                    },
                  )
                : const CustomButton(
                    title: 'Selesai',
                    disabled: true,
                  ),
          )
        ],
      ),
    );
  }
}
