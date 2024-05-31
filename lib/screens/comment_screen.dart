import 'package:flutter/material.dart';

class DialogScreen extends StatefulWidget {
  @override
  _DialogScreenState createState() => _DialogScreenState();
}

class _DialogScreenState extends State<DialogScreen> {
  final List<CommentItem> comments = [
    CommentItem(
      'BUDIONO SINAGA',
      'Punya mu punya ku, punya ku ya punya ku',
      '1 jam',
      'Lihat Balasan (4)',
      Icons.person,
    ),
    CommentItem(
      'Satria',
      'Saya mau main juga...',
      '1 jam',
      'Lihat Balasan (6)',
      Icons.person,
    ),
  ];

  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KOMENTAR'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(comments[index].avatarIcon, size: 40),
                  title: Text(comments[index].user),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(comments[index].text),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(comments[index].timeElapsed),
                          Text(comments[index].replyText),
                        ],
                      ),
                    ],
                  ),
                  trailing: Icon(Icons.keyboard_arrow_down),
                );
              },
            ),
          ),
          Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.person, size: 40),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Tambahkan Komentar...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    setState(() {
                      comments.add(CommentItem(
                        'You',
                        _commentController.text,
                        'Baru saja',
                        '',
                        Icons.person,
                      ));
                      _commentController.clear();
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CommentItem {
  final String user;
  final String text;
  final String timeElapsed;
  final String replyText;
  final IconData avatarIcon;

  CommentItem(
      this.user, this.text, this.timeElapsed, this.replyText, this.avatarIcon);
}
