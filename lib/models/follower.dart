import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_akhir_pab_ii_bubadibako/models/user.dart';

class Follower {
  String? id;
  User? user;

  Follower({this.id, this.user});

  factory Follower.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Follower(id: doc.id, user: data['user']);
  }

  Map<String, dynamic> toDocument() {
    return {'user': user};
  }
}
