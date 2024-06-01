  import 'package:flutter/material.dart';
  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:project_akhir_pab_ii_bubadibako/screens/follower_screen.dart';
  import 'package:project_akhir_pab_ii_bubadibako/screens/following_screen.dart';
  import 'package:project_akhir_pab_ii_bubadibako/services/auth_services.dart';
  import 'package:project_akhir_pab_ii_bubadibako/screens/edit_profile_screen.dart';
import 'package:project_akhir_pab_ii_bubadibako/services/pengguna_services.dart';

  class ProfileScreen extends StatefulWidget {
    const ProfileScreen({Key? key}) : super(key: key);

    @override
    State<ProfileScreen> createState() => _ProfileScreenState();
  }

  class _ProfileScreenState extends State<ProfileScreen>
      with SingleTickerProviderStateMixin {

    String idPengguna = FirebaseAuth.instance.currentUser!.uid;

    int _selectedIndex = 0;
    late TabController tabController;
    final AuthServices _authServices =
        AuthServices(); // Tambahkan inisialisasi AuthServices

    @override
    void initState() {
      tabController = TabController(length: 2, vsync: this);
      super.initState();
    }

    @override
    void dispose() {
      tabController.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('Item 1'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text("Profile Screen"),
          backgroundColor: Colors.grey,
          actions: [
            Container(
              margin: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut().whenComplete(() =>
                        Navigator.of(context).pushReplacementNamed("/signIn"));
                  },
                  child: const Text("Logout")),
            )
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: StreamBuilder(
            stream: penggunaServices.getpenggunaById(idPengguna),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Menampilkan indikator loading jika sedang memuat data
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // Menampilkan pesan error jika terjadi kesalahan
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                // Menampilkan data pengguna jika berhasil didapatkan
                final penggunaData = snapshot.data!;
                return Column(
                  children: [ 
                    Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Image.network(
                            "https://images.unsplash.com/photo-1498598457418-36ef20772bb9?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          left: 25,
                          bottom: 25,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Container(
                              height: 150.0,
                              width: 150.0,
                              color: const Color(0xffFF0E58),
                              child: Image.network(
                                  fit: BoxFit.cover,
                                  'https://images.unsplash.com/photo-1498598457418-36ef20772bb9?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
                                  // userData['photoUrl'], // Ganti dengan URL foto pengguna
                                  ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 195,
                          bottom: 25,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                               penggunaData.username ?? 'Nama Pengguna Kosong',
                                style: TextStyle(
                                    color: const Color.fromARGB(255, 18, 6, 6),
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              Text(
                               penggunaData.email ?? 'Nama Pengguna Kosong',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const FollowerScreen(),
                                          ));
                                    },
                                    child: const Text(
                                      "180 Follower",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const FollowingScreen(),
                                          ));
                                    },
                                    child: const Text(
                                      "80 Following",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 40,
                                  ),
                                  ElevatedButton(
                                      onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ProfileScreen(),
                                          )),
                                      child: const Text("Edit Profile"))
                                ],
                              ),
                              ElevatedButton(
                                  onPressed: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => EditProfileScreen(
                                          pengguna: penggunaData,
                                        ),
                                      )),
                                  child: Text("Edit Profile"))
                            ],
                          ),
                        ),
                      ],
                    ),
                    TabBar(
                      controller: tabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: const [
                        Tab(
                          child: Text("Gallery"),
                        ),
                        Tab(
                          child: Text("About"),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height -
                          350, // Sesuaikan tinggi dengan kebutuhan
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          const Center(
                              child: Text(
                                  ' Gallery Content Gallery Content Gallery ContentGallery Content Gallery Content Gallery Content Gallery ContentGallery ContentGallery Content Gallery Content Gallery ContentGallery ContentGallery Content Gallery Content Gallery ContentGallery Content')),
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Positioned(
                                  bottom: 0,
                                  right: 20,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: const Text("Edit About"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(30),
                                  child: Column(
                                    children: [
                                      const Text(
                                        "Ini adalah deskripsi dari about yang berisikan ",
                                        style: TextStyle(fontSize: 20),
                                        textAlign: TextAlign.justify,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      AspectRatio(
                                        aspectRatio: 16 / 9,
                                        child: Image.network(
                                          height: 200,
                                          width: 100,
                                          "https://images.unsplash.com/photo-1536152470836-b943b246224c?q=80&w=1938&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                // Menampilkan pesan jika tidak ada data pengguna yang ditemukan
                return Center(child: Text('Data pengguna tidak ditemukan'));
              }
            },
          ),
        ),
      );
    }
  }
