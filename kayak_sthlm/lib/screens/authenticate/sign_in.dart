import 'package:kayak_sthlm/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kayak_sthlm/screens/authenticate/reset_pass.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  final Function switchView;
  SignIn({this.toggleView, this.switchView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //Text field state
  bool hidePassword = true;
  String email = '';
  String password = '';
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
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            
            children: <Widget>[
              SizedBox(height:60.0),
              Text.rich(
                TextSpan(
                  text: 'Welcome back',
                  style: TextStyle(fontSize: 30),
                  children: <TextSpan>[
                    TextSpan(text: '\nLogin to continue', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(height:20.0),
              TextFormField(
                validator: (val) => validateEmail(val) ? 'Ange en giltig e-mail' : null,
                decoration: InputDecoration(
                  hintText: 'E-mail'
                ),
                onChanged: (val) {
                  setState(() => email = val);
                }
              ),
              SizedBox(height:50.0),
              TextFormField(
                validator: (val) => val.length < 6 ? 'Ange ett giltigt lösenord' : null,
                obscureText: hidePassword,
                decoration: InputDecoration(
                  hintText: 'Password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() => hidePassword = !hidePassword);
                    },
                    icon: Icon(hidePassword ? Icons.remove_red_eye : Icons.remove_red_eye_outlined ),
                  )
                ),
                onChanged: (val) {
                  setState(() => password = val);
                }
              ),
              SizedBox(height:40.0),
              CupertinoButton(
                child: Text('Log in'),
                color: CupertinoColors.activeBlue,
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    dynamic result = await _auth.signInMail(email, password);
                    if(result == null) {
                      setState(() => error = 'Ett fel uppstod');
                    }
                  }
                }
              ),
              SizedBox(height:20.0),
              CupertinoButton(
                child: Text('Create Account'),
                color: CupertinoColors.darkBackgroundGray,
                onPressed: () async {
                  ElevatedButton.icon(onPressed: widget.toggleView(), icon: Icon(Icons.person), label: Text('Logga in'));
                }
              ),
              SizedBox(height: 12.0),
              Text(
                error, 
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
              CupertinoButton(
                child: Text('Reset Password'),
                color: CupertinoColors.darkBackgroundGray,
                onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return ResetPass();
                      })
                    );
                  },
              ),
            ],
          )
        ),
      ),
    );
  }
}