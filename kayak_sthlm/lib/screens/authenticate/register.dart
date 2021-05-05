import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
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

  //Text field state
  String username = '';
  String email = '';
  String password = '';
  String error = '';

  //Imported package vars
  var age = 'Age';
  var selectedExperienceLevel = "Skill level";
  var selectedGender = "Gender";

  List<String> experienceLevels = <String>[
    'Beginner',
    'Average',
    'Skilled',
    'Specialist',
    'Expert',
  ];
  List<String> genders = <String>['Male', 'Female', 'Other'];

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

  bool validatePassword(String value) {
    Pattern pattern = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? true : false;
  }

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
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 60.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 180),
                  Text(
                    'Create Account',
                    style:
                        TextStyle(fontFamily: 'HammersmithOne', fontSize: 35),
                  ),
                  SizedBox(height: 110),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 82, minHeight: 82),
                    child: TextFormField(
                        style: TextStyle(
                            fontFamily: 'HammersmithOne', fontSize: 18),
                        validator: (val) =>
                            val.length < 3 ? 'Användarnamn för kort' : null,
                        decoration: InputDecoration(
                            labelText: 'Username',
                            contentPadding: EdgeInsets.only(top: 20),
                            labelStyle: TextStyle(
                                color: Color.fromRGBO(136, 134, 134, 1))),
                        onChanged: (val) {
                          setState(() => username = val);
                        }),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                      validator: (val) =>
                          validateEmail(val) ? 'Ange en giltig e-mail' : null,
                      decoration: InputDecoration(hintText: 'E-mail'),
                      onChanged: (val) {
                        setState(() => email = val);
                      }),
                  SizedBox(height: 20.0),
                  TextFormField(
                      validator: (val) => validatePassword(val)
                          ? 'Minst 8 tecken och minst en siffra'
                          : null,
                      obscureText: hidePassword,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() => hidePassword = !hidePassword);
                            },
                            icon: Icon(hidePassword
                                ? Icons.remove_red_eye
                                : Icons.remove_red_eye_outlined),
                          )),
                      onChanged: (val) {
                        setState(() => password = val);
                      }),
                  SizedBox(height: 20.0),

                  FloatingActionButton.extended(
                    icon: Icon(Icons.keyboard_arrow_down),
                    label: Text(selectedExperienceLevel),
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    onPressed: () => {
                      showMaterialRadioPicker(
                        context: context,
                        title: "Pick Your Skill Level",
                        items: experienceLevels,
                        onChanged: (value) =>
                            setState(() => selectedExperienceLevel = value),
                      )
                    },
                  ),
                  Row(
                    children: <Widget>[
                      FloatingActionButton.extended(
                        icon: Icon(Icons.keyboard_arrow_down),
                        label: Text(selectedGender),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        onPressed: () => {
                          showMaterialRadioPicker(
                              context: context,
                              title: "Pick Your Gender",
                              items: genders,
                              onChanged: (value) {
                                setState(() => selectedGender = value);
                              })
                        },
                      ),
                      FloatingActionButton.extended(
                        icon: Icon(Icons.keyboard_arrow_down),
                        label: Text(age),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        onPressed: () => {
                          showMaterialNumberPicker(
                            context: context,
                            title: "Pick Your Age",
                            maxNumber: 100,
                            minNumber: 1,
                            onChanged: (value) {
                              setState(() => age = value.toString());
                            },
                          )
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 40.0),

                  CupertinoButton(
                    child: Text('Registrera'),
                    color: CupertinoColors.activeBlue,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        dynamic result = await _auth.registerMail(
                            email,
                            password,
                            username,
                            selectedExperienceLevel,
                            age,
                            selectedGender);
                        if (result == null) {
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
                        ElevatedButton.icon(
                            onPressed: widget.toggleView(),
                            icon: Icon(Icons.person),
                            label: Text('Logga in'));
                      }),
                ],
              ),
            ),
          ),
        ));
  }
}
