import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'splash.dart';

void main() => runApp(MyApp());



class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>(create: (context) {
          return FirebaseAuth.instance.onAuthStateChanged;
        }),

      ],
      child: MaterialApp(
        home: splashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}


