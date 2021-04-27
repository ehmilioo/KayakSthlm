import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPass extends StatefulWidget {

  ResetPass();

  @override
  _ResetPass createState() => _ResetPass();
}



class _ResetPass extends State<ResetPass> {

  final _auth = FirebaseAuth.instance;

  String email = '';

  //Check e-mail
  bool validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  return (!regex.hasMatch(value)) ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
          children: [
            SizedBox(height:200),
            Text(
              'Reset your Password',
              style: TextStyle(fontSize: 30),
            ),
            TextFormField(
              validator: (val) => validateEmail(val) ? 'Ange en giltig e-mail' : null,
              onChanged: (val) {
                setState(() => email = val);
              },
              decoration: InputDecoration(
                labelText: 'Email',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white
                  ),
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white
                  ),
                ),
              ),
            ),
            SizedBox(height:20),
            CupertinoButton(
              child: Text('Reset Password'),
              color: CupertinoColors.activeBlue,
              onPressed: () async {
                try{
                  await _auth.sendPasswordResetEmail(email: email);
                }
                catch(e){
                  print(e);
                }
              }
            ),
            SizedBox(height:20),
            CupertinoButton(
              child: Text('Log in'),
              color: CupertinoColors.activeBlue,
              onPressed: () {
                Navigator.pop(context);
              }
            ),
          ],
          ),
        ),
      ),
    );
  }
}