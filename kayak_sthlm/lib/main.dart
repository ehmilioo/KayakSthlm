import 'package:kayak_sthlm/models/user.dart';
import 'package:kayak_sthlm/screens/home/home.dart';
import 'package:kayak_sthlm/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<TheUser>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Custom Fonts',
        // Set Montserrat as the default app font.
        theme: ThemeData(fontFamily: 'Montserrat'),
        home: SplashState(),
      ),
    );
  }
}
