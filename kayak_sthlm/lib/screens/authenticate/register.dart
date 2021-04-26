import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kayak_sthlm/services/auth.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();


  final experienceLevels = <String>['Beginner', 'Amateur', 'Expert', 'Coach'];

  //Text field state
  String username = '';
  String email = '';
  String password = '';
  String error = '';
  String dropdownValue = 'Beginner';
  int age = 0;

  //Bool
  bool hidePassword = true; //Obscure passwords with buttons and icons
  bool validatedInput = false;

  //Check e-mail
  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? true : false;
  }

  bool validatePassword(String value){
    Pattern pattern = 
        r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$';
    RegExp regex = new RegExp(pattern);
    return(!regex.hasMatch(value)) ? true : false;
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
              SizedBox(height:50.0),
              Text.rich(
                TextSpan(
                  text: 'Create',
                  style: TextStyle(fontSize: 30),
                  children: <TextSpan>[
                    TextSpan(text: '\n Account.', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(height:20.0),
              TextFormField(
                validator: (val) => val.length < 3 ? 'Användarnamn för kort' : null,
                decoration: InputDecoration(
                  hintText: 'Username',
                  suffixIcon : IconButton(
                    onPressed: (){},
                    icon: Icon(validatedInput ? Icons.check : null),
                  ),
                ),
                onChanged: (val) {
                  setState(() => username = val);
                }
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
              SizedBox(height:20.0),
              TextFormField(
                validator: (val) => validatePassword(val) ? 'Minst 8 tecken och minst en siffra' : null,
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
              SizedBox(height:20.0),




              //Fixa designen på denna
              DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                items: experienceLevels
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),





              
              CupertinoButton(
                child: Text('Registrera'),
                color: CupertinoColors.activeBlue,
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    dynamic result = await _auth.registerMail(email, password, username, dropdownValue, age);
                    if(result == null){
                      setState(() => error = 'Ett fel uppstod');
                    }
                  }
                },
              ),



              SizedBox(height: 12.0),


              //Preliminär errorhandling
              Text(
                error, 
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),




              CupertinoButton(
                child: Text('Logga in'),
                color: CupertinoColors.darkBackgroundGray,
                onPressed: () async {
                  ElevatedButton.icon(onPressed: widget.toggleView(), icon: Icon(Icons.person), label: Text('Logga in'));
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}