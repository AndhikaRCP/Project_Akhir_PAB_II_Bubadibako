import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<String> _favoriteImages = [
    'https://th.bing.com/th/id/R.6fd0ada60419a490759f689db9e51999?rik=FcoqT%2frVD8S5gQ&riu=http%3a%2f%2fs3.amazonaws.com%2frtvc-assets-senalradionica.gov.co%2fs3fs-public%2fsenalradionica%2farticulo-noticia%2fgaleriaimagen%2fpokemonfront.jpg&ehk=YEt%2bHE2IGWMTs9DUIrBgP9Eb%2fPXKMfzaa1bNd0urKD4%3d&risl=&pid=ImgRaw&r=0',
    'https://th.bing.com/th/id/R.6fd0ada60419a490759f689db9e51999?rik=FcoqT%2frVD8S5gQ&riu=http%3a%2f%2fs3.amazonaws.com%2frtvc-assets-senalradionica.gov.co%2fs3fs-public%2fsenalradionica%2farticulo-noticia%2fgaleriaimagen%2fpokemonfront.jpg&ehk=YEt%2bHE2IGWMTs9DUIrBgP9Eb%2fPXKMfzaa1bNd0urKD4%3d&risl=&pid=ImgRaw&r=0',
    'https://th.bing.com/th/id/R.6fd0ada60419a490759f689db9e51999?rik=FcoqT%2frVD8S5gQ&riu=http%3a%2f%2fs3.amazonaws.com%2frtvc-assets-senalradionica.gov.co%2fs3fs-public%2fsenalradionica%2farticulo-noticia%2fgaleriaimagen%2fpokemonfront.jpg&ehk=YEt%2bHE2IGWMTs9DUIrBgP9Eb%2fPXKMfzaa1bNd0urKD4%3d&risl=&pid=ImgRaw&r=0',
    'https://th.bing.com/th/id/OIP.pBdOuLW3zkj5DjYslbKg7QHaEK?rs=1&pid=ImgDetMain',
    'https://th.bing.com/th/id/R.6fd0ada60419a490759f689db9e51999?rik=FcoqT%2frVD8S5gQ&riu=http%3a%2f%2fs3.amazonaws.com%2frtvc-assets-senalradionica.gov.co%2fs3fs-public%2fsenalradionica%2farticulo-noticia%2fgaleriaimagen%2fpokemonfront.jpg&ehk=YEt%2bHE2IGWMTs9DUIrBgP9Eb%2fPXKMfzaa1bNd0urKD4%3d&risl=&pid=ImgRaw&r=0',
    'https://th.bing.com/th/id/R.6fd0ada60419a490759f689db9e51999?rik=FcoqT%2frVD8S5gQ&riu=http%3a%2f%2fs3.amazonaws.com%2frtvc-assets-senalradionica.gov.co%2fs3fs-public%2fsenalradionica%2farticulo-noticia%2fgaleriaimagen%2fpokemonfront.jpg&ehk=YEt%2bHE2IGWMTs9DUIrBgP9Eb%2fPXKMfzaa1bNd0urKD4%3d&risl=&pid=ImgRaw&r=0',
    'https://th.bing.com/th/id/R.6fd0ada60419a490759f689db9e51999?rik=FcoqT%2frVD8S5gQ&riu=http%3a%2f%2fs3.amazonaws.com%2frtvc-assets-senalradionica.gov.co%2fs3fs-public%2fsenalradionica%2farticulo-noticia%2fgaleriaimagen%2fpokemonfront.jpg&ehk=YEt%2bHE2IGWMTs9DUIrBgP9Eb%2fPXKMfzaa1bNd0urKD4%3d&risl=&pid=ImgRaw&r=0',
    'https://th.bing.com/th/id/OIP.pBdOuLW3zkj5DjYslbKg7QHaEK?rs=1&pid=ImgDetMain',
  ];

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
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorites',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 1.5,
            mainAxisSpacing: 1.5,
            childAspectRatio: 1.0,
          ),
          itemCount: _favoriteImages.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => _showImageDialog(_favoriteImages[index]),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 4),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: CachedNetworkImage(
                    imageUrl: _favoriteImages[index],
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
