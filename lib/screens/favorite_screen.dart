import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_akhir_pab_ii_bubadibako/data/post_screen.dart';
import 'package:project_akhir_pab_ii_bubadibako/models/post.dart';
import 'package:project_akhir_pab_ii_bubadibako/widgets/app_bar_widget.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  int _selectedIndex = 0;
  // List<Post> _filteredPost = [];

  @override
  void initState() {
    super.initState();
    // // Populate _filteredPost with favorite posts
    // _filteredPost = postList.where((post) => post.isFavorite).toList();
  }

  void _showImageDialog(String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 4),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return //Scaffold(
    //    appBar: const AppBarWidget(title: "Favorite",),
    //   body: Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: GridView.builder(
    //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //         crossAxisCount: 3,
    //         crossAxisSpacing: 1.5,
    //         mainAxisSpacing: 1.5,
    //         childAspectRatio: 1.0,
    //       ),
    //       itemCount: _filteredPost.length,
    //       itemBuilder: (context, index) {
    //         return GestureDetector(
    //           onTap: () => _showImageDialog(_filteredPost[index].imageAsset),
    //           child: Container(
    //             decoration: BoxDecoration(
    //               border: Border.all(color: const Color.fromRGBO(0, 0, 0, 1), width: 4),
    //               borderRadius: BorderRadius.circular(8.0),
    //             ),
    //             child: ClipRRect(
    //               borderRadius: BorderRadius.circular(6.0),
    //               child: CachedNetworkImage(
    //                 imageUrl: _filteredPost[index].imageAsset,
    //                 placeholder: (context, url) => const Center(
    //                   child: CircularProgressIndicator(),
    //                 ),
    //                 errorWidget: (context, url, error) =>
    //                     const Icon(Icons.error),
    //                 fit: BoxFit.cover,
    //               ),
    //             ),
    //           ),
    //         );
    //       },
    //     ),
    //   ),
    // );
    Placeholder();
  }
    
  }
