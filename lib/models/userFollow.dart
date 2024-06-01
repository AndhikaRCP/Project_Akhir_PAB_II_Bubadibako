class UserFollow {
  final String name;
  final String username;
  final String image;
  bool isTheyFollowMe;
  bool isFollowedByMe;

  UserFollow(this.name, this.username, this.image, this.isTheyFollowMe,
      this.isFollowedByMe);
}
