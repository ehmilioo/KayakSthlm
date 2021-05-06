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
  bool _loginEnabled = false;

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
                      kayakImageText,
                      ConstrainedBox(
                          constraints:
                              BoxConstraints(maxHeight: 82, minHeight: 82),
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
                                _loginEnabled = true;
                                setState(() => email = val);
                              })),
                      ConstrainedBox(
                          constraints:
                              BoxConstraints(maxHeight: 82, minHeight: 82),
                          child: TextFormField(
                              style: TextStyle(
                                  fontFamily: 'HammersmithOne', fontSize: 18),
                              validator: (val) => val.length < 6
                                  ? 'Ange ett giltigt lösenord'
                                  : null,
                              obscureText: hidePassword,
                              decoration: InputDecoration(
                                  labelText: 'Password',
                                  contentPadding: EdgeInsets.only(top: 20),
                                  labelStyle: TextStyle(
                                      color: Color.fromRGBO(136, 134, 134, 1)),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(
                                          () => hidePassword = !hidePassword);
                                    },
                                    icon: Icon(hidePassword
                                        ? Icons.remove_red_eye
                                        : Icons.remove_red_eye_outlined),
                                  )),
                              onChanged: (val) {
                                _loginEnabled = true;
                                setState(() => password = val);
                              })),
                      SizedBox(height: 10),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            minimumSize: Size(281, 48),
                            primary: _loginEnabled == true
                                ? Colors.white
                                : Colors.black,
                            backgroundColor: _loginEnabled == true
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
                          child: Text('Log in'),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              dynamic result =
                                  await _auth.signInMail(email, password);
                              if (result == null) {
                                setState(() => error = 'Ett fel uppstod');
                              }
                            }
                          }),
                      SizedBox(height: 20),
                      Row(
                        children: <Widget>[
                          SizedBox(
                              width: 90.9,
                              child: CustomPaint(
                                  painter: Drawhorizontalline(true))),
                          SizedBox(
                              width: 90.9,
                              child: Text('or',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color.fromRGBO(136, 134, 134, 1),
                                      fontFamily: 'HammersmithOne',
                                      fontSize: 18))),
                          SizedBox(
                              width: 90.9,
                              child: CustomPaint(
                                  painter: Drawhorizontalline(false)))
                        ],
                      ),
                      SizedBox(height: 20),
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
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'HammersmithOne'),
                          ),
                          child: Text('Create Account'),
                          onPressed: () async {
                            widget.toggleView();
                          }),
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
                                    fontFamily: 'HammersmithOne',
                                    fontSize: 18)),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ResetPass();
                              }));
                            },
                            child: Text('Forgot Password?')),
                      ]),
                    ],
                  ),
                ))));
  }
}

final kayakImageText = Stack(children: <Widget>[
  Image(
    image: AssetImage('assets/kayak1.png'),
    width: 350,
    height: 285,
  ),
  Positioned(
      top: 215,
      left: 10,
      child: Text.rich(TextSpan(
        text: 'KayakSthlm.',
        style: TextStyle(fontFamily: 'FugazOne', fontSize: 40),
      )))
]);

class Drawhorizontalline extends CustomPainter {
  Paint _paint;
  bool reverse;

  Drawhorizontalline(this.reverse) {
    _paint = Paint()
      ..color = Color.fromRGBO(136, 134, 134, 1)
      ..strokeWidth = 0.6
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (!reverse) {
      canvas.drawLine(Offset(-20, 0.0), Offset(90.9, 0.0), _paint);
    } else {
      canvas.drawLine(Offset(0.0, 0.0), Offset(110.9, 0.0), _paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
