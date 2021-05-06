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
  final _formKey = GlobalKey<FormState>();
  String email = '';
  bool _requestEnabled = false;
  String error = '';

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
        backgroundColor: Color.fromRGBO(242, 248, 255, 1),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/bakgrund.png"),
              fit: BoxFit.cover,
            )),
            padding: EdgeInsets.symmetric(horizontal: 60.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 180),
                  Text(
                    'Reset Password',
                    style:
                        TextStyle(fontFamily: 'HammersmithOne', fontSize: 35),
                  ),
                  SizedBox(height: 110),
                  ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 82, minHeight: 82),
                      child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontFamily: 'HammersmithOne', fontSize: 18),
                          validator: (val) => validateEmail(val)
                              ? 'Ange en giltig e-post'
                              : null,
                          decoration: InputDecoration(
                              labelText: 'Email',
                              contentPadding: EdgeInsets.only(top: 20),
                              labelStyle: TextStyle(
                                  color: Color.fromRGBO(136, 134, 134, 1))),
                          onChanged: (val) {
                            _requestEnabled = true;
                            setState(() => email = val);
                          })),
                  SizedBox(height: 30),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(281, 48),
                        primary: _requestEnabled == true
                            ? Colors.white
                            : Colors.black,
                        backgroundColor: _requestEnabled == true
                            ? Color.fromRGBO(86, 151, 211, 1)
                            : Color.fromRGBO(217, 221, 224, 1),
                        shadowColor: Colors.black54,
                        elevation: 10,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        textStyle: TextStyle(
                            fontSize: 18, fontFamily: 'HammersmithOne'),
                      ),
                      child: Text('Reset Password'),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ResetPassOk();
                          }));
                          // if (_formKey.currentState.validate()) {
                          //   await _auth.sendPasswordResetEmail(email: email);
                          //   Navigator.push(context,
                          //       MaterialPageRoute(builder: (context) {
                          //     return ResetPassOk();
                          //   }));
                          // }

                          // if (_auth.sendPasswordResetEmail(email: email) ==
                          //     null) {
                          //   setState(() => error = 'Ett fel uppstod');
                          // }
                          // }

                          try {
                            await _auth.sendPasswordResetEmail(email: email);
                          } catch (e) {
                            print(e);
                          }
                        }
                      }),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                  SizedBox(height: 188),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    TextButton(
                        style: TextButton.styleFrom(
                            primary: Color.fromRGBO(136, 134, 134, 1),
                            textStyle: TextStyle(
                                fontFamily: 'HammersmithOne', fontSize: 18)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Log In')),
                  ]),
                ],
              ),
            ),
          ),
        ));
  }
}

class ResetPassOk extends StatefulWidget {
  ResetPassOk();

  @override
  _ResetPassOk createState() => _ResetPassOk();
}

class _ResetPassOk extends State<ResetPassOk> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(242, 248, 255, 1),
        body: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/bakgrund.png"),
              fit: BoxFit.cover,
            )),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 60.0),
                child: Column(children: [
                  SizedBox(height: 180),
                  Text(
                    'Reset  Password',
                    style:
                        TextStyle(fontFamily: 'HammersmithOne', fontSize: 35),
                  ),
                  SizedBox(height: 110),
                  Text(
                    'A new password has been sent to your email.',
                    style:
                        TextStyle(fontFamily: 'HammersmithOne', fontSize: 20),
                  ),
                  SizedBox(height: 63),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(281, 48),
                        primary: Color.fromRGBO(86, 151, 211, 1),
                        backgroundColor: Colors.white,
                        shadowColor: Colors.black54,
                        elevation: 10,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        textStyle: TextStyle(
                            fontSize: 18, fontFamily: 'HammersmithOne'),
                      ),
                      child: Text('Log In'),
                      onPressed: () async {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      })
                ]))));
  }
}
