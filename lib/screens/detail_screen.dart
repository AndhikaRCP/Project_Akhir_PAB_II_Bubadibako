import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_akhir_pab_ii_bubadibako/models/pengguna.dart';
import 'package:project_akhir_pab_ii_bubadibako/models/post.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailScreen extends StatefulWidget {
  final Post post;
  final Pengguna pengguna;

  DetailScreen({required this.post, required this.pengguna});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> _toggleFavorite() async {
    final isFavorite = _prefs.getBool('isFavorite_${widget.post.id}')?? false;
    if (isFavorite) {
      _prefs.remove('isFavorite_${widget.post.id}');
    } else {
      _prefs.setBool('isFavorite_${widget.post.id}', true);
    }
    setState(() {
      widget.post.isFavorite =!isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(width: 1, color: Colors.black),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Transform.scale(
                    scale: 0.8, // resize to 80% of original size
                    child: CachedNetworkImage(
                      imageUrl: widget.post.imageUrl![0],
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
             Center(
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: 250, // set width
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Center(
          child: Text(
            widget.post.caption,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
      SizedBox(width: 16),
      ElevatedButton(
        onPressed: _toggleFavorite,
        child: Icon(
          widget.post.isFavorite
              ? Icons.favorite
              : Icons.favorite_border,
          color: Colors.red,
        ),
      ),
    ],
  ),
),
              SizedBox(height: 16),
              Table(
                border: TableBorder.all(width: 1, color: Colors.grey),
                children: [
                     TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Username'),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${widget.pengguna.username}'),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Latitude'),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${widget.post.latitude}'),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Longitude'),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${widget.post.longitude}'),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Created at'),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              '${widget.post.createdAt != null ? widget.post.createdAt!.toDate().toString() : 'Unknown'}'),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Updated at'),
                ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              '${widget.post.updatedAt != null ? widget.post.updatedAt!.toDate().toString() : 'Unknown'}'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}