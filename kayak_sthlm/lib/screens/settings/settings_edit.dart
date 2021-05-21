import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kayak_sthlm/services/database.dart';
import 'package:kayak_sthlm/dialogs/confirmation_dialog.dart';
import 'package:kayak_sthlm/screens/home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsEdit extends StatefulWidget {
  SettingsEdit();

  @override
  _SettingsEdit createState() => _SettingsEdit();
}

class _SettingsEdit extends State<SettingsEdit> {
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
    CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ElevatedButton(
                  child: Text('Edit'),
                  onPressed: (){
                    setState(() {
                      _editMode = !_editMode;      
                    });
                    print(_editMode);
                  }
                ),
              ],
            ),
            
            StreamBuilder<DocumentSnapshot>(
              stream: usersCollection.doc(uid).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                return snapshot.hasData ? Container(
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.symmetric(horizontal: 60.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 150),
                      Text('Account'),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 82, minHeight: 82),
                        child: TextFormField(
                            enabled: _editMode,
                            initialValue: snapshot.data.data()['username'],
                            style: TextStyle(
                                fontFamily: 'HammersmithOne', fontSize: 18),
                            decoration: InputDecoration(
                                labelText: 'Username',
                                contentPadding: EdgeInsets.only(top: 20),
                                labelStyle: TextStyle(
                                    color: Color.fromRGBO(136, 134, 134, 1))),
                            onChanged: (val) {
                              newUsername = val;
                            }),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 82, minHeight: 82),
                        child: TextFormField(
                            enabled: false,
                            initialValue: snapshot.data.data()['email'],
                            style: TextStyle(
                                fontFamily: 'HammersmithOne', fontSize: 18),
                            decoration: InputDecoration(
                                labelText: 'E-mail (Can not change!)',
                                contentPadding: EdgeInsets.only(top: 20),
                                labelStyle: TextStyle(
                                    color: Color.fromRGBO(136, 134, 134, 0.7))
                            ),
                            onChanged: (val) {
                              
                            }),
                      ),
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
                                child: Text(snapshot.data.data()['experience'],
                                    style: TextStyle(
                                      fontFamily: 'HammersmithOne',
                                      fontSize: 16,
                                    ))),
                        onChanged: _editMode ? (String value) => setState(() => {
                          selectedExperienceLevel = value,
                          _expSelected = true
                          }) 
                          : null
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
                                    child: Text(age,
                                        style: TextStyle(
                                          fontFamily: 'HammersmithOne',
                                          fontSize: 16,
                                        )))
                                : Align(
                                    alignment: Alignment.center,
                                    child: Text(snapshot.data.data()['age'],
                                        style: TextStyle(
                                          fontFamily: 'HammersmithOne',
                                          fontSize: 16,
                                        ))),
                            onChanged: _editMode ? (int value) {
                              _ageSelected = true;
                              setState(() {
                                age = value.toString();
                              });
                            }: null,
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
                                    child: Text(snapshot.data.data()['gender'],
                                        style: TextStyle(
                                          fontFamily: 'HammersmithOne',
                                          fontSize: 16,
                                        ))),
                            onChanged: _editMode ? (String value) {
                              _genderSelected = true;
                              setState(() {
                                selectedGender = value;
                              });
                            }: null,
                          ))),
                    ],
                  ),
                      SizedBox(
                        height: 33,
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
                                _editMode &&
                                _expSelected &&
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
                      child: Text('Save Changes'),
                      onPressed: (){
                        _editMode ? db.updateUser(newUsername, age, selectedExperienceLevel, selectedGender): null; //Error handla detta
                        _editMode = false;
                        showDialog(
                            context: this.context,
                            builder: (_) => Confirmation(message: 'All changes saved successfully', color: true)
                        ).then((val) =>{
                          Navigator.pop(context),
                        });
                      }
                    ),
                    ],
                  ),
                ): Center(
            child: CircularProgressIndicator(
                backgroundColor: Colors.black,
              ),
          );
              }
            ),
          ],
        ),
      ),
    );
  }
}