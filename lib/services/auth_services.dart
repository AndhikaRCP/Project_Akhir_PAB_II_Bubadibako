import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_akhir_pab_ii_bubadibako/models/pengguna.dart';
import 'package:project_akhir_pab_ii_bubadibako/services/pengguna_profile_services.dart';

class AuthServices {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }
  
  Future<User?> signUpWithEmailAndPassword(
      String email, String username, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      try {
        String userId = credential.user!.uid;
        await penggunaServices.createpengguna(userId, username, email);
        print('Data pengguna berhasil disimpan di Firestore');
      } catch (e) {
        print('Gagal menyimpan data pengguna: $e');
      }
      return credential.user;
    } catch (e) {
      print("Proses Sign Up gagal");
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
}
