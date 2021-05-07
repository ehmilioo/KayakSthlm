import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:kayak_sthlm/screens/authenticate/sign_in.dart';
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

  List<int> ageNumbers = Iterable<int>.generate(101).toList();
  List<String> genders = <String>['Male', 'Female', 'Other'];

  //Bool
  bool hidePassword = true; //Obscure passwords with buttons and icons
  bool validatedInput = false;
  bool _expSelected = false;
  bool _genderSelected = false;
  bool _ageSelected = false;

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
                    'Create Account',
                    style:
                        TextStyle(fontFamily: 'HammersmithOne', fontSize: 35),
                  ),
                  SizedBox(height: 0),
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
                            setState(() => email = val);
                          })),
                  ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 82, minHeight: 82),
                      child: TextFormField(
                          style: TextStyle(
                              fontFamily: 'HammersmithOne', fontSize: 18),
                          validator: (val) => validatePassword(val)
                              ? 'Ange ett giltigt lösenord, minst 8 tecken 1 siffra'
                              : null,
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
                            setState(() => password = val);
                          })),
                  SizedBox(height: 5),
                  //EXPERIENCE
                  Container(
                      alignment: Alignment.center,
                      width: 259,
                      height: 28,
                      decoration: BoxDecoration(
                          color: _expSelected == true
                              ? Color.fromRGBO(146, 199, 254, 1)
                              : Color.fromRGBO(218, 221, 224, 1),
                          borderRadius:
                              BorderRadius.all(Radius.circular(50.0))),
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                        isExpanded: true,
                        elevation: 10,
                        style: TextStyle(color: Colors.black),
                        items: experienceLevels
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        hint: _expSelected == true
                            ? Align(
                                alignment: Alignment.center,
                                child: Text(selectedExperienceLevel,
                                    style: TextStyle(
                                      fontFamily: 'HammersmithOne',
                                      fontSize: 16,
                                    )))
                            : Align(
                                alignment: Alignment.center,
                                child: Text('Experience',
                                    style: TextStyle(
                                      fontFamily: 'HammersmithOne',
                                      fontSize: 16,
                                    ))),
                        onChanged: (String value) {
                          _expSelected = true;
                          setState(() {
                            selectedExperienceLevel = value;
                          });
                        },
                      ))),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //AGE
                      Container(
                          alignment: Alignment.center,
                          width: 113,
                          height: 28,
                          decoration: BoxDecoration(
                              color: _ageSelected == true
                                  ? Color.fromRGBO(146, 199, 254, 1)
                                  : Color.fromRGBO(218, 221, 224, 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0))),
                          child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                            isExpanded: true,
                            elevation: 10,
                            style: TextStyle(color: Colors.black),
                            items: ageNumbers
                                .map<DropdownMenuItem<int>>((int value) {
                              return DropdownMenuItem<int>(
                                value: value,
                                child: Text(value.toString()),
                              );
                            }).toList(),
                            hint: _ageSelected == true
                                ? Align(
                                    alignment: Alignment.center,
                                    child: Text(age + ' years',
                                        style: TextStyle(
                                          fontFamily: 'HammersmithOne',
                                          fontSize: 16,
                                        )))
                                : Align(
                                    alignment: Alignment.center,
                                    child: Text('Age',
                                        style: TextStyle(
                                          fontFamily: 'HammersmithOne',
                                          fontSize: 16,
                                        ))),
                            onChanged: (int value) {
                              _ageSelected = true;
                              setState(() {
                                age = value.toString();
                              });
                            },
                          ))),

                      SizedBox(
                        width: 33,
                      ),

                      //GENDER
                      Container(
                          alignment: Alignment.center,
                          width: 113,
                          height: 28,
                          decoration: BoxDecoration(
                              color: _genderSelected == true
                                  ? Color.fromRGBO(146, 199, 254, 1)
                                  : Color.fromRGBO(218, 221, 224, 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0))),
                          child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                            isExpanded: true,
                            elevation: 10,
                            style: TextStyle(color: Colors.black),
                            items: genders
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            hint: _genderSelected == true
                                ? Align(
                                    alignment: Alignment.center,
                                    child: Text(selectedGender,
                                        style: TextStyle(
                                          fontFamily: 'HammersmithOne',
                                          fontSize: 16,
                                        )))
                                : Align(
                                    alignment: Alignment.center,
                                    child: Text('Gender',
                                        style: TextStyle(
                                          fontFamily: 'HammersmithOne',
                                          fontSize: 16,
                                        ))),
                            onChanged: (String value) {
                              _genderSelected = true;
                              setState(() {
                                selectedGender = value;
                              });
                            },
                          ))),
                    ],
                  ),
                  SizedBox(height: 20.0),

                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(281, 48),
                        primary: _expSelected &&
                                _ageSelected &&
                                _genderSelected == true
                            ? Colors.white
                            : Colors.black,
                        backgroundColor: _expSelected &&
                                _ageSelected &&
                                _genderSelected == true
                            ? Color.fromRGBO(86, 151, 211, 1)
                            : Color.fromRGBO(217, 221, 224, 1),
                        shadowColor: Colors.black54,
                        elevation: 10,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        textStyle: TextStyle(
                            fontSize: 18, fontFamily: 'HammersmithOne'),
                      ),
                      child: Text('Sign Up'),
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
                      }),

                  //Preliminär errorhandling
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),

                  SizedBox(
                    height: 65,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    TextButton(
                        style: TextButton.styleFrom(
                            primary: Color.fromRGBO(136, 134, 134, 1),
                            textStyle: TextStyle(
                                fontFamily: 'HammersmithOne', fontSize: 18)),
                        onPressed: widget.toggleView,
                        child: Text('Log In')),
                  ]),
                  // CupertinoButton(
                  //     child: Text('Logga in'),
                  //     color: CupertinoColors.darkBackgroundGray,
                  //     onPressed: () async {
                  //       ElevatedButton.icon(
                  //           onPressed: widget.toggleView(),
                  //           icon: Icon(Icons.person),
                  //           label: Text('Logga in'));
                  // }),
                ],
              ),
            ),
          ),
        ));
  }
}
