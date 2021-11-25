import 'package:flutter/material.dart';
import 'package:maturita/Services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maturita/Services/database.dart';
import 'package:maturita/shared/design.dart';

class DeleteDialog extends StatefulWidget {

  final String name;
  final String role;
  final String uid;
  int fulXp;
  int lessXp;
  DeleteDialog({ this.uid, this.name, this.role, this.fulXp, this.lessXp});

  @override
  _DeleteDialogState createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: MyColorTheme.Secondary,
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('Delete User', style: TextStyle(color: MyColorTheme.PrimaryAccent, fontSize: 24),),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Text('Do you really want to delete ${widget.role} ${widget.name}?\nThis account will be suspended. You can recover it from the Firebase console.', style: TextStyle(color: MyColorTheme.Text),),
          ),
          Row(
            children: [
              Expanded(
                  child: FlatButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                    )),
                    color: MyColorTheme.Primary,
                    height: 59,
                    onPressed: () => Navigator.pop(context),
                    child: Text('Exit', style: TextStyle(color: Colors.white, fontSize: 16),),
                  )
              ),
              Expanded(
                child: FlatButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                    )),
                    color: MyColorTheme.PrimaryAccent,
                    height: 59,
                    onPressed: () async {
                      await DatabaseService(uid: widget.uid).updateUserData(widget.name, "deleted", false, widget.fulXp, widget.lessXp, 'none');
                      Navigator.pop(context);
                    },
                    child: Text('Delete', style: TextStyle(color: Colors.white, fontSize: 16),),
                ),
              ),
            ],
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
    );
  }
}
