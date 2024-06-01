import 'package:flutter/material.dart';
import 'package:project_akhir_pab_ii_bubadibako/data/follow_list.dart';
import 'package:project_akhir_pab_ii_bubadibako/models/userFollow.dart';

class FollowerScreen extends StatefulWidget {
  const FollowerScreen({Key? key}) : super(key: key);

  @override
  _FollowerScreenState createState() => _FollowerScreenState();
}

class _FollowerScreenState extends State<FollowerScreen>
    with TickerProviderStateMixin {
  List<UserFollow> _selectedUsers = [];
  List<UserFollow> _users = [];
  List<UserFollow> _searchResults = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _users = followlist;
    _searchController.addListener(_searchUsers);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchUsers() {
    setState(() {
      _searchResults = _users
         .where((user) => user.name
             .toLowerCase()
             .contains(_searchController.text.toLowerCase()))
         .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(right: 20, left: 20),
        color: Colors.white,
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search by name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        50), // large border radius for a circular shape
                    borderSide: BorderSide.none, // no border
                  ),
                  filled: true, // fill the background with a color
                  fillColor:
                      Color.fromARGB(223, 206, 204, 204), // background color
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10), // padding inside the search bar
                  prefixIcon: Icon(Icons.search, size: 24), // search icon
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _searchController.text.isEmpty
                   ? _users.length
                    : _searchResults.length,
                itemBuilder: (context, index) {
                  return userComponent(
                    user: _searchController.text.isEmpty
                       ? _users[index]
                        : _searchResults[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget userComponent({required UserFollow user}) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Container(
                width: 60,
                height: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(user.image),
                )),
            SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(user.name,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500)),
              SizedBox(
                height: 5,
              ),
              Text(user.username, style: TextStyle(color: Colors.grey[600])),
            ])
          ]),
          Container(
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffeeeeee)),
                borderRadius: BorderRadius.circular(50),
              ),
              child: MaterialButton(
                elevation: 0,
                color:
                    user.isFollowedByMe? Color(0xffeeeeee) : Color(0xffffff),
                onPressed: () {
                  setState(() {
                    user.isFollowedByMe =!user.isFollowedByMe;
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(user.isFollowedByMe? 'Unfollow' : 'Follow',
                    style: TextStyle(color: Colors.black)),
              ))
        ],
      ),
    );
  }
}