import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String? id;
  String? penggunaId;
  final String caption;
  List? imageUrl;
  double? latitude;
  double? longitude;
  Timestamp? createdAt;
  Timestamp? updatedAt;
  bool isFavorite;

  Post({
    this.id,
    this.penggunaId,
    required this.caption,
    required this.isFavorite,
    this.imageUrl,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
  });

  factory Post.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Post(
      id: doc.id,
      penggunaId: data['penggunaId'],
      isFavorite: data['isFavorite'],
      caption: data['caption'],
      imageUrl: data['image_url'],
      latitude: data['latitude'] as double,
      longitude: data['longitude'] as double,
      createdAt: data['created_at'] as Timestamp,
      updatedAt: data['updated_at'] as Timestamp,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'penggunaId' : penggunaId,
      'caption': caption,
      'image_url': imageUrl,
      'isFavorite': isFavorite,
      'latitude': latitude,
      'longitude': longitude,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
