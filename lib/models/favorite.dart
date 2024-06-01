import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_akhir_pab_ii_bubadibako/models/post.dart';

class Favorite {
  String? id;
  Post? post;

  Favorite({
    this.id,
    this.post,
  });

  factory Favorite.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Favorite(id: doc.id, post: data['post']);
  }

  Map<String, dynamic> toDocument() {
    return {'post': post};
  }
}
