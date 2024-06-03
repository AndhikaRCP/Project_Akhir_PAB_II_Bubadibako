import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_akhir_pab_ii_bubadibako/models/post.dart';
import 'package:project_akhir_pab_ii_bubadibako/services/favorites_services.dart';

class DetailScreen extends StatefulWidget {
  final Post? post;

  const DetailScreen({Key? key, this.post}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late LikeStatusNotifier likeStatusNotifier;

  @override
  void initState() {
    super.initState();
    likeStatusNotifier = LikeStatusNotifier(!widget.post!.isFavorite);
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
                    fontSize: 16,
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
              ],
            ),
            const SizedBox(height: 8),
            Text('Latitude: ${widget.post!.latitude ?? 'N/A'}'),
            Text('Longitude: ${widget.post!.longitude ?? 'N/A'}'),
            Text('Created at: ${widget.post!.createdAt?.toDate() ?? 'N/A'}'),
            Text('Updated at: ${widget.post!.updatedAt?.toDate() ?? 'N/A'}'),
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
