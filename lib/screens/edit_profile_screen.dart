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
  late File? imageFileForProfile; // Change imageUrl type to File?
  late File? imageFileForBackground; // Change imageUrl type to File?

  @override
  void initState() {
    super.initState();
    imageFileForProfile = null;
    imageFileForBackground = null;
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
  Future<void> _openGalleryForProfile() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        // Set imageFile to the picked image file
        imageFileForProfile = File(pickedFile.path);
      });
    }
  }

  Future<void> _openGalleryForBackground() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        // Set imageFile to the picked image file
        imageFileForBackground = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
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
                  backgroundImage: imageFileForProfile != null
                      ? Image.file(
                          imageFileForProfile!,
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
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    _openGalleryForProfile();
                    if (imageFileForProfile != null) {
                      final imageUrl = penggunaServices.uploadProfileImage(
                          imageFileForProfile!,
                          widget.pengguna!.id!,
                          'profile');
                      widget.pengguna!.profileImageUrl = await imageUrl;
                    }
                  },
                  child: const Text('Edit Foto Profile'),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: _openGalleryForBackground,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey,
                      child: imageFileForBackground != null
                          ? Image.file(
                              imageFileForBackground!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                    child: Text('Failed to load image'));
                              },
                            )
                          : widget.pengguna!.backgroundImageUrl != null
                              ? Image.network(
                                fit: BoxFit.cover,
                                  widget.pengguna!.backgroundImageUrl!)
                              : const Center(
                                  child: Text("No Image"),
                                ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (widget.pengguna != null) {
                        widget.pengguna?.email = _emailController.text;
                        widget.pengguna?.username = _usernameController.text;
                        // Periksa apakah user tidak null
                        if (widget.pengguna?.id != null &&
                            imageFileForProfile != null &&
                            imageFileForProfile!.existsSync() &&
                            imageFileForBackground != null &&
                            imageFileForBackground!.existsSync()) {
                          print('Masukk disinni ada gamhar');

                          final imageUrlforProfile =
                              penggunaServices.uploadProfileImage(
                                  imageFileForProfile!,
                                  widget.pengguna!.id!,
                                  'profile');
                          final imageUrlforBackground =
                              penggunaServices.uploadProfileImage(
                                  imageFileForBackground!,
                                  widget.pengguna!.id!,
                                  'background');
                          final Pengguna updatePengguna = Pengguna(
                            id: widget.pengguna!.id,
                            email: widget.pengguna!.email,
                            username: widget.pengguna!.username,
                            profileImageUrl: await imageUrlforProfile ??
                                widget.pengguna!.profileImageUrl,
                            backgroundImageUrl: await imageUrlforBackground ??
                                widget.pengguna!.backgroundImageUrl,
                          );

                          widget.pengguna = updatePengguna;
                          await penggunaServices.updateProfilPengguna(
                              widget.pengguna!, context);
                        } else if (widget.pengguna?.id != null &&
                            imageFileForBackground != null &&
                            imageFileForBackground!.existsSync()) {
                          print('Masukk disinni ada gamhar');

                          final imageUrlforBackground =
                              penggunaServices.uploadProfileImage(
                                  imageFileForBackground!,
                                  widget.pengguna!.id!,
                                  'background');
                          final Pengguna updatePengguna = Pengguna(
                            id: widget.pengguna!.id,
                            email: widget.pengguna!.email,
                            username: widget.pengguna!.username,
                            profileImageUrl: widget.pengguna!.profileImageUrl,
                            backgroundImageUrl: await imageUrlforBackground ??
                                widget.pengguna!.backgroundImageUrl,
                          );

                          widget.pengguna = updatePengguna;
                          await penggunaServices.updateProfilPengguna(
                              widget.pengguna!, context);
                        } else if (widget.pengguna?.id != null &&
                            imageFileForProfile != null &&
                            imageFileForProfile!.existsSync()) {
                          print('Masukk disinni ada gamhar');

                          final imageUrlforProfile =
                              penggunaServices.uploadProfileImage(
                                  imageFileForProfile!,
                                  widget.pengguna!.id!,
                                  'profile');
                          final Pengguna updatePengguna = Pengguna(
                            id: widget.pengguna!.id,
                            email: widget.pengguna!.email,
                            username: widget.pengguna!.username,
                            profileImageUrl: await imageUrlforProfile ??
                                widget.pengguna!.profileImageUrl,
                            backgroundImageUrl:
                                await widget.pengguna!.backgroundImageUrl,
                          );

                          widget.pengguna = updatePengguna;
                          await penggunaServices.updateProfilPengguna(
                              widget.pengguna!, context);
                        } else {
                          print("Tidak ada gambar");
                          print(widget.pengguna!.profileImageUrl);

                          final Pengguna updatePengguna = Pengguna(
                            id: widget.pengguna!.id,
                            email: widget.pengguna!.email,
                            username: widget.pengguna!.username,
                            profileImageUrl: widget.pengguna!.profileImageUrl,
                            backgroundImageUrl:
                                widget.pengguna!.backgroundImageUrl,
                          );

                          widget.pengguna = updatePengguna;
                          await penggunaServices.updateProfilPengguna(
                              widget.pengguna!, context);
                        }
                      } else {
                        print("Data Null");
                      }
                    }
                  },
                  child: const Text('Simpan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
