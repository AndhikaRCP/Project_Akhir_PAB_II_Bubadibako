import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:project_akhir_pab_ii_bubadibako/models/post.dart';
import 'package:project_akhir_pab_ii_bubadibako/services/location_services.dart';

class PostServices {
  static final FirebaseFirestore _database = FirebaseFirestore.instance;
  static final CollectionReference _penggunasCollection =
      _database.collection('penggunas');
  static final FirebaseStorage _storage = FirebaseStorage.instance;
  final String currentActivePenggunaId = FirebaseAuth.instance.currentUser!.uid;
  static CollectionReference _postsCollection = _database.collection("posts");

  Future<void> createPost(
      Post post, BuildContext context, List<File> imageFile) async {
    Position? _currentPosition;
    final currentPosition = await LocationService.getCurrentPosition();
    print("INI LOKASI SEKARANG INI ${currentPosition}");
    _currentPosition = currentPosition;
    post.latitude = _currentPosition?.latitude;
    post.longitude = _currentPosition?.longitude;
    print("INI LONGITUDE : ${ post.longitude }");
    print("INI LATITUDE : ${ post.latitude }");

    int count = 0;
    for (File imageFile in imageFile) {
      post.imageUrl![count] = await uploadImage(
              imageFile, PostServices().currentActivePenggunaId, count)
          .whenComplete(() {
        print("Berhasil Upload File" + count.toString());
      });
      count++;
    }
    await _database.collection('posts').add(post.toDocument()).whenComplete(
        () => Navigator.of(context).pushReplacementNamed('/bottomNav'));
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
      Reference reference = _storage.ref().child('posts/$fileName');
      UploadTask uploadTask = reference.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print("Error uploading image: $e");
      throw Exception("Failed to upload image");
    }
  }

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
  Stream<List<Post>> getAllPosts() {
    bool isFavorite = false;
    List isFavoriteList = [];
    _penggunasCollection
        .doc(currentActivePenggunaId)
        .snapshots()
        .listen((snapshot) {
      Map<String, dynamic> dataPengguna =
          snapshot.data() as Map<String, dynamic>;
      isFavoriteList = dataPengguna['favorite'];
    });

    return _postsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        isFavorite = isFavoriteList.contains(doc.id);
        return Post(
          id: doc.id,
          penggunaId: data['penggunaId'],
          caption: data['caption'],
          imageUrl: List<String>.from(data['image_url']),
          latitude: data['latitude'] as double?,
          longitude: data['longitude'] as double?,
          createdAt: data['created_at'] as Timestamp?,
          updatedAt: data['updated_at'] as Timestamp?,
          isFavorite: isFavorite,
        );
      }).toList();
    });
  }

  Stream<List<Post>> getPostsByIds(List<String> postIds) {
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
