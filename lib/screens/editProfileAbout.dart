import 'dart:io'; // Import the 'dart:io' library for File class
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_akhir_pab_ii_bubadibako/models/pengguna.dart';
import 'package:project_akhir_pab_ii_bubadibako/models/penggunaAbout.dart';
import 'package:project_akhir_pab_ii_bubadibako/services/pengguna_profile_services.dart';

class EditProfileAboutScreen extends StatefulWidget {
  const EditProfileAboutScreen({Key? key, this.pengguna}) : super(key: key);
  final Pengguna? pengguna;
  @override
  _EditProfileAboutScreenState createState() => _EditProfileAboutScreenState();
}

class _EditProfileAboutScreenState extends State<EditProfileAboutScreen> {
  late Stream<PenggunaAbout?> _penggunaAboutStream;

  Stream<PenggunaAbout?> _getPenggunaAboutStream() {
    return penggunaServices.getPenggunaAboutProfile(widget.pengguna?.id ?? '');
  }

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _textController;
  late File? imageFile; // Change imageUrl type to File?

  @override
  void initState() {
    super.initState();
    _penggunaAboutStream = _getPenggunaAboutStream();
    _textController = TextEditingController(
      text: widget.pengguna?.penggunaAbout?.text ?? 'kosong',
    );
    print(widget.pengguna?.penggunaAbout?.text);
    print(_textController.text);
    // imageUrl = widget.pengguna?.penggunaAbout?.imageUrl ?? '';
    // Initialize imageFile to null initially
    imageFile = widget.pengguna?.penggunaAbout?.imageUrl != null
        ? File(widget
            .pengguna!.penggunaAbout!.imageUrl!) // Convert imageUrl to File
        : null;
  }

  @override
  void dispose() {
    _textController.dispose();
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
                InkWell(
                  onTap: _openGallery,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey,
                      child: imageFile != null
                          ? Image.file(
                              imageFile!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                    child: Text('Failed to load image'));
                              },
                            )
                          : const Center(child: Text('No Image')),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _textController,
                  decoration: const InputDecoration(
                    labelText: 'Text',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the text';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (imageFile != null && imageFile!.existsSync()) {
                        print("Masukk ada gambar kesini");
                        // Jika gambar telah dipilih, unggah gambar ke Firebase Storage
                        PenggunaAbout? penggunaAboutId = await penggunaServices
                            .getPenggunaAboutProfile(widget.pengguna?.id ?? '')
                            .first;
                        final imageUrl =
                            await penggunaServices.uploadImagePenggunaAbout(
                          widget.pengguna!.id ?? '', // ID pengguna
                          penggunaAboutId!.id ??
                              '', // ID penggunaAbout (harus disesuaikan)
                          imageFile!,
                        );
                        // Buat objek PenggunaAbout dengan URL gambar baru
                        final penggunaAbout = PenggunaAbout(
                          imageUrl: imageUrl,
                          text: _textController.text,
                        );
                        // Perbarui penggunaAbout di Firestore
                        widget.pengguna!.penggunaAbout = penggunaAbout;
                        await penggunaServices.updateAboutProfilePengguna(
                            widget.pengguna!, context);
                      } else {
                        print("Masukk kesini");
                        // Jika tidak ada gambar yang dipilih, hanya perbarui teks penggunaAbout
                        final penggunaAbout = PenggunaAbout(
                          imageUrl:
                              widget.pengguna?.penggunaAbout?.imageUrl ?? '',
                          text: _textController.text,
                        );
                        widget.pengguna!.penggunaAbout = penggunaAbout;
                        await penggunaServices.updateAboutProfilePengguna(
                            widget.pengguna!, context);
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
