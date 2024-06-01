import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_akhir_pab_ii_bubadibako/models/user.dart';

class Comment {
  String? id;
  String? textComment;
  User? user;

  Comment({this.id, this.textComment, this.user});

  factory Comment.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Comment(
      id: doc.id,
      textComment: data['textComment'],
      user: data['user'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {'textComment': textComment, 'user': user};
  }
}
