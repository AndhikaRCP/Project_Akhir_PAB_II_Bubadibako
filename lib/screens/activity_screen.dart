import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_akhir_pab_ii_bubadibako/models/post.dart';
import 'package:project_akhir_pab_ii_bubadibako/screens/posting_screen.dart';
import 'package:project_akhir_pab_ii_bubadibako/services/favorites_services.dart';
import 'package:project_akhir_pab_ii_bubadibako/services/post_services.dart';

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  String currentActiveUserId = FirebaseAuth.instance.currentUser!.uid;
  bool isPostFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instagram Feed'),
      ),
      body: StreamBuilder<List<Post>>(
        stream: PostServices.getAllPosts(),
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
                          snapshot.data!.data() as Map<dynamic, dynamic>;
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
                backgroundImage: NetworkImage(post.imageUrl![0]),
              ),
              const SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userData['username'] ?? '',
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
            child: Image.network(
              post.imageUrl![0],
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.favorite_border,
                  size: 45,
                  color: post.isFavorite ? Colors.red : null,
                ),
                onPressed: () {
                  // setState(() {
                  //   post.isFavorite = !post.isFavorite;
                  // });
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
              InkWell(
                onTap: () async {
                  isPostFavorite = await FavoriteServices.isPostFavorite(
                      currentActiveUserId, post.id!);
                  print("===========");
                  print("Lama");
                  print(isPostFavorite);
                  setState(() {
                    isPostFavorite = !isPostFavorite;
                    post.isFavorite = isPostFavorite;
                    print("Baru");
                    print(post.isFavorite);

                    // PostServices.updateIsFavorite(post.id!, post.isFavorite); <-- ini buat ngubah
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
                  isPostFavorite = post.isFavorite;
                  print("mau masuk");
                  print(post.isFavorite);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Icon(
                    isPostFavorite ? Icons.star : Icons.star_border_outlined,
                    size: 50,
                    color: const Color.fromARGB(255, 231, 196, 0),
                  ),
                ),
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
