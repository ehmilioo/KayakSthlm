import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kayak_sthlm/dialogs/reauth_dialog.dart';


class ChangePass extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChangePass();
}

class _ChangePass extends State<ChangePass> {
  final User user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
  }

  String error = '';
  bool hidePassword = true;
  String newPassword = '';
  String secondPassword = '';
  

  void updatePassword(String password) async{
    user.updatePassword(password)
      .then((val){
        print('Changed password succesfully');
      }).catchError((err){
        setState(() => error = 'An error has occured');
        print(err);
      });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
                child: Column(
                  children: <Widget>[
                    Text('Change Password?'),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 82, minHeight: 82),
                      child: TextFormField(
                          style: TextStyle(
                              fontFamily: 'HammersmithOne', fontSize: 18),
                          obscureText: hidePassword,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              contentPadding: EdgeInsets.only(top: 20),
                              labelStyle: TextStyle(
                                  color: Color.fromRGBO(136, 134, 134, 1)),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() => hidePassword = !hidePassword);
                                },
                                icon: Icon(hidePassword
                                    ? Icons.remove_red_eye
                                    : Icons.remove_red_eye_outlined),
                              )),
                          onChanged: (val) {
                            setState(() => newPassword = val);
                          })
                  ),
                  ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 82, minHeight: 82),
                      child: TextFormField(
                          style: TextStyle(
                              fontFamily: 'HammersmithOne', fontSize: 18),
                          obscureText: hidePassword,
                          decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              contentPadding: EdgeInsets.only(top: 20),
                              labelStyle: TextStyle(
                                  color: Color.fromRGBO(136, 134, 134, 1)),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() => hidePassword = !hidePassword);
                                },
                                icon: Icon(hidePassword
                                    ? Icons.remove_red_eye
                                    : Icons.remove_red_eye_outlined),
                              )),
                          onChanged: (val) {
                            setState(() => secondPassword = val);
                          })
                  ),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                    ElevatedButton(
                      child: Text("Change Password"),
                      onPressed:(){
                        if(newPassword == secondPassword){
                          showDialog(
                            context: context,
                            builder: (_) => AuthDialog(),
                          ).then((val) =>{
                            updatePassword(newPassword),
                            Navigator.pop(context)
                          });
                        }else{
                          setState(() => error = 'Passwords do not match');
                        }
                      },
                    ),
                  ],
                ),
              ),
    );
  }
}

class Constants{
  Constants._();
  static const double padding =20;
  static const double avatarRadius =45;
}