import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_akhir_pab_ii_bubadibako/services/user_services.dart';

class AuthServices {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signUpWithEmailAndPassword(
      String email, String username, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      try {
        String userId = credential.user!.uid;
        await _firestore.collection('users').doc(userId).set({
          'username': username,
          'email': email,
        });
        print('Data pengguna berhasil disimpan di Firestore');
      } catch (e) {
        print('Gagal menyimpan data pengguna: $e');
      }
      return credential.user;
    } catch (e) {
      print("Proses Sign Up gagal" );
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print("Proses Login gagal");
    }
    return null;
  }

   User? get currentUser => _auth.currentUser;

  // Metode untuk mendapatkan data pengguna yang sedang masuk
  Future<Map<String, dynamic>?> getCurrentUserData() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        // Mengambil data pengguna dari Firestore berdasarkan UID
        return await UserServices().getUserData(user.uid);
      } else {
        print('Tidak ada pengguna yang sedang masuk');
        return null;
      }
    } catch (e) {
      print('Gagal mengambil data pengguna yang sedang masuk: $e');
      return null;
    }
  }
}
