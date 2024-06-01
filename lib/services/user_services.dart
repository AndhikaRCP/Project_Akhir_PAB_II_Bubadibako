import 'package:cloud_firestore/cloud_firestore.dart';

class UserServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> getUserData(String userId) async {
    try {
      DocumentSnapshot userSnapshot = await _firestore.collection('users').doc(userId).get();
      if (userSnapshot.exists) {
        return userSnapshot.data() as Map<String, dynamic>;
      } else {
        print('Data pengguna tidak ditemukan');
        return null;
      }
    } catch (e) {
      print('Gagal mengambil data pengguna: $e');
      return null;
    }
  }
}
