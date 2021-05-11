import 'package:flutter/material.dart';

class SavedDialog extends StatefulWidget {

  final String desc;

  SavedDialog({
    @required this.desc
  });

  @override
  State<StatefulWidget> createState() => _SavedDialog();
}

class _SavedDialog extends State<SavedDialog> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
                padding: EdgeInsets.only(left: Constants.padding,top: 120, right: Constants.padding,bottom: Constants.padding
                ),
                margin: EdgeInsets.only(top: Constants.avatarRadius),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Constants.padding),
                  boxShadow: [
                    BoxShadow(color: Colors.black,offset: Offset(0,10),
                    blurRadius: 10
                    ),
                  ]
                ),
                child: Text(widget.desc),
              ),
    );
  }
}

class Constants{
  Constants._();
  static const double padding =20;
  static const double avatarRadius =45;
}