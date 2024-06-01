import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_akhir_pab_ii_bubadibako/services/auth_services.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthServices _auth = AuthServices();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailControllerKey = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirm_passwordController =
      TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _usernameController.dispose();
    _emailControllerKey.dispose();
    _passwordController.dispose();
    _confirm_passwordController.dispose();
    super.dispose();
  }

  void _signUp() async {
    String username = _usernameController.text;
    String email = _emailControllerKey.text;
    String password = _passwordController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email,username, password);

    if (user != null) {
      print('Sign Up successful for username: $username, email: $email');
    Navigator.pushNamed(context, '/signIn');
    } else {
      print("Sign Up Gagal");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Icon panah ke belakang
          onPressed: () {
            Navigator.of(context).pop(); // Navigasi ke halaman sebelumnya
          },
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/image/logo.png',
              height: 200,
              width: 180,
            ),
            const SizedBox(height: 8.0),
            const Text(
              'BUBADIBAKO',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'LuckiestGuy',
                color: Color.fromARGB(255, 255, 255, 255),
                shadows: [
                  Shadow(
                    offset: Offset(3.0, 3.0),
                    blurRadius: 0.0,
                    color: Colors.black,
                  ),
                  Shadow(
                    offset: Offset(-3.0, -3.0),
                    blurRadius: 0.0,
                    color: Colors.black,
                  ),
                  Shadow(
                    offset: Offset(3.0, -3.0),
                    blurRadius: 0.0,
                    color: Colors.black,
                  ),
                  Shadow(
                    offset: Offset(-3.0, 3.0),
                    blurRadius: 0.0,
                    color: Colors.black,
                  ),
                  Shadow(
                    offset: Offset(0.0, 0.0),
                    blurRadius: 0.0,
                    color: Colors.white,
                  ),
                ],
                letterSpacing: 7.0,
              ),
            ),
            const SizedBox(height: 20.0),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    controller: _emailControllerKey,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email address.';
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+$")
                          .hasMatch(value)) {
                        return 'Invalid email format.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password.';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    controller: _confirm_passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password.';
                      } else if (value != _passwordController.text) {
                        return 'Passwords do not match.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _signUp();
                      }
                    },
                    child: const Text('Sign Up'),
                  ),
                  const SizedBox(height: 20.0),
                  TextButton(
                    onPressed: () =>
                        Navigator.of(context).pushReplacementNamed('/signIn'),
                    child: const Text(
                      "Sudah Punya Akun? Login disini!",
                      style: TextStyle(
                        color: Colors.blue, // Warna teks
                        fontWeight: FontWeight.bold, // Ketebalan teks
                        fontSize: 16, // Ukuran teks
                        decoration:
                            TextDecoration.underline, // Garis bawah teks
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
