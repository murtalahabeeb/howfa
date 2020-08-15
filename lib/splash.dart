import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:howfa/user.dart';
import 'package:provider/provider.dart';
import 'extralogic/colorConvert.dart';
import 'package:howfa/firebaseMethods.dart';
import 'package:howfa/resgister.dart';
import 'package:howfa/try.dart';
import 'home.dart';
import 'main.dart';
import 'Login.dart';
class splashScreen extends StatefulWidget {
  @override
  _splashScreenState createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  bool done=false;
  Auth logic=Auth();
  Widget backgroud(){
    return Container(
      decoration: (BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/background.jpg"),
              fit: BoxFit.cover)
      )
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), () {
      setState(() {
        done=true;
      });
     // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
        //return Auth().Wrapper();
      //}));
    });
  }

  @override
  Widget build(BuildContext context) {



    return done?logic.Wrapper(): Scaffold(
      body:
      Image.asset("assets/background.jpg",width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,fit: BoxFit.fill,),
    );
//    return Stack(
//      children: <Widget>[
//        Image.asset("assets/background.jpg",)
////        Scaffold(
////          body: Stack(
////            children: <Widget>[
////
////              Positioned(
////                child: Hero(
////                  tag: 'Logo',
////                  child: Image.asset(
////                    "assets/logohowfa.png",
////                    width: 90.0,
////                    height: 90.0,
////                    fit: BoxFit.cover,
////                  ),
////                ),
////                left: MediaQuery.of(context).size.width / 10,
////                top: MediaQuery.of(context).size.height / 20,
////              ),
////              Positioned(child: Column(
////                children: <Widget>[
////                  Row(
////                    children: <Widget>[
////                      Text("How",style: TextStyle(fontSize: 50.0,color: Color(0xFFFFFFFFF),fontFamily:"Segoe Pro",),),
////                      Text("fa",style: TextStyle(fontSize: 50.0,color:HexColor("#CECECE"),),)
////                    ],
////                  ),
////                  SizedBox(height: 10.0,),
////                  Text("...Let's Connect",style: TextStyle(fontSize: 30.0),)
////
////                ],
////              ),
////                bottom: MediaQuery.of(context).size.height*0.1 ,
////                right: MediaQuery.of(context).size.width / 8,
////              )
////            ],
////          ),
////        ),
//      ],
//    );
  }

}


