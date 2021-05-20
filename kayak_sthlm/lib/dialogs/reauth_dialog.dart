// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class AuthDialog extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _AuthDialog();
// }

// class _AuthDialog extends State<AuthDialog> {
//   final User user = FirebaseAuth.instance.currentUser;

//   @override
//   void initState() {
//     super.initState();
//   }

//   bool hidePassword = true;
//   String _userProvidedPassword = '';

//   void reAuthenticate(String password){
//     EmailAuthCredential credential = EmailAuthProvider.credential(email: user.email, password: password);
//     try{
//       user.reauthenticateWithCredential(credential);
//       print('authenticated');
//       Navigator.pop(context);
//     }
//     catch(e){
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//                 padding: EdgeInsets.only(left: Constants.padding,top: 120, right: Constants.padding,bottom: Constants.padding
//                 ),
//                 margin: EdgeInsets.only(top: Constants.avatarRadius),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.rectangle,
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(Constants.padding),
//                   boxShadow: [
//                     BoxShadow(color: Colors.black,offset: Offset(0,10),
//                     blurRadius: 10
//                     ),
//                   ]
//                 ),
//                 child: Column(
//                   children: <Widget>[
//                     Text('To save these changes, you need to confirm your password below'),
//                     ConstrainedBox(
//                       constraints: BoxConstraints(maxHeight: 82, minHeight: 82),
//                       child: TextFormField(
//                           style: TextStyle(
//                               fontFamily: 'HammersmithOne', fontSize: 18),
//                           obscureText: hidePassword,
//                           decoration: InputDecoration(
//                               labelText: 'Password',
//                               contentPadding: EdgeInsets.only(top: 20),
//                               labelStyle: TextStyle(
//                                   color: Color.fromRGBO(136, 134, 134, 1)),
//                               suffixIcon: IconButton(
//                                 onPressed: () {
//                                   setState(() => hidePassword = !hidePassword);
//                                 },
//                                 icon: Icon(hidePassword
//                                     ? Icons.remove_red_eye
//                                     : Icons.remove_red_eye_outlined),
//                               )),
//                           onChanged: (val) {
//                             setState(() => _userProvidedPassword = val);
//                           })
//                   ),
//                     ElevatedButton(
//                       child: Text('Authenticate'),
//                       onPressed:(){
//                         reAuthenticate(_userProvidedPassword);
//                       },
//                     )
//                   ],
//                 ),
//               ),
//     );
//   }
// }

//   void reAuthenticate(String password){
//     EmailAuthCredential credential = EmailAuthProvider.credential(email: user.email, password: password);
//     try{
//       user.reauthenticateWithCredential(credential);
//       print('authenticated');
//       Navigator.pop(context);
//     }
//     catch(e){
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//                 padding: EdgeInsets.only(left: Constants.padding,top: 120, right: Constants.padding,bottom: Constants.padding
//                 ),
//                 margin: EdgeInsets.only(top: Constants.avatarRadius),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.rectangle,
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(Constants.padding),
//                   boxShadow: [
//                     BoxShadow(color: Colors.black,offset: Offset(0,10),
//                     blurRadius: 10
//                     ),
//                   ]
//                 ),
//                 child: Column(
//                   children: <Widget>[
//                     Text('To save these changes, you need to confirm your password below'),
//                     ConstrainedBox(
//                       constraints: BoxConstraints(maxHeight: 82, minHeight: 82),
//                       child: TextFormField(
//                           style: TextStyle(
//                               fontFamily: 'HammersmithOne', fontSize: 18),
//                           obscureText: hidePassword,
//                           decoration: InputDecoration(
//                               labelText: 'Password',
//                               contentPadding: EdgeInsets.only(top: 20),
//                               labelStyle: TextStyle(
//                                   color: Color.fromRGBO(136, 134, 134, 1)),
//                               suffixIcon: IconButton(
//                                 onPressed: () {
//                                   setState(() => hidePassword = !hidePassword);
//                                 },
//                                 icon: Icon(hidePassword
//                                     ? Icons.remove_red_eye
//                                     : Icons.remove_red_eye_outlined),
//                               )),
//                           onChanged: (val) {
//                             setState(() => _userProvidedPassword = val);
//                           })
//                     ),
//                     ElevatedButton(
//                       child: Text('Authenticate'),
//                       onPressed:(){
//                         reAuthenticate(_userProvidedPassword);
//                       },
//                     )
//                   ],
//                 ),
//               ),
//     );
//   }
// }

// class Constants{
//   Constants._();
//   static const double padding =20;
//   static const double avatarRadius =45;
// }
