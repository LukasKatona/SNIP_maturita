import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maturita/Models/sniper.dart';
import 'package:maturita/Models/user.dart';
import 'package:maturita/Models/variables.dart';
import 'dart:math';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });


  // collection reference
  final CollectionReference snipCollection = FirebaseFirestore.instance.collection('snip');
  final CollectionReference adminCollection = FirebaseFirestore.instance.collection('admin');

  // update teacher key
  String generatePassword({
    bool letter = true,
    bool isNumber = true,
    bool isSpecial = true,
  }) {
    final length = 20;
    final letterLowerCase = "abcdefghijklmnopqrstuvwxyz";
    final letterUpperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    final number = '0123456789';
    final special = '@#%^*>\$@?/[]=+';

    String chars = "";
    if (letter) chars += '$letterLowerCase$letterUpperCase';
    if (isNumber) chars += '$number';
    if (isSpecial) chars += '$special';


    return List.generate(length, (index) {
      final indexRandom = Random.secure().nextInt(chars.length);
      return chars [indexRandom];
    }).join('');
  }

  Future updateTeacherKey() async{
    return await adminCollection.doc('variables').set({
      'teacherKey': generatePassword(),
    });
  }

  // update user data

  Future updateUserData(String name, String role, bool anon, int fulXp, int lessXp) async{
    return await snipCollection.doc(uid).set({
      'name': name,
      'role': role,
      'anon': anon,
      'fulXp': fulXp,
      'lessXp': lessXp,
    });
  }

  // admin variables from snapshot
  Variables _variablesFromSnapshot(DocumentSnapshot snapshot) {
    return Variables(
      teacherKey: snapshot.get('teacherKey') ?? '',
    );
  }

  // sniper list from snapshot

  List<Sniper> _sniperListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      return Sniper(
        uid: doc.id,
        name: doc.get('name') ?? '',
        role: doc.get('role') ?? '',
        anon: doc.get('anon') ?? '',
        fulXp: doc.get('fulXp') ?? '',
        lessXp: doc.get('lessXp') ?? '',
      );
    }).toList();
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.get('name') ?? '',
      role: snapshot.get('role') ?? '',
      anon: snapshot.get('anon') ?? '',
      fulXp: snapshot.get('fulXp') ?? '',
      lessXp: snapshot.get('lessXp') ?? '',
    );
  }

  // get admin variables stream
  Stream<Variables> get variables {
    return adminCollection.doc('variables').snapshots()
        .map(_variablesFromSnapshot);
  }

  //get sniper stream
  Stream<List<Sniper>> get snipers {
    return snipCollection.snapshots()
      .map(_sniperListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return snipCollection.doc(uid).snapshots()
        .map(_userDataFromSnapshot);
  }

}