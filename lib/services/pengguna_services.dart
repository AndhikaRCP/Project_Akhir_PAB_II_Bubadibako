// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:project_akhir_pab_ii_bubadibako/models/Following.dart';
// import 'package:project_akhir_pab_ii_bubadibako/models/favorite.dart';
// import 'package:project_akhir_pab_ii_bubadibako/models/follower.dart';
// import 'package:project_akhir_pab_ii_bubadibako/models/post.dart';
// import 'package:project_akhir_pab_ii_bubadibako/models/pengguna.dart';

// class penggunaServices {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Stream<pengguna?> getpenggunaData(String penggunaId) {
//   return _firestore
//       .collection('penggunas')
//       .doc(penggunaId)
//       .snapshots()
//       .map((snapshot) {
//     if (snapshot.exists) {
//       Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
//       return pengguna(
//         id: snapshot.id,
//         penggunaname: data['penggunaname'],
//         email: data['email'],
//         password: data['password'],
//         favorite: List<Favorite>.from(data['favorite']),
//         followers: List<Follower>.from(data['followers']),
//         following: List<Following>.from(data['following']),
//         posts: List<Post>.from(data['posts']),
//       );
//     } else {
//       print('pengguna data not found');
//       return null;
//     }
//   });
// }

//   Future<Map<String, dynamic>?> createpengguna(
//       String penggunaId, String penggunaname, String email) async {
//     await _firestore.collection('penggunas').doc(penggunaId).set({
//       'penggunaname': penggunaname,
//       'email': email,
//     });
//     return null;
//   }

//    Future<void> updatepengguna(
//       String penggunaId, String newpenggunaname, String newEmail) async {
//         print('Data pengguna berhasil diperbarui di Firestore');
//     try {
//       await _firestore.collection('penggunas').doc(penggunaId).update({
//         'penggunaname': newpenggunaname,
//         'email': newEmail,
//       });
//       print('Data pengguna berhasil diperbarui di Firestore');
//     } catch (e) {
//       print('Gagal memperbarui data pengguna: $e');
//       throw Exception('Gagal memperbarui data pengguna');
//     }
//   }
// }

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:project_akhir_pab_ii_bubadibako/models/pengguna.dart';

class penggunaServices {
  static final FirebaseFirestore _database = FirebaseFirestore.instance;
  static final CollectionReference _penggunascollection =
      _database.collection('penggunas');
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static Future<String?> uploadImage(XFile imageFile) async {
    try {
      String fileName = path.basename(imageFile.path);
      Reference ref = _storage.ref().child('images/$fileName');

      UploadTask uploadTask;
      if (kIsWeb) {
        uploadTask = ref.putData(await imageFile.readAsBytes());
      } else {
        uploadTask = ref.putFile(File(imageFile.path));
      }

      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> createpengguna(
      String penggunaId, String penggunaname, String email) async {
    await _database.collection('penggunas').doc(penggunaId).set({
      'username': penggunaname,
      'email': email,
    });
    return null;
  }

  static Future<void> createUpdate(Pengguna pengguna) async {
    Map<String, dynamic> updatedpengguna = {
      'username': pengguna.username,
      'email': pengguna.email,
      'password': pengguna.password,
      'favorite': pengguna.favorite,
      'followers': pengguna.followers,
      'following': pengguna.following,
      'posts': pengguna.posts
    };
    await _penggunascollection.doc(pengguna.id).update(updatedpengguna);
  }

  static Future<void> updateProfilPengguna(Pengguna pengguna, BuildContext context) async {
    
    Map<String, dynamic> updatedPengguna = {
      'email': pengguna.email,
      'username': pengguna.username,
      // 'password': pengguna.password,
      // 'favorite': pengguna.favorite,
      // 'followers': pengguna.followers,
      // 'following': pengguna.following,
      // 'posts': pengguna.posts
    };
    try {
      
    await _penggunascollection.doc(pengguna.id).update(updatedPengguna).whenComplete(() =>  Navigator.of(context).pop());
   
    }catch(e) {
      print(
        "Update gagal"
      );
    }
  }

  static Stream<List<Pengguna>> getAllpenggunasData() {
    return _penggunascollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Pengguna(
          id: doc.id,
          username: data['username'] ?? '',
          password: data['password'] ?? '',
          email: data['email'] ?? '',
          favorite: data['favorite'] ?? [],
          followers: data['followers'] ?? [],
          following: data['following'] ?? [],
          posts: data['posts'] ?? [],
        );
      }).toList();
    });
  }

  static Stream<Pengguna?> getpenggunaById(String penggunaId) {
    return _penggunascollection.doc(penggunaId).snapshots().map((snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        return Pengguna(
          id: snapshot.id,
          username: data['username'] ?? '',
          password: data['password'] ?? '',
          email: data['email'] ?? '',
          favorite: data['favorite'] ?? [],
          followers: data['followers'] ?? [],
          following: data['following'] ?? [],
          posts: data['posts'] ?? [],
        );
      } else {
        return null;
      }
    });
  }

  static Future<QuerySnapshot> retrieveAllpengguna() {
    return _penggunascollection.get();
  }
}
