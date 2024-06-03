import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_akhir_pab_ii_bubadibako/models/pengguna.dart';
import 'package:project_akhir_pab_ii_bubadibako/models/post.dart';
import 'package:project_akhir_pab_ii_bubadibako/screens/google_maps_screen.dart';
import 'package:project_akhir_pab_ii_bubadibako/services/favorites_services.dart';
import 'package:project_akhir_pab_ii_bubadibako/services/pengguna_profile_services.dart';

class DetailScreen extends StatefulWidget {
  final Post? post;

  const DetailScreen({Key? key, this.post}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late LikeStatusNotifier likeStatusNotifier;
  String currentActivePengunaId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    _initializeLikeStatus();
  }

  void _initializeLikeStatus() async {
    Pengguna? currentActivePengguna =
        await penggunaServices.getpenggunaById(currentActivePengunaId).first;
    if (currentActivePengguna != null) {
      bool isFavorite =
          currentActivePengguna.favorite!.contains(widget.post!.id);
      print(isFavorite);
      setState(() {
        likeStatusNotifier = LikeStatusNotifier(isFavorite);
      });
    } else {
      // Handle case when pengguna is not found
      setState(() {
        likeStatusNotifier = LikeStatusNotifier(false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Post'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('penggunas')
                  .doc(widget.post!.penggunaId)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || !snapshot.data!.exists) {
                  return Text('Pengguna tidak ditemukan!');
                } else {
                  final userData =
                      snapshot.data!.data() as Map<dynamic, dynamic>;
                  // Tampilkan foto profil dan username di sini
                  return Row(
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage(userData['profileImageUrl']),
                      ),
                      SizedBox(width: 15.0, height: 30,),

                      Text(
                        userData['username'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
             SizedBox(
              height: 10,
            ),
            Text(
              'Longitude   : ${widget.post?.longitude}',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Lattitude     : ${widget.post?.latitude}',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                widget.post!.imageUrl![0],
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.post!.caption!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: ValueListenableBuilder<bool>(
                    valueListenable: likeStatusNotifier,
                    builder: (context, isLiked, child) {
                      return Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        size: 45,
                        color: isLiked ? Colors.red : null,
                      );
                    },
                  ),
                  onPressed: () {
                    likeStatusNotifier.toggleLikeStatus();
                    widget.post!.isFavorite = likeStatusNotifier.value;
                    if (likeStatusNotifier.value) {
                      print('Post added to favorites.');
                      FavoriteServices.addToFavorites(
                        FirebaseAuth.instance.currentUser!.uid,
                        widget.post!.id!,
                      );
                    } else {
                      print('Post removed from favorites.');
                      FavoriteServices.removeFromFavorites(
                        FirebaseAuth.instance.currentUser!.uid,
                        widget.post!.id!,
                      );
                    }
                  },
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(
                    Icons.map_sharp,
                    size: 40,
                  ),
                  onPressed: widget.post!.latitude != null &&
                          widget.post!.longitude != null
                      ? () {
                          // _launchMaps(document.latitude!,
                          //     document.longitude!);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GoogleMapsScreen(
                                latitude: widget.post!.latitude!,
                                longitude: widget.post!.longitude!,
                              ),
                            ),
                          );
                        }
                      : null,
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class LikeStatusNotifier extends ValueNotifier<bool> {
  LikeStatusNotifier(bool isLiked) : super(isLiked);

  void toggleLikeStatus() {
    value = !value;
  }
}
