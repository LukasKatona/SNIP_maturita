class MyUser {
  final String uid;
  final bool anon;
  MyUser({ this.uid, this.anon});
}

class UserData {

  final String uid;
  final String name;
  final String role;
  bool isCalLocked;
  final int fulXp;
  final int lessXp;
  final String group;
  bool darkOrLight;

  UserData({ this.uid, this.name, this.role, this.isCalLocked, this.fulXp, this.lessXp, this.group, this.darkOrLight });
}