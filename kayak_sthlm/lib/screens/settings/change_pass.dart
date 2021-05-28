import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kayak_sthlm/dialogs/passOk_dialog.dart';
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
  bool _unsavedChanges = false;

  void updatePassword(String password) async {
    user.updatePassword(password).then((val) {
      print('Changed password succesfully');
    }).catchError((err) {
      setState(() => error = 'An error has occured');
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus.unfocus();
          }
        },
        child: Scaffold(
            backgroundColor: Color.fromRGBO(242, 248, 255, 1),
            body: SingleChildScrollView(
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("assets/bakgrund.png"),
                      fit: BoxFit.cover,
                    )),
                    padding: EdgeInsets.symmetric(horizontal: 45),
                    child: Column(children: <Widget>[
                      SizedBox(height: 90),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width: 54,
                              height: 54,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 3.0,
                                      offset: Offset(2.0, 3))
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.white,
                              ),
                              child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_back_ios_rounded,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    _unsavedChanges = false;
                                    setState(() {
                                      Navigator.pop(context);
                                    });
                                  })),
                          Container(
                            width: 220,
                            height: 54,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 3.0,
                                    offset: Offset(2.0, 3))
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                            ),
                            child: Text('PASSWORD',
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 35,
                                )),
                          ),
                        ],
                      ),
                      SizedBox(height: 33),
                      Container(
                        height: 470,
                        width: 324,
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 50),
                            ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxHeight: 82, minHeight: 82),
                                child: TextFormField(
                                    style: TextStyle(fontSize: 18),
                                    obscureText: hidePassword,
                                    decoration: InputDecoration(
                                        labelText: 'New Password',
                                        contentPadding:
                                            EdgeInsets.only(top: 20),
                                        labelStyle: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Color.fromRGBO(
                                                136, 134, 134, 1)),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() =>
                                                hidePassword = !hidePassword);
                                          },
                                          icon: Icon(hidePassword
                                              ? Icons.remove_red_eye
                                              : Icons.remove_red_eye_outlined),
                                        )),
                                    onChanged: (val) {
                                      setState(() => newPassword = val);
                                    })),
                            SizedBox(height: 33),
                            ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxHeight: 82, minHeight: 82),
                                child: TextFormField(
                                    style: TextStyle(fontSize: 18),
                                    obscureText: hidePassword,
                                    decoration: InputDecoration(
                                        labelText: 'Confirm New Password',
                                        contentPadding:
                                            EdgeInsets.only(top: 20),
                                        labelStyle: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Color.fromRGBO(
                                                136, 134, 134, 1)),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() =>
                                                hidePassword = !hidePassword);
                                          },
                                          icon: Icon(hidePassword
                                              ? Icons.remove_red_eye
                                              : Icons.remove_red_eye_outlined),
                                        )),
                                    onChanged: (val) {
                                      _unsavedChanges = true;
                                      setState(() => secondPassword = val);
                                    })),
                            Text(
                              error,
                              style:
                                  TextStyle(color: Colors.red, fontSize: 14.0),
                            ),
                            SizedBox(height: 115),
                            OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  minimumSize: Size(281, 48),
                                  primary: _unsavedChanges
                                      ? Colors.white
                                      : Colors.black,
                                  backgroundColor: _unsavedChanges == true
                                      ? Color.fromRGBO(139, 239, 123, 1)
                                      : Color.fromRGBO(217, 221, 224, 1),
                                  shadowColor: Colors.black54,
                                  elevation: 10,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  textStyle: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                child: Text('Save Changes'),
                                onPressed: () {
                                  if (_unsavedChanges) {
                                    if (newPassword == secondPassword) {
                                      showDialog(
                                              context: context,
                                              builder: (_) => AuthDialog())
                                          .then((val) => {
                                                updatePassword(newPassword),
                                                Navigator.of(context).pop()
                                              });
                                    } else {
                                      setState(() =>
                                          error = 'Passwords do not match');
                                    }
                                  }
                                })
                          ],
                        ),
                      )
                    ])))));
  }
}

class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 45;
}
