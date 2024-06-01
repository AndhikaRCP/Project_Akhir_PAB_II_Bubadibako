import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_akhir_pab_ii_bubadibako/models/pengguna.dart';

class Comment {
  String? id;
  String? textComment;
  Pengguna? pengguna;

  Comment({this.id, this.textComment, this.pengguna});

  factory Comment.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Comment(
      id: doc.id,
      textComment: data['textComment'],
      pengguna: data['pengguna'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {'textComment': textComment, 'pengguna': pengguna};
  }
}
