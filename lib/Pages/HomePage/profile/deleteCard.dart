import 'package:flutter/material.dart';
import 'package:maturita/Services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DeleteDialog extends StatefulWidget {

  final String name;
  final String role;
  final String uid;
  DeleteDialog({ this.uid, this.name, this.role});

  @override
  _DeleteDialogState createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {

  final AuthService _auth = AuthService();
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete User'),
      content: Text('Do you really want to delete ${widget.role} ${widget.name}?'),
      actions: [
        FlatButton(onPressed: () => Navigator.pop(context), child: Text('Exit')),
        FlatButton(
            onPressed: () async {
            },
            child: Text('Delete')),
      ],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
    );
  }
}
