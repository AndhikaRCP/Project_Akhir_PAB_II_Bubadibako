import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_akhir_pab_ii_bubadibako/models/pengguna.dart';
import 'package:project_akhir_pab_ii_bubadibako/models/post.dart';
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
    Pengguna? currentActivePengguna = await penggunaServices.getpenggunaById(currentActivePengunaId).first;
    if (currentActivePengguna != null) {
      bool isFavorite = currentActivePengguna.favorite!.contains(widget.post!.id);
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
        child: SingleChildScrollView(
          // Add this
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 5, color: Colors.black),
                  ),
                  child: Image.network(
                    widget.post!.imageUrl![0],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 250, // set width
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(
                      child: Text(
                        widget.post!.caption!,
                        style: TextStyle(fontSize: 16),
                      ),
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
              const SizedBox(height: 16),
              Table(
                border: TableBorder.all(width: 1, color: Colors.grey),
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Latitude'),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${widget.post!.latitude ?? 'N/A'}'),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Longitude'),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${widget.post!.longitude ?? 'N/A'}'),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Created at'),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              '${widget.post!.createdAt?.toDate() ?? 'N/A'}'),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Updated at'),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              '${widget.post!.updatedAt?.toDate() ?? 'N/A'}'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
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
