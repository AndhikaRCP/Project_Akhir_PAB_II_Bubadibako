import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:project_akhir_pab_ii_bubadibako/models/pengguna.dart';
import 'package:project_akhir_pab_ii_bubadibako/models/penggunaAbout.dart';

class penggunaServices {
  static final FirebaseFirestore _database = FirebaseFirestore.instance;
  static final CollectionReference _penggunascollection =
      _database.collection('penggunas');
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static Future<String?> uploadProfileImage(
      File imageFile, String penggunaId, String fileName) async {
    try {
      Reference ref = _storage.ref().child('penggunas/$penggunaId/$fileName');

      UploadTask uploadTask;
      if (kIsWeb) {
        uploadTask = ref.putData(await imageFile.readAsBytes());
      } else {
        uploadTask = ref.putFile(File(imageFile.path));
      }

      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      print("BERHASIL UPLOAD IMAGE DARI PROFILE");
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
      'favorite': []
    });
    return null;
  }

  static Future<void> updateProfilPengguna(
      Pengguna pengguna, BuildContext context) async {
    print(pengguna.profileImageUrl);
    Map<String, dynamic> updatedPengguna = {
      'email': pengguna.email,
      'username': pengguna.username,
      'profileImageUrl': pengguna.profileImageUrl,
      'backgroundImageUrl': pengguna.backgroundImageUrl
    };
    try {
      await _penggunascollection
          .doc(pengguna.id)
          .update(updatedPengguna)
          .whenComplete(() => Navigator.of(context).pop());
    } catch (e) {
      print("Update gagal");
    }
  }

  static Future<void> updateAboutProfilePengguna(
      Pengguna pengguna, BuildContext context) async {
    CollectionReference aboutCollection =
        _penggunascollection.doc(pengguna.id).collection("penggunaAbout");

    try {
      QuerySnapshot aboutDocs = await aboutCollection.get();

      if (aboutDocs.docs.isEmpty) {
        Map<String, dynamic> updatedPengguna = {
          'text': pengguna.penggunaAbout?.text,
          'imageUrl': pengguna.penggunaAbout?.imageUrl,
        };

        await aboutCollection.add(updatedPengguna);
        print("About selesai dibuat");
      } else {
        // Ambil ID dokumen pertama dalam koleksi "about"
        String aboutDocId = aboutDocs.docs.first.id;

        // Buat referensi ke dokumen yang ada
        DocumentReference aboutDocRef = aboutCollection.doc(aboutDocId);

        // Update data di dalam dokumen
        Map<String, dynamic> updatedPengguna = {
          'text': pengguna.penggunaAbout?.text,
          'imageUrl': pengguna.penggunaAbout?.imageUrl,
        };
        await aboutDocRef.update(updatedPengguna).whenComplete(() {
          print("Berhasil Update About");
          Navigator.of(context).pop();
        });
      }
    } catch (e) {
      print("Gagal mengupdate koleksi 'about': $e");
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
            followers: data['followers'] ?? [],
            following: data['followings'] ?? [],
            penggunaAbout: data['penggunaAbout'],
            favorite: data['favorite'],
            posts: data['posts'] ?? [],
            profileImageUrl: data['profileImageUrl'],
            backgroundImageUrl: data['backgroundImageUrl']);
      } else {
        return null;
      }
    });
  }

  static Stream<PenggunaAbout?> getPenggunaAboutProfile(String userId) {
    CollectionReference penggunaCollection =
        FirebaseFirestore.instance.collection('penggunas');
    return penggunaCollection
        .doc(userId)
        .collection('penggunaAbout')
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        // Ambil data dari dokumen pertama
        Map<String, dynamic> aboutData =
            snapshot.docs.first.data() as Map<String, dynamic>;
        // Tambahkan ID dokumen ke dalam data
        aboutData['id'] = snapshot.docs.first.id;
        // Buat objek PenggunaAbout dari data yang diperoleh
        return PenggunaAbout.fromMap(aboutData);
      } else {
        // Jika tidak ada dokumen, kembalikan null
        return null;
      }
    });
  }

  static Future<String> uploadImagePenggunaAbout(
      String userId, String aboutId, File imageFile) async {
    try {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('penggunas/$userId/penggunaAbout/$aboutId/image.png');
      UploadTask uploadTask = storageReference.putFile(imageFile);
      print("MasdageMethod");
      TaskSnapshot taskSnapshot = await uploadTask;
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print('Error uploading image: $e');
      rethrow;
    }
  }
}
