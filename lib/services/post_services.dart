import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_akhir_pab_ii_bubadibako/models/post.dart';

class PostServices {
  static final FirebaseFirestore _database = FirebaseFirestore.instance;
  static final CollectionReference _penggunasCollection =
      _database.collection('penggunas');
  static final FirebaseStorage _storage = FirebaseStorage.instance;
  final String idPengguna = FirebaseAuth.instance.currentUser!.uid;
  static CollectionReference _postsCollection =
      _penggunasCollection.doc(PostServices().idPengguna).collection("posts");

  // Create new post
  static Future<void> createPost(
      Post post, BuildContext context, List<File> imageFile) async {
    print('iINI DARI BACKEND POST: ${PostServices().idPengguna}');
    post.penggunaId = PostServices().idPengguna;
    print(post.toDocument());
    int count = 0;
    for (File imageFile in imageFile!) {
      post.imageUrl![count] = await uploadImage(
              imageFile, PostServices().idPengguna, count)
          .whenComplete(() => print("Berhasil Upload File" + count.toString()));
      count++;
    }
    try {
      await PostServices._postsCollection
          .add(post.toDocument())
          .whenComplete(() {
        print("Berhasil Memposting! sukses");
        Navigator.of(context).pushReplacementNamed('/bottomNav');
      });
    } catch (e) {
      print("Error creating post: $e");
      throw Exception("Failed to create post");
    }
  }

  static Future<void> updateIsFavorite(String postId, bool isFavorite) async {
    try {
      await _postsCollection.doc(postId).update({'isFavorite': isFavorite});
    } catch (e) {
      print("Error updating isFavorite: $e");
      throw Exception("Failed to update isFavorite");
    }
  }

  static Future<String> uploadImage(
      File imageFile, String penggunaId, int index) async {
    try {
      String fileName = imageFile.toString() + '_image' + index.toString();
      print(fileName);
      Reference reference =
          _storage.ref().child('penggunas/$penggunaId/posts/$fileName');
      UploadTask uploadTask = reference.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print("Error uploading image: $e");
      throw Exception("Failed to upload image");
    }
  }

  // // Read all posts as stream
  // static Stream<List<Post>> getAllPosts() {
  //   return _postsCollection.snapshots().map((snapshot) {
  //     return snapshot.docs.map((doc) => Post.fromDocument(doc)).toList();
  //   });
  // }

  // // Read post by ID as stream
  static Stream<List<Post>> getPostsByUserId(String userId) {
    return _postsCollection
        .where('penggunaId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Post(
          id: doc.id,
          penggunaId: data['penggunaId'],
          caption: data['caption'],
          imageUrl: data['image_url'],
          latitude: data['latitude'] as double?,
          longitude: data['longitude'] as double?,
          createdAt: data['created_at'] as Timestamp?,
          updatedAt: data['updated_at'] as Timestamp?,
          isFavorite: data['isFavorite'] ?? false,
        );
      }).toList();
    });
  }

// Read all posts as stream
  static Stream<List<Post>> getAllPosts() {
    return _postsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Post(
          id: doc.id,
          penggunaId: data['penggunaId'],
          caption: data['caption'],
          imageUrl: List<String>.from(data['image_url']),
          latitude: data['latitude'] as double?,
          longitude: data['longitude'] as double?,
          createdAt: data['created_at'] as Timestamp?,
          updatedAt: data['updated_at'] as Timestamp?,
          isFavorite: data['isFavorite'] ?? false,
        );
      }).toList();
    });
  }

  static Stream<List<Post>> getPostsByIds(List<String> postIds) {
    return _postsCollection
        .where(FieldPath.documentId, whereIn: postIds)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Post(
          id: doc.id,
          penggunaId: data['penggunaId'],
          caption: data['caption'],
          imageUrl: List<String>.from(data['image_url']),
          latitude: data['latitude'] as double?,
          longitude: data['longitude'] as double?,
          createdAt: data['created_at'] as Timestamp?,
          updatedAt: data['updated_at'] as Timestamp?,
          isFavorite: data['isFavorite'] ?? false,
        );
      }).toList();
    });
  }

  // // Update post
  // static Future<void> updatePost(Post post) async {
  //   try {
  //     await _postsCollection.doc(post.id).update(post.toDocument());
  //   } catch (e) {
  //     print("Error updating post: $e");
  //     throw Exception("Failed to update post");
  //   }
  // }

  // // Delete post
  // static Future<void> deletePost(String id) async {
  //   try {
  //     await _postsCollection.doc(id).delete();
  //   } catch (e) {
  //     print("Error deleting post: $e");
  //     throw Exception("Failed to delete post");
  //   }
  // }
}
