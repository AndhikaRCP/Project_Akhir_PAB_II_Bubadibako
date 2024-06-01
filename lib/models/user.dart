import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_akhir_pab_ii_bubadibako/models/Following.dart';
import 'package:project_akhir_pab_ii_bubadibako/models/favorite.dart';
import 'package:project_akhir_pab_ii_bubadibako/models/follower.dart';
import 'package:project_akhir_pab_ii_bubadibako/models/post.dart';

class User {
  String? id;
  String? username;
  String? password;
  List<Post>? posts;
  List<Follower>? followers;
  List<Following>? following;
  List<Favorite>? favorite;

  User(
      {this.id,
      this.username,
      this.password,
      this.posts,
      this.followers,
      this.following,
      this.favorite});

  factory User.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return User(
        id: doc.id,
        username: data['username'],
        password: data['password'],
        favorite: data['favorite'],
        followers: data['followers'],
        following: data['following'],
        posts: data['posts']);
  }

  Map<String, dynamic> toDocument() {
    return {
      'username': username,
      'password': password,
      'favorite': favorite,
      'followers': followers,
      'following': following,
      'posts': posts
    };
  }
}
