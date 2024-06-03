import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteServices {
  static final FirebaseFirestore _database = FirebaseFirestore.instance;
  static final CollectionReference _penggunasCollection =
      _database.collection('penggunas');

  // Method untuk menambahkan postingan ke daftar favorit
  static Future<void> addToFavorites(String userId, String postId) async {
    try {
      DocumentSnapshot userDoc = await _penggunasCollection.doc(userId).get();

      // Periksa apakah properti 'favorite' sudah ada dalam dokumen pengguna
      if (userDoc.data() is Map &&
          (userDoc.data() as Map).containsKey('favorite')) {
        // Jika ada, ambil daftar favorit dari dokumen
        List<dynamic> favoritedPosts = List.from(userDoc['favorite'] ?? []);
        favoritedPosts.add(postId);

        // Perbarui dokumen pengguna dengan daftar favorit yang baru
        await _penggunasCollection.doc(userId).update({
          'favorite': favoritedPosts,
        });
      } else {
        // Jika tidak, tetapkan properti 'favorite' sebagai daftar kosong
        await _penggunasCollection.doc(userId).update({
          'favorite': [postId],
        });
      }

      print('Postingan berhasil ditambahkan ke daftar favorit.');
    } catch (e) {
      print('Error adding post to favorites: $e');
      throw Exception('Failed to add post to favorites');
    }
  }

static Stream<List<String>> getFavoritePostsByIdStream(String userId) {
  StreamController<List<String>> controller = StreamController<List<String>>();

  _penggunasCollection.doc(userId).snapshots().listen((DocumentSnapshot userDoc) {
    List<dynamic> favoritedPosts = userDoc['favorite'];
    print('Daftar postingan favorit diperoleh.');
    controller.add(favoritedPosts.cast<String>());
  }, onError: (error) {
    print('Error getting favorite posts: $error');
    controller.addError('Failed to get favorite posts');
  });

  return controller.stream;
}

static Stream<bool> isPostFavoriteStream(String userId, String postId) {
  return getFavoritePostsByIdStream(userId).map((favoritePosts) {
    return favoritePosts.contains(postId);
  }).handleError((error) {
    print('Error checking if post is favorite: $error');
    throw Exception('Failed to check if post is favorite');
  });
}

static Future<List<String>> getFavoritePostsById(String userId) async {
  try {
    DocumentSnapshot userDoc = await _penggunasCollection.doc(userId).get();
    List<dynamic> favoritedPosts = userDoc['favorite'];

    print('Daftar postingan favorit diperoleh.');
    return favoritedPosts.cast<String>(); // Konversi ke List<String>
  } catch (e) {
    print('Error getting favorite posts: $e');
    throw Exception('Failed to get favorite posts');
  }
}


  static Future<void> removeFromFavorites(String userId, String postId) async {
    try {
      DocumentSnapshot userDoc = await _penggunasCollection.doc(userId).get();
      List<dynamic> favoritedPosts = userDoc['favorite'];
      favoritedPosts.remove(postId);
      await _penggunasCollection.doc(userId).update({
        'favorite': favoritedPosts,
      });

      print('Postingan berhasil dihapus dari daftar favorit.');
    } catch (e) {
      print('Error removing post from favorites: $e');
      throw Exception('Failed to remove post from favorites');
    }
  }
}
