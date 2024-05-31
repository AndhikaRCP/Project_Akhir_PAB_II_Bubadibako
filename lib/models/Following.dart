import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_akhir_pab_ii_bubadibako/models/user.dart';

class Following {
  String? id;
  User? user;

  Following({this.id, this.user});

  factory Following.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Following(id: doc.id, user: data['user']);
  }

  Map<String, dynamic> toDocument() {
    return {'user': user};
  }
}
