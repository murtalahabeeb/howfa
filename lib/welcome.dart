import 'dart:async';
import 'package:howfa/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'extralogic/colorConvert.dart';
class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: (BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/background.png"),
                  fit: BoxFit.cover)
          )
          ),
        ),
        Stack(
            children: <Widget>[
              Positioned(
                child: Hero(
                  tag: 'Logo',
                  child: Image.asset(
                    "assets/logohowfa.png",
                    width: 100.0,
                    height: 100.0,
                    fit: BoxFit.cover,
                  ),
                ),
                left: MediaQuery.of(context).size.width / 2.5,
                top: MediaQuery.of(context).size.height / 10.0,
              ),
              Positioned(child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  SizedBox(height: 10.0,),
                  Row(
                    children: <Widget>[
                      Text("Wel",style: TextStyle(fontSize: 70.0,color: Color(0xFFFFFFFFF),decoration: TextDecoration.none,fontFamily:"Segoe Pro",),),
                      Text("Come",style: TextStyle(fontSize: 70.0,color:HexColor("#CECECE"),decoration: TextDecoration.none,fontFamily:"SweetSans Pro"),)
                    ],
                  ),
                  SizedBox(height: 20.0,),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text("...Let's Connect",style: TextStyle(fontSize: 30.0,color: Colors.white,decoration: TextDecoration.none),),
                  ),
                  SizedBox(height: 20.0,),
                  Container(child: Center(child: SpinKitCircle(color: Colors.grey,size: 80.0,)),width: MediaQuery.of(context).size.width,)

                ],
              ),
                bottom: MediaQuery.of(context).size.height*0.1


              )
            ],
          ),
      ],
    );;
  }
}
