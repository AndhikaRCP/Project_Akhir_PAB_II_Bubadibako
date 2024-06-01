import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_akhir_pab_ii_bubadibako/models/pengguna.dart';

class Following {
  String? id;
  Pengguna? pengguna;

  Following({this.id, this.pengguna});

  factory Following.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Following(id: doc.id, pengguna: data['pengguna']);
  }

  Map<String, dynamic> toDocument() {
    return {'pengguna': pengguna};
  }
}
