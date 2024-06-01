import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      print(credential.user);
    } catch (e) {
      print("Proses Login gagal");
    }
    return null;
  }
}
