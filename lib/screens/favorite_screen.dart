import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_akhir_pab_ii_bubadibako/models/post.dart';
import 'package:project_akhir_pab_ii_bubadibako/screens/detail_screen.dart';
import 'package:project_akhir_pab_ii_bubadibako/services/favorites_services.dart';
import 'package:project_akhir_pab_ii_bubadibako/services/post_services.dart';
import 'package:project_akhir_pab_ii_bubadibako/widgets/app_bar_widget.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  String idPengguna = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      appBar: const AppBarWidget(
        title: "Favorite",
      ),
      body: StreamBuilder<List<String>>(
        stream: FavoriteServices.getFavoritePostsByIdStream(idPengguna),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada postingan favorit.'));
          } else {
            return StreamBuilder<List<Post>>(
              stream: PostServices().getPostsByIds(snapshot.data!),
              builder: (context, postSnapshot) {
                if (postSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (postSnapshot.hasError) {
                  return Center(child: Text('Error: ${postSnapshot.error}'));
                } else if (postSnapshot.data!.isEmpty) {
                  return const Center(child: Text('Tidak ada postingan.'));
                } else {
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, index) {
                      final post = postSnapshot.data![index];
                      return GestureDetector(
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(post: post),
                            ),
                          );

                          if (result != null) {
                            setState(() {
                              post.isFavorite = result;
                            });
                          }
                        },
                        child: Container(
                          child: CachedNetworkImage(
                            imageUrl: post.imageUrl![0],
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                    itemCount: postSnapshot.data!.length,
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
