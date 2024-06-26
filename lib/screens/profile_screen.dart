import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_akhir_pab_ii_bubadibako/models/pengguna.dart';
import 'package:project_akhir_pab_ii_bubadibako/models/penggunaAbout.dart';
import 'package:project_akhir_pab_ii_bubadibako/models/post.dart';
import 'package:project_akhir_pab_ii_bubadibako/screens/detail_screen.dart';
import 'package:project_akhir_pab_ii_bubadibako/screens/editProfileAbout.dart';
import 'package:project_akhir_pab_ii_bubadibako/services/auth_services.dart';
import 'package:project_akhir_pab_ii_bubadibako/screens/edit_profile_screen.dart';
import 'package:project_akhir_pab_ii_bubadibako/services/pengguna_profile_services.dart';
import 'package:project_akhir_pab_ii_bubadibako/services/post_services.dart';
import 'package:project_akhir_pab_ii_bubadibako/widgets/app_bar_widget.dart';

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
      appBar: const AppBarWidget(
        title: "Profile",
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: StreamBuilder(
          stream: penggunaServices.getpenggunaById(idPengguna),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Menampilkan indikator loading jika sedang memuat data
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // Menampilkan pesan error jika terjadi kesalahan
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              print(
                  "INI ADLAAH VALUE ID PENGGUNA DARI PROFILE : ${idPengguna}");
              // Menampilkan data pengguna jika berhasil didapatkan
              final penggunaData = snapshot.data!;
              return Column(
                children: [
                  Stack(
                    children: [
                      AspectRatio(
                          aspectRatio: 16 / 9,
                          child: CachedNetworkImage(
                            imageUrl: penggunaData.backgroundImageUrl ??
                                "https://images.unsplash.com/photo-1626624340240-aadc087844fa?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                            placeholder: (context, url) => SizedBox(
                              width: 10,
                              height: 10,
                              child:
                                  CircularProgressIndicator(strokeWidth: 2.0),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            fit: BoxFit.cover,
                          )),
                      Positioned(
                        left: 25,
                        bottom: 25,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Container(
                            height: 150.0,
                            width: 150.0,
                            color: const Color(0xffFF0E58),
                            child: CachedNetworkImage(
                              imageUrl: penggunaData.profileImageUrl ??
                                  "https://www.gravatar.com/avatar/HASH?s=200&d=mp",
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                  child:
                                      CircularProgressIndicator()), // Placeholder saat gambar sedang dimuat
                              errorWidget: (context, url, error) => const Center(
                                  child: Icon(Icons
                                      .error)), // Widget yang ditampilkan jika terjadi kesalahan
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
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              penggunaData.email ?? 'Nama Pengguna Kosong',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                                onPressed: () => Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => EditProfileScreen(
                                        pengguna: penggunaData,
                                      ),
                                    )),
                                child: const Text("Edit Profile"))
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
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height -
                        350, // Sesuaikan tinggi dengan kebutuhan
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        Center(
                          child: StreamBuilder<List<Post>>(
                            stream: PostServices.getPostsByUserId(idPengguna),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }

                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                  return const CircularProgressIndicator(); // Menampilkan indikator loading saat data sedang dimuat.
                                default:
                                  if (snapshot.data!.isEmpty) {
                                    return const Text(
                                        'Tidak ada postingan.'); // Menampilkan pesan jika tidak ada postingan.
                                  } else {
                                    return GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisSpacing: 2,
                                        crossAxisSpacing: 2,
                                        crossAxisCount: 3,
                                      ),
                                      itemBuilder: (context, index) {
                                        final post = snapshot.data![index];
                                        print(post);
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailScreen(post: post),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            child: CachedNetworkImage(
                                              imageUrl: post.imageUrl![0],
                                              placeholder: (context, url) =>
                                                  const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: snapshot.data!.length,
                                    );
                                  }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              // Menampilkan pesan jika tidak ada data pengguna yang ditemukan
              return const Center(child: Text('Data pengguna tidak ditemukan'));
            }
          },
        ),
      ),
    );
  }
}
