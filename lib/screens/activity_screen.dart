import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_akhir_pab_ii_bubadibako/models/post.dart';
import 'package:project_akhir_pab_ii_bubadibako/services/favorites_services.dart';
import 'package:project_akhir_pab_ii_bubadibako/services/post_services.dart';

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  String currentActiveUserId = FirebaseAuth.instance.currentUser!.uid;
  bool isPostFavorite = false;
  bool isLike = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instagram Feed'),
      ),
      body: StreamBuilder<List<Post>>(
        stream: PostServices.getAllPosts(currentActiveUserId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final posts = snapshot.data ?? [];
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('penggunas')
                      .doc(post.penggunaId)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || !snapshot.data!.exists) {
                      return const Text('Pengguna tidak ditemukan!');
                    } else {
                      final userData =
                          snapshot.data?.data() as Map<dynamic, dynamic>;
                      return buildPostItem(post, userData);
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget buildPostItem(Post post, Map<dynamic, dynamic> userData) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.0,
                backgroundImage: CachedNetworkImageProvider(
                    userData['profileImageUrl'] ?? ''),
              ),
              const SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userData['username'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    '2 hours ago',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          AspectRatio(
            aspectRatio: 1 / 1,
            child: CachedNetworkImage(
              imageUrl: post.imageUrl![0] ?? 'https://via.placeholder.com/300x300.png?text=Sedang Memuat Gambar...',
              fit: BoxFit.cover,
              placeholder: (context, url) => const SizedBox(
                width: 50.0, // Lebar kotak tempat indicator berada
                height: 50.0, // Tinggi kotak tempat indicator berada
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0, // Lebar garis progress
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.blue), // Warna garis progress
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  isLike ? Icons.favorite : Icons.favorite_border,
                  size: 45,
                  color: post.isFavorite ? Colors.red : null,
                ),
                onPressed: () {
                  setState(() {
                    isLike = !isLike;
                  });
                },
              ),
              const SizedBox(width: 10),
              IconButton(
                icon: const Icon(
                  Icons.mode_comment_outlined,
                  size: 40,
                ),
                onPressed: () {},
              ),
              const Spacer(),
              IconButton(
                icon: Icon(
                  post.isFavorite ? Icons.star : Icons.star_border,
                  size: 45,
                  color:
                      post.isFavorite ? Color.fromARGB(255, 231, 212, 0) : null,
                ),
                onPressed: () async {
                  setState(() {
                    post.isFavorite = !post.isFavorite;
                  });
                  if (post.isFavorite) {
                    print('Post added to favorites.');
                    await FavoriteServices.addToFavorites(
                        currentActiveUserId, post.id!);
                  } else {
                    print('Post removed from favorites.');
                    await FavoriteServices.removeFromFavorites(
                        currentActiveUserId, post.id!);
                  }
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(post.caption),
          ),
          const SizedBox(height: 15.0),
        ],
      ),
    );
  }
}
