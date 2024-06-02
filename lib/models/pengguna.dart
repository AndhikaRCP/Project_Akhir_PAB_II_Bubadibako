  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:project_akhir_pab_ii_bubadibako/models/Following.dart';
  import 'package:project_akhir_pab_ii_bubadibako/models/favorite.dart';
  import 'package:project_akhir_pab_ii_bubadibako/models/follower.dart';
import 'package:project_akhir_pab_ii_bubadibako/models/penggunaAbout.dart';
  import 'package:project_akhir_pab_ii_bubadibako/models/post.dart';

  class Pengguna {
    String? id;
    String? username;
    String? email;
    String? password;
    String? profileImageUrl;
    String? backgroundImageUrl;
    PenggunaAbout? penggunaAbout;
    List<Post>? posts;
    List<Follower>? followers;
    List<Following>? following;
    List<Favorite>? favorite;

    Pengguna(
        {this.id,
        this.username,
        this.email,
        this.password,
        this.backgroundImageUrl,
        this.profileImageUrl,
        this.posts,
        this.followers,
        this.following,
        this.penggunaAbout,
        this.favorite});

    factory Pengguna.fromDocument(DocumentSnapshot doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Pengguna(
          id: doc.id,
          username: data['username'],
          password: data['password'],
          email: data['email'],
          favorite: data['favorite'],
          followers: data['followers'],
          following: data['following'],
          profileImageUrl: data['profileImageUrl'],
          backgroundImageUrl: data['backgroundImageUrl'],
          penggunaAbout: data['penggunaAbout'],
          posts: data['posts']);
    }

    Map<String, dynamic> toDocument() {
      return {
        'username': username,
        'email': email,
        'password': password,
        'favorite': favorite,
        'followers': followers,
        'following': following,
        'backgroundImageUrl':backgroundImageUrl,
        'profileImageUrl':profileImageUrl,
        'penggunaAbout': penggunaAbout,
        'posts': posts,
      };
    }
  }
