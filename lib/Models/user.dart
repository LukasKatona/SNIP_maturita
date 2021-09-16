class MyUser {
  final String uid;
  final bool anon;
  MyUser({ this.uid, this.anon});
}

class UserData {

  final String uid;
  final String name;
  final String role;
  bool anon;

  UserData({ this.uid, this.name, this.role, this.anon });
}