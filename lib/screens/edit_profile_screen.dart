import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_akhir_pab_ii_bubadibako/models/pengguna.dart';
import 'package:project_akhir_pab_ii_bubadibako/services/pengguna_profile_services.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key? key, this.pengguna}) : super(key: key);

  Pengguna? pengguna;
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late File? imageFile; // Change imageUrl type to File?

  @override
  void initState() {
    super.initState();
    imageFile = null;
    _usernameController = TextEditingController(
        text: widget.pengguna!.username); // Gunakan nilai dari user Map
    _emailController = TextEditingController(
        text: widget.pengguna!.email); // Gunakan nilai dari user Map
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  // Function to open gallery and set selected image file
  Future<void> _openGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        // Set imageFile to the picked image file
        imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey,
                  backgroundImage: imageFile !=null
                      ? Image.file(
                          imageFile!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                                child: Text('Failed to load image'));
                          },
                        ).image
                      : widget.pengguna?.profileImageUrl != null
                          ? CachedNetworkImageProvider(
                              widget.pengguna!.profileImageUrl!)
                          : const CachedNetworkImageProvider(
                              'https://cdn-icons-png.flaticon.com/512/149/149071.png'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    _openGallery();
                    if (imageFile != null) {
                      final imageUrl = penggunaServices.uploadProfileImage(
                          imageFile!, widget.pengguna!.id!);
                      widget.pengguna!.profileImageUrl = await imageUrl;
                    }
                  },
                  child: Text('Edit Foto Profile'),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (widget.pengguna != null) {
                        // Periksa apakah user tidak null
                        if (widget.pengguna?.id != null &&
                            imageFile != null &&
                            imageFile!.existsSync()) {
                          print('Masukk disinni ada gamhar');
                          widget.pengguna?.email = _emailController.text;
                          widget.pengguna?.username = _usernameController.text;

                          final imageUrl = penggunaServices.uploadProfileImage(
                              imageFile!, widget.pengguna!.id!);

                          final Pengguna updatePengguna = Pengguna(
                            id: widget.pengguna!.id,
                            email: widget.pengguna!.email,
                            username: widget.pengguna!.username,
                            profileImageUrl: await imageUrl ??
                                widget.pengguna!.profileImageUrl,
                          );

                          widget.pengguna = updatePengguna;
                          await penggunaServices.updateProfilPengguna(
                              widget.pengguna!, context);
                        } else {
                          print("Tidak ada gambar");
                        }
                      } else {
                        print("Data Null");
                      }
                    }
                  },
                  child: Text('Simpan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
