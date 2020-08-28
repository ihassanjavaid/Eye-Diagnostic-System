class UserData {
  UserData({this.email, this.displayName, this.isAdmin = false});

  final String displayName;
  final String email;
  final bool isAdmin;
}