import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String? id;
  final String title;
  final String description;
  String? imageUrl;
  double? latitude;
  double? longitude;
  Timestamp? createdAt;
  Timestamp? updatedAt;
  bool isFavorite;
  final String imageAsset;

  Post({
    this.id,
    required this.title,
    required this.description,
    required this.imageAsset,
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
      title: data['title'],
      imageAsset: data['imageAsset'],
      isFavorite: data['isFavorite'],
      description: data['description'],
      imageUrl: data['image_url'],
      latitude: data['latitude'] as double,
      longitude: data['longitude'] as double,
      createdAt: data['created_at'] as Timestamp,
      updatedAt: data['updated_at'] as Timestamp,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'title': title,
      'description': description,
      'image_url': imageUrl,
      'image_asset': imageAsset,
      'isFavorite': isFavorite,
      'latitude': latitude,
      'longitude': longitude,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class Posting {
  final String imageAsset;

  Posting({required this.imageAsset});

  
}

