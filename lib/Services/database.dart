import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maturita/Models/sniper.dart';
import 'package:maturita/Models/user.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });


  // collection reference
  final CollectionReference snipCollection = FirebaseFirestore.instance.collection('snip');

  Future updateUserData(String name, String role, bool anon) async{
    return await snipCollection.doc(uid).set({
      'name': name,
      'role': role,
      'anon': anon,
    });
  }

  // sniper list from snapshot

  List<Sniper> _sniperListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      return Sniper(
        name: doc.get('name') ?? '',
        role: doc.get('role') ?? '',
        anon: doc.get('anon') ?? '',
      );
    }).toList();
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.get('name') ?? 'jozo',
      role: snapshot.get('role') ?? '',
      anon: snapshot.get('anon') ?? '',
    );
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