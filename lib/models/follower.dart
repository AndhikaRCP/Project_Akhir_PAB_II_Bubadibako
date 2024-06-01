import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_akhir_pab_ii_bubadibako/models/pengguna.dart';

class Follower {
  String? id;
  Pengguna? pengguna;

  Follower({this.id, this.pengguna});

  factory Follower.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Follower(id: doc.id, pengguna: data['pengguna']);
  }

  Map<String, dynamic> toDocument() {
    return {'pengguna': pengguna};
  }
}
