import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kayak_sthlm/dialogs/AccountOk_dialog.dart';
import 'package:kayak_sthlm/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsEdit extends StatefulWidget {
  SettingsEdit();

  @override
  _SettingsEdit createState() => _SettingsEdit();
}

class _SettingsEdit extends State<SettingsEdit> {
  final _formKey = GlobalKey<FormState>();
  String uid = FirebaseAuth.instance.currentUser.uid;
  final Database db = Database();

  @override
  void initState() {
    super.initState();
  }

  var selectedExperienceLevel = '';
  var newUsername = '';
  var age = '';
  var selectedGender = '';

  bool _editMode = false;
  bool _ageSelected = false;
  bool _genderSelected = false;
  bool _expSelected = false;
  bool _unsavedChanges = false;
  bool _disabledButton = false;

  List<String> experienceLevels = <String>[
    'Beginner',
    'Average',
    'Skilled',
    'Specialist',
    'Expert',
  ];
  List<int> ageNumbers = Iterable<int>.generate(101).toList();
  List<String> genders = <String>['Male', 'Female', 'Other'];

  @override
  Widget build(BuildContext context) {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
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
                child: Column(
                  children: <Widget>[
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
                                    _editMode = !_editMode;
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
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                          child: Text('ACCOUNT',
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 35,
                              )),
                        ),
                      ],
                    ),
                    SizedBox(height: 33),
                    StreamBuilder<DocumentSnapshot>(
                        stream: usersCollection.doc(uid).snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          return snapshot.hasData
                              ? Container(
                                  height: 470,
                                  width: 324,
                                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(height: 10),
                                        OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                              minimumSize: Size(281, 48),
                                              primary: _disabledButton == true
                                                  ? Colors.black
                                                  : Colors.white,
                                              backgroundColor:
                                                  _disabledButton == true
                                                      ? Color.fromRGBO(
                                                          217, 221, 224, 1)
                                                      : Color.fromRGBO(
                                                          86, 151, 211, 1),
                                              shadowColor: Colors.black,
                                              elevation: 5,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  50))),
                                              textStyle:
                                                  TextStyle(fontSize: 18),
                                            ),
                                            child: Row(
                                              children: [
                                                SizedBox(width: 73),
                                                Icon(Icons.edit_outlined,
                                                    color:
                                                        _disabledButton == true
                                                            ? Colors.black
                                                            : Colors.white),
                                                SizedBox(width: 5),
                                                Text('Edit'),
                                              ],
                                            ),
                                            onPressed: () {
                                              _disabledButton == false
                                                  ? setState(() {
                                                      _editMode = !_editMode;
                                                      _disabledButton = true;
                                                    })
                                                  : null;
                                            }),
                                        SizedBox(height: 20),
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                              maxHeight: 82, minHeight: 82),
                                          child: TextFormField(
                                              validator: (val) => val.length < 3
                                                  ? 'Användarnamn för kort'
                                                  : null,
                                              enabled: _editMode,
                                              initialValue: snapshot.data
                                                  .data()['username'],
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 18,
                                                  color: _editMode == true
                                                      ? Colors.black
                                                      : Color.fromRGBO(
                                                          136, 134, 134, 1)),
                                              decoration: InputDecoration(
                                                  labelText: 'Username',
                                                  contentPadding:
                                                      EdgeInsets.only(top: 20),
                                                  labelStyle: TextStyle(
                                                      color: Color.fromRGBO(
                                                          136, 134, 134, 1))),
                                              onChanged: (val) {
                                                _unsavedChanges = true;
                                                newUsername = val;
                                              }),
                                        ),
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                              maxHeight: 82, minHeight: 82),
                                          child: TextFormField(
                                              enabled: false,
                                              initialValue:
                                                  snapshot.data.data()['email'],
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 18,
                                                  color: Color.fromRGBO(
                                                      136, 134, 134, 1)),
                                              decoration: InputDecoration(
                                                  labelText: 'Email',
                                                  contentPadding:
                                                      EdgeInsets.only(top: 20),
                                                  labelStyle: TextStyle(
                                                      color: Color.fromRGBO(
                                                          136, 134, 134, 0.7))),
                                              onChanged: (val) {}),
                                        ),
                                        SizedBox(height: 20),
                                        Container(
                                            alignment: Alignment.center,
                                            width: 259,
                                            height: 28,
                                            decoration: BoxDecoration(
                                                color: _editMode == true
                                                    ? Color.fromRGBO(
                                                        146, 199, 254, 1)
                                                    : Color.fromRGBO(
                                                        218, 221, 224, 1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50.0))),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton(
                                                isExpanded: true,
                                                elevation: 10,
                                                style: TextStyle(
                                                    color: Colors.black),
                                                items: experienceLevels.map<
                                                        DropdownMenuItem<
                                                            String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                hint: _expSelected == true
                                                    ? Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                            selectedExperienceLevel,
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)))
                                                    : Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                            snapshot.data
                                                                    .data()[
                                                                'experience'],
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 16))),
                                                onChanged: _editMode
                                                    ? (String value) =>
                                                        setState(() => {
                                                              selectedExperienceLevel =
                                                                  value,
                                                              _expSelected =
                                                                  true,
                                                              _unsavedChanges =
                                                                  true
                                                            })
                                                    : null,
                                              ),
                                            )),
                                        SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            //AGE
                                            Container(
                                                alignment: Alignment.center,
                                                width: 113,
                                                height: 28,
                                                decoration: BoxDecoration(
                                                    color: _editMode == true
                                                        ? Color.fromRGBO(
                                                            146, 199, 254, 1)
                                                        : Color.fromRGBO(
                                                            218, 221, 224, 1),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                50.0))),
                                                child:
                                                    DropdownButtonHideUnderline(
                                                        child: DropdownButton(
                                                  isExpanded: true,
                                                  elevation: 10,
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  items: ageNumbers.map<
                                                      DropdownMenuItem<
                                                          int>>((int value) {
                                                    return DropdownMenuItem<
                                                        int>(
                                                      value: value,
                                                      child: Text(
                                                          value.toString()),
                                                    );
                                                  }).toList(),
                                                  hint: _ageSelected == true
                                                      ? Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(age,
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                              )))
                                                      : Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                              snapshot.data
                                                                      .data()[
                                                                  'age'],
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600))),
                                                  onChanged: _editMode
                                                      ? (int value) {
                                                          _ageSelected = true;
                                                          _unsavedChanges =
                                                              true;
                                                          setState(() {
                                                            age = value
                                                                .toString();
                                                          });
                                                        }
                                                      : null,
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
                                                    color: _editMode == true
                                                        ? Color.fromRGBO(
                                                            146, 199, 254, 1)
                                                        : Color.fromRGBO(
                                                            218, 221, 224, 1),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                50.0))),
                                                child:
                                                    DropdownButtonHideUnderline(
                                                        child: DropdownButton(
                                                  isExpanded: true,
                                                  elevation: 10,
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  items: genders.map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                  hint: _genderSelected == true
                                                      ? Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                              selectedGender,
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                              )))
                                                      : Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                              snapshot.data
                                                                      .data()[
                                                                  'gender'],
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      14))),
                                                  onChanged: _editMode
                                                      ? (String value) {
                                                          _unsavedChanges =
                                                              true;
                                                          _genderSelected =
                                                              true;
                                                          setState(() {
                                                            selectedGender =
                                                                value;
                                                          });
                                                        }
                                                      : null,
                                                ))),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 40,
                                        ),
                                        OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                              minimumSize: Size(281, 48),
                                              primary: _expSelected &&
                                                      _ageSelected &&
                                                      _genderSelected == true
                                                  ? Colors.white
                                                  : Colors.black,
                                              backgroundColor:
                                                  _unsavedChanges == true
                                                      ? Color.fromRGBO(
                                                          139, 239, 123, 1)
                                                      : Color.fromRGBO(
                                                          217, 221, 224, 1),
                                              shadowColor: Colors.black54,
                                              elevation: 10,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  50))),
                                              textStyle: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                            child: Text('Save Changes'),
                                            onPressed: () {
                                              if (_editMode &&
                                                  _unsavedChanges &&
                                                  _formKey.currentState
                                                      .validate()) {
                                                _editMode = false;
                                                _unsavedChanges = false;
                                                showDialog(
                                                        context: context,
                                                        builder: (_) =>
                                                            AccountOkDialog())
                                                    .then((value) {
                                                  Navigator.of(context).pop();
                                                });

                                                if (newUsername == '') {
                                                  newUsername = snapshot.data
                                                      .data()['username'];
                                                }
                                                if (age == '') {
                                                  age = snapshot.data
                                                      .data()['age'];
                                                }
                                                if (selectedExperienceLevel ==
                                                    '') {
                                                  selectedExperienceLevel =
                                                      snapshot.data
                                                          .data()['experience'];
                                                }
                                                if (selectedGender == '') {
                                                  selectedGender = snapshot.data
                                                      .data()['gender'];
                                                }

                                                db.updateUser(
                                                    newUsername,
                                                    age,
                                                    selectedExperienceLevel,
                                                    selectedGender);
                                              } else {
                                                null;
                                              }
                                            }),
                                      ],
                                    ),
                                  ))
                              : Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.black,
                                  ),
                                );
                        }),
                  ],
                ),
              ),
            )));
  }
}
