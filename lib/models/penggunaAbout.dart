class PenggunaAbout {
  String? id;
  String? text;
  String? imageUrl;

  PenggunaAbout({this.id, this.text, this.imageUrl});

  factory PenggunaAbout.fromMap(Map<String, dynamic> map) {
    return PenggunaAbout(
      id: map['id'],
      text: map['text'],
      imageUrl: map['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'imageUrl': imageUrl,
    };
  }
}
