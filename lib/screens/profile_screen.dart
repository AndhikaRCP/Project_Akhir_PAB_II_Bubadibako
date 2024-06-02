import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_akhir_pab_ii_bubadibako/models/pengguna.dart';
import 'package:project_akhir_pab_ii_bubadibako/models/penggunaAbout.dart';
import 'package:project_akhir_pab_ii_bubadibako/screens/editProfileAbout.dart';
import 'package:project_akhir_pab_ii_bubadibako/screens/follower_screen.dart';
import 'package:project_akhir_pab_ii_bubadibako/screens/following_screen.dart';
import 'package:project_akhir_pab_ii_bubadibako/services/auth_services.dart';
import 'package:project_akhir_pab_ii_bubadibako/screens/edit_profile_screen.dart';
import 'package:project_akhir_pab_ii_bubadibako/services/pengguna_profile_services.dart';
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
                            child: CachedNetworkImage(
                              imageUrl: penggunaData.profileImageUrl ?? '',
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Center(
                                  child:
                                      CircularProgressIndicator()), // Placeholder saat gambar sedang dimuat
                              errorWidget: (context, url, error) => Center(
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
                        Center(
                            child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 2,
                                  crossAxisSpacing: 2,
                                  crossAxisCount: 3),
                          itemBuilder: (context, index) {
                            return Container(
                              color: Colors.grey,
                            );
                          },
                          itemCount: 22,
                        )),
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Positioned(
                                bottom: 0,
                                right: 20,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EditProfileAboutScreen(
                                          pengguna: penggunaData,
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text("Edit About"),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(30),
                                child: Column(
                                  children: [
                                    StreamBuilder(
                                      stream: penggunaServices
                                          .getPenggunaAboutProfile(
                                              penggunaData.id ?? ''),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          // Menampilkan indikator loading saat data sedang dimuat
                                          return CircularProgressIndicator();
                                        } else if (snapshot.hasError) {
                                          // Menampilkan pesan error jika terjadi kesalahan
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        } else {
                                          // Memuat data penggunaAbout dari snapshot
                                          PenggunaAbout? penggunaAbout =
                                              snapshot.data;
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              // Menampilkan teks dari penggunaAbout
                                              Text(
                                                penggunaAbout?.text ?? 'Kosong',
                                                style: const TextStyle(
                                                    fontSize: 20),
                                                textAlign: TextAlign.justify,
                                              ),
                                              const SizedBox(height: 20),
                                              // Menampilkan gambar dengan AspectRatio
                                              AspectRatio(
                                                aspectRatio: 16 / 9,
                                                child: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    // Menampilkan indikator loading saat gambar dimuat
                                                    if (penggunaAbout
                                                            ?.imageUrl ==
                                                        null)
                                                      CircularProgressIndicator(), // Indikator loading
                                                    // Memuat gambar dari URL Firebase Storage
                                                    if (penggunaAbout
                                                            ?.imageUrl !=
                                                        null)
                                                      CachedNetworkImage(
                                                        imageUrl: penggunaAbout!
                                                            .imageUrl!,
                                                        placeholder:
                                                            (context, url) =>
                                                                const Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            const Icon(
                                                                Icons.error),
                                                        fit: BoxFit.cover,
                                                      )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        }
                                      },
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
