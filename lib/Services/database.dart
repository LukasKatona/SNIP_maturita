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

  // generate new teacher key
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

  // update admin vars
  Future updateAdminVars(String teacherKey, List<String> updateGroups) async{
    return await adminCollection.doc('variables').set({
      'teacherKey': teacherKey,
      'groups': updateGroups,
    });
  }

  // update user data

  Future updateUserData(String name, String role, bool isCalLocked, int fulXp, int lessXp, String group, bool darkOrLight) async{
    return await snipCollection.doc(uid).set({
      'name': name,
      'role': role,
      'isCalLocked': isCalLocked,
      'fulXp': fulXp,
      'lessXp': lessXp,
      'group': group,
      'darkOrLight':  darkOrLight,
    });
  }

  // admin variables from snapshot
  Variables _variablesFromSnapshot(DocumentSnapshot snapshot) {
    return Variables(
      teacherKey: snapshot.get('teacherKey') ?? '',
      groups: snapshot.get('groups') ?? '',
    );
  }

  // sniper list from snapshot

  List<Sniper> _sniperListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      return Sniper(
        uid: doc.id,
        name: doc.get('name') ?? '',
        role: doc.get('role') ?? '',
        isCalLocked: doc.get('isCalLocked') ?? '',
        fulXp: doc.get('fulXp') ?? '',
        lessXp: doc.get('lessXp') ?? '',
        group: doc.get('group') ?? '',
        darkOrLight: doc.get('darkOrLight'),
      );
    }).toList();
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.get('name') ?? '',
      role: snapshot.get('role') ?? '',
      isCalLocked: snapshot.get('isCalLocked') ?? '',
      fulXp: snapshot.get('fulXp') ?? '',
      lessXp: snapshot.get('lessXp') ?? '',
      group: snapshot.get('group') ?? '',
      darkOrLight: snapshot.get('darkOrLight') ?? true,
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