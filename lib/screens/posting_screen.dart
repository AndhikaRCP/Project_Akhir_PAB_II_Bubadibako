import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:project_akhir_pab_ii_bubadibako/models/post.dart';
import 'package:project_akhir_pab_ii_bubadibako/services/post_services.dart';

class PostingScreen extends StatefulWidget {
  const PostingScreen({super.key});

  @override
  _PostingScreenState createState() => _PostingScreenState();
}

class _PostingScreenState extends State<PostingScreen> {
  final _captionController = TextEditingController();
  final List _imageList = [];
  List<File>? _imageFile = [];
  String idPengguna = FirebaseAuth.instance.currentUser!.uid;

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
              child: Image.file(
                File(imageUrl),
                errorBuilder: (context, url, error) => const Icon(Icons.error),
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
        title: const Center(child: Text('New Post')),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            // Handle close button press
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              _handlePost();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Display the selected gallery image in a grid
            _imageList.isNotEmpty
                ? GestureDetector(
                    onTap: () => _showImageDialog(_imageList.last),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(10), // Add a rounded corner
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        child: Image.file(
                          File(_imageList.last),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _captionController,
                decoration: const InputDecoration(
                  hintText: 'Masukkan caption anda...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            AppBar(
              title: const Center(child: Text('Gallery Anda')),
              actions: [
                IconButton(
                  icon: const Icon(Icons.camera),
                  onPressed: () {
                    // Handle picking image
                    _handleGallery();
                  },
                ),
              ],
            ),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 1.5,
                mainAxisSpacing: 1.5,
                childAspectRatio: 1.0,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _imageList.length,
              itemBuilder: (context, index) {
                final post = _imageList.reversed.toList()[index];

                return GestureDetector(
                  onTap: () => _showImageDialog(post),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 4),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: Image.file(
                        File(post),
                        errorBuilder: (context, file, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
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
    print('Images: ${_imageList.length}');

    Post newPost = Post(
      penggunaId: idPengguna,
        caption: _captionController.text,
        isFavorite: false,
        imageUrl: _imageList);
    print(newPost.toDocument());

    PostServices().createPost(newPost, context, _imageFile!);
  }

  void _handleGallery() async {
    // Handle gallery selection logic here
    print('Selecting from gallery...');
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageFile!.add(File(image.path));
        _imageList.add(image.path);
      });
    }
  }
}
