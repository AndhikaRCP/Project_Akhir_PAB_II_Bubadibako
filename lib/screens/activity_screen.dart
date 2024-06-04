import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_akhir_pab_ii_bubadibako/models/post.dart';
import 'package:project_akhir_pab_ii_bubadibako/screens/google_maps_screen.dart';
import 'package:project_akhir_pab_ii_bubadibako/services/favorites_services.dart';
import 'package:project_akhir_pab_ii_bubadibako/services/post_services.dart';

class LikeStatusNotifier extends ValueNotifier<bool> {
  LikeStatusNotifier(bool isLiked) : super(isLiked);

  void toggleLikeStatus() {
    value = !value;
  }
}

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  String currentActiveUserId = FirebaseAuth.instance.currentUser!.uid;
  bool isPostFavorite = false;
  bool isLike = false;

  late Map<String, LikeStatusNotifier> _likeStatusNotifiers;

  @override
  void initState() {
    super.initState();
    _likeStatusNotifiers = {}; // Inisialisasi Map
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instagram Feed'),
      ),
      body: StreamBuilder<List<Post>>(
        stream: PostServices().getAllPosts(),
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
                final likeStatusNotifier = _likeStatusNotifiers.putIfAbsent(
                  post.id!, // Gunakan id post sebagai kunci
                  () => LikeStatusNotifier(post
                      .isFavorite), // Buat LikeStatusNotifier baru jika belum ada
                );
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
                      return buildPostItem(post, userData, likeStatusNotifier);
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

  Widget buildPostItem(Post post, Map<dynamic, dynamic> userData,
      LikeStatusNotifier likeStatusNotifier) {
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
                    userData['profileImageUrl'] ??
                        'https://www.gravatar.com/avatar/HASH?s=200&d=mp'),
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
              imageUrl: post.imageUrl![0] ??
                  'https://via.placeholder.com/300x300.png?text=Sedang Memuat Gambar...',
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
                icon: ValueListenableBuilder<bool>(
                  valueListenable: likeStatusNotifier,
                  builder: (context, isLiked, child) {
                    return Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      size: 45,
                      color: post.isFavorite ? Colors.red : null,
                    );
                  },
                ),
                onPressed: () {
                  likeStatusNotifier.toggleLikeStatus();
                  post.isFavorite = likeStatusNotifier
                      .value; // Update post.isFavorite based on likeStatusNotifier
                  if (likeStatusNotifier.value) {
                    print('Post added to favorites.');
                    FavoriteServices.addToFavorites(
                      currentActiveUserId,
                      post.id!,
                    );
                  } else {
                    print('Post removed from favorites.');
                    FavoriteServices.removeFromFavorites(
                      currentActiveUserId,
                      post.id!,
                    );
                  }
                },
              ),
              const SizedBox(width: 10),
              IconButton(
                icon: const Icon(
                  Icons.map_sharp,
                  size: 40,
                ),
                onPressed: post.latitude != null && post.longitude != null
                    ? () {
                        // _launchMaps(document.latitude!,
                        //     document.longitude!);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GoogleMapsScreen(
                              latitude: post.latitude!,
                              longitude: post.longitude!,
                            ),
                          ),
                        );
                      }
                    : null,
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
