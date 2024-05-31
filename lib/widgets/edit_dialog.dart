import 'package:flutter/material.dart';

void showEditDialog(BuildContext context) {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _username;
  String? _bio;
  String? _gender;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Edit Profile'),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(
                      'assets/profile_image.jpg'), // Replace with your image
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Handle edit profile picture
                  },
                  child: Text('Edit Foto Profile'),
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                  onSaved: (value) => _name = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                  ),
                  onSaved: (value) => _username = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Bio',
                  ),
                  maxLines: 2,
                  onSaved: (value) => _bio = value,
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Gender',
                  ),
                  onSaved: (value) => _gender = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your gender';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Process form data
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Simpan'),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
