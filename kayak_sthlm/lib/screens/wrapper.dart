import 'package:kayak_sthlm/screens/authenticate/authenticate.dart';
import 'package:kayak_sthlm/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kayak_sthlm/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<TheUser>(context);

    //return either home or authenticate widget
    if(user == null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}