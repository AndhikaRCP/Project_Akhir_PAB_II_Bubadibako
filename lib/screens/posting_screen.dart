// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// class PostingScreen extends StatefulWidget {
//   @override
//   _PostingScreenState createState() => _PostingScreenState();
// }

// class _PostingScreenState extends State<PostingScreen> {
//   final _captionController = TextEditingController();
//   List<File> _galleryImages = [];

//   @override
//   void dispose() {
//     _captionController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Center(child: Text('New Post')),
//           leading: IconButton(
//             icon: Icon(Icons.close),
//             onPressed: () {
//               // Handle close button press
//               Navigator.pop(context);
//             },
//           ),
//           actions: [
//             IconButton(
//               icon: Icon(Icons.check),
//               onPressed: () {
//                 // Handle posting
//                 _handlePost();
//               },
//             ),
//           ],
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               // Display the selected gallery image in a grid
//               GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount:
//                       1, // Set crossAxisCount to 1 to display a single image
//                   crossAxisSpacing: 1.5,
//                   mainAxisSpacing: 1.5,
//                   childAspectRatio: 1.0,
//                 ),
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 itemCount:
//                     _galleryImages.length > 0 ? 1 : 0, // Only display one image
//                 itemBuilder: (context, index) {
//                   return Image.file(
//                       _galleryImages.last); // Display the last selected image
//                 },
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: TextField(
//                   controller: _captionController,
//                   decoration: InputDecoration(
//                     hintText: 'Masukkan caption anda...',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//               ),

//               AppBar(
//                 title: Center(child: Text('Gallery Anda')),
//                 actions: [
//                   IconButton(
//                     icon: Icon(Icons.camera),
//                     onPressed: () {
//                       // Handle picking image
//                       _handleGallery();
//                     },
//                   ),
//                 ],
//               ),

//               GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 1.5,
//                   mainAxisSpacing: 1.5,
//                   childAspectRatio: 1.0,
//                 ),
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 itemCount: _galleryImages.length,
//                 itemBuilder: (context, index) {
//                   return Image.file(_galleryImages[index]);
//                 },
//               )
//             ],
//           ),
//         ));
//   }

//   void _handlePost() {
//     // Handle posting logic here
//     print('Posting...');
//     print('Caption: ${_captionController.text}');
//     print('Images: ${_galleryImages.length}');
//   }

//   void _handleGallery() async {
//     // Handle gallery selection logic here
//     print('Selecting from gallery...');
//     final ImagePicker _picker = ImagePicker();
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() {
//         _galleryImages.add(File(image.path));
//       });
//     }
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:project_akhir_pab_ii_bubadibako/models/post.dart';

class PostingScreen extends StatefulWidget {
  @override
  _PostingScreenState createState() => _PostingScreenState();
}

class _PostingScreenState extends State<PostingScreen> {
  final _captionController = TextEditingController();
  List<Posting> _postList = [];

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
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('New Post')),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            // Handle close button press
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              // Handle posting
              _handlePost();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Display the selected gallery image in a grid
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    1, // Set crossAxisCount to 1 to display a single image
                crossAxisSpacing: 1.5,
                mainAxisSpacing: 1.5,
                childAspectRatio: 1.0,
              ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _postList?.isNotEmpty == true
                  ? 1
                  : 0, // Display only one image if list is not empty
              itemBuilder: (context, index) {
                return _postList?.isNotEmpty == true
                    ? GestureDetector(
                        onTap: () =>
                            _showImageDialog(_postList.last.imageAsset),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(10), // Add a rounded corner
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1),
                            ),
                            child: Image.network(_postList.last.imageAsset,
                                fit: BoxFit.cover),
                          ),
                        ),
                      )
                    : Container(); // Return an empty container if list is empty
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _captionController,
                decoration: InputDecoration(
                  hintText: 'Masukkan caption anda...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            AppBar(
              title: Center(child: Text('Gallery Anda')),
              actions: [
                IconButton(
                  icon: Icon(Icons.camera),
                  onPressed: () {
                    // Handle picking image
                    _handleGallery();
                  },
                ),
              ],
            ),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 1.5,
                mainAxisSpacing: 1.5,
                childAspectRatio: 1.0,
              ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _postList.length,
              itemBuilder: (context, index) {
                final post = _postList.reversed.toList()[index];

                return GestureDetector(
                  onTap: () => _showImageDialog(post.imageAsset),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 4),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: CachedNetworkImage(
                        imageUrl: post.imageAsset,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
                // return Container(
                //     decoration: BoxDecoration(
                //       border: Border.all(color: Colors.black, width: 1),
                //     ),
                //     child: Image.network(_postList[index].imageAsset));
              },
            ),
          ],
        ),
      ),
    );
  }

  void _handlePost() {
    // Handle posting logic here
    print('Posting...');
    print('Caption: ${_captionController.text}');
    print('Images: ${_postList.length}');
  }

  void _handleGallery() async {
    // Handle gallery selection logic here
    print('Selecting from gallery...');
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _postList.add(Posting(imageAsset: image.path));
      });
    }
  }
}
