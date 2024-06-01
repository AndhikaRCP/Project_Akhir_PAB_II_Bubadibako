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

  static Future<void> updateProfilPengguna(
      Pengguna pengguna, BuildContext context) async {
    Map<String, dynamic> updatedPengguna = {
      'email': pengguna.email,
      'username': pengguna.username,
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
  
  CollectionReference aboutCollection = _penggunascollection.doc(pengguna.id).collection("about");

  try {
    // Cek apakah koleksi "about" sudah ada
    QuerySnapshot aboutDocs = await aboutCollection.get();

    // Jika koleksi "about" belum ada, tambahkan data
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
      print(updatedPengguna);
      await aboutDocRef.update(updatedPengguna).whenComplete(() => print("About diperbarui"));
      
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

  Future<QuerySnapshot> getAboutData(String userId) async {
    CollectionReference penggunaCollection =
        FirebaseFirestore.instance.collection('pengguna');
    DocumentSnapshot penggunaDoc = await penggunaCollection.doc(userId).get();
    if (penggunaDoc.exists) {
      CollectionReference aboutCollection =
          penggunaDoc.reference.collection('about');
      return aboutCollection.get();
    } else {
      throw Exception('Dokumen pengguna tidak ditemukan');
    }
  }

  Future<void> createAboutData(String userId, Map<String, dynamic> data) async {
    CollectionReference penggunaCollection =
        FirebaseFirestore.instance.collection('pengguna');
    DocumentReference penggunaDoc = penggunaCollection.doc(userId);
    CollectionReference aboutCollection = penggunaDoc.collection('about');
    await aboutCollection.add(data);
  }

  Future<void> updateAboutData(
      String userId, String aboutId, Map<String, dynamic> newData) async {
    CollectionReference penggunaCollection =
        FirebaseFirestore.instance.collection('pengguna');
    DocumentReference penggunaDoc = penggunaCollection.doc(userId);
    CollectionReference aboutCollection = penggunaDoc.collection('about');
    DocumentReference aboutDoc = aboutCollection.doc(aboutId);
    await aboutDoc.update(newData);
  }
}
