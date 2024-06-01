import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PostServices {
  static final FirebaseFirestore _database = FirebaseFirestore.instance;
  static final CollectionReference _penggunascollection =
      _database.collection('penggunas');
  static final FirebaseStorage _storage = FirebaseStorage.instance;
  
}