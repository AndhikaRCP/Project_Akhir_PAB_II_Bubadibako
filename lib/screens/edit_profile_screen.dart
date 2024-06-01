import 'package:flutter/material.dart';
import 'package:project_akhir_pab_ii_bubadibako/models/pengguna.dart';
import 'package:project_akhir_pab_ii_bubadibako/services/pengguna_profile_services.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key, this.pengguna}) : super(key: key);
  final Pengguna? pengguna; // Ubah tipe data user menjadi Map<String, dynamic>?

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _usernameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
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
                // CircleAvatar(
                //   radius: 60,
                //   backgroundImage: AssetImage(
                //       'assets/image/log.png'), // Replace with your image
                // ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Handle edit profile picture
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (widget.pengguna != null) {
                        print(widget.pengguna!.id);
                        // Periksa apakah user tidak null
                        if (widget.pengguna != null) {
                          widget.pengguna!.email = _emailController.text;
                          widget.pengguna!.username = _usernameController.text;
                          penggunaServices
                              .updateProfilPengguna(widget.pengguna!, context);
                          
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
