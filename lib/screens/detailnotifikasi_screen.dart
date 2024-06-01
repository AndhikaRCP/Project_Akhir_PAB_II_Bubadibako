import 'package:flutter/material.dart';
import 'package:project_akhir_pab_ii_bubadibako/models/notification.dart';

class DetailNotifikasi extends StatelessWidget {
  final Notifikasi notification;

  DetailNotifikasi({required this.notification});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notification.judul,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                notification.deskripsiNotifikasi,
                style: TextStyle(fontSize: 14),
              ),
              // Tambahkan widget lainnya untuk menampilkan informasi tambahan tentang notifikasi
            ],
          ),
        ),
      ),
    );
  }
}
