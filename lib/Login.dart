import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:howfa/Messages.dart';
import 'package:howfa/firebaseMethods.dart';
import 'package:howfa/resgister.dart';
import 'package:howfa/welcome.dart';
import 'extralogic/colorConvert.dart';
import 'home.dart';
import 'user.dart';

class Login extends StatefulWidget {
  FirebaseUser user;
  Login(this.user);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Widget back;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  Auth logic = Auth();
  String first;
  String second;
  String error="";
  bool loading=false;
  Map snapshot;

  Widget background() {
    return Container(
      decoration: (BoxDecoration(
          color: Colors.black.withOpacity(0),
          image: DecorationImage(
              image: AssetImage("assets/background.png"), fit: BoxFit.cover))),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 50.0, sigmaX: 50.0),
        child: Container(
          color: Colors.black.withOpacity(0),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firestore.instance.collection("users").document(widget.user.uid).get().then((doc){

      setState(() {
        snapshot=doc.data;
        loading=true;
      });
    });
//    setState(() {
//      back = background();
//    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:loading?CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300.0,
            flexibleSpace: FlexibleSpaceBar(
              background:snapshot["ProfilePic"]==null?Image.asset("assets/profilePic.png",fit: BoxFit.cover,):Image.network(snapshot["ProfilePic"],fit: BoxFit.fill,)
            ),

          ),
          SliverList(delegate: SliverChildListDelegate([
            Form(child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  onChanged: (val){
                    first=val;
                  },

                  initialValue:snapshot["name"]??"",
                  decoration: InputDecoration(
                      labelText: "name"
                  ),
                ),
                TextFormField(
                  onChanged: (val){
                    second=val;
                  },
                  initialValue: snapshot["dob"]??"",
                  decoration: InputDecoration(
                      labelText: "dob"
                  ),
                ),
                FocusScope(
                  node: FocusScopeNode(),
                  child: TextFormField(
                    initialValue:snapshot["PhoneNo"],
                    decoration: InputDecoration(
                        labelText: "Phone Number"
                    ),
                  ),
                ),
                RaisedButton(child: Center(child: Text("Next")),color: Colors.blue,padding: EdgeInsets.all(5.0) ,onPressed: () async{
                  await Firestore.instance.collection("users").document(snapshot["uid"]).updateData({"dob":second,"name":first});
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return home();
                  }));
                })

              ],
            ))
          ])
          )

        ],
      ):Container()
    );
//    return loading? Welcome(): Stack(
//      children: <Widget>[
//        back,
//        Scaffold(
//            backgroundColor: Colors.black.withOpacity(0),
//            body: ListView(
//              children: <Widget>[
//                Form(key: key,
//                    child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                      children: <Widget>[
//                        SizedBox(
//                          height: MediaQuery
//                              .of(context)
//                              .size
//                              .height * 0.05,
//                        ),
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[
//                            Hero(
//                              tag: "Logo",
//                              child: Image.asset(
//                                "assets/logohowfa.png",
//                                width: 90.0,
//                                height: 90.0,
//                                fit: BoxFit.cover,
//                              ),
//                            ),
//                            SizedBox(
//                              width: 5.0,
//                            ),
//                            Text(
//                              "How",
//                              style: TextStyle(
//                                fontSize: 50.0,
//                                color: Color(0xFFFFFFFFF),
//                              ),
//                            ),
//                            Text(
//                              "fa",
//                              style: TextStyle(
//                                fontSize: 50.0,
//                                color: HexColor("#CECECE"),
//                              ),
//                            )
//                          ],
//                        ),
//                        SizedBox(
//                          height: MediaQuery
//                              .of(context)
//                              .size
//                              .height * 0.20,
//                        ),
//                        Text(
//                          "User Login",
//                          style: TextStyle(
//                              fontSize: 40.0, color: Color(0xFFFFFFFFF)),
//                        ),
//                        SizedBox(
//                          height: 10.0,
//                        ),
//                        Material(
//                          elevation: 8.0,
//                          shadowColor: Colors.black,
//                          borderRadius: BorderRadius.circular(20.0),
//                          child: Container(
//                              padding: EdgeInsets.only(left: 10.0),
//                              decoration: BoxDecoration(
//                                  borderRadius: BorderRadius.circular(10.0),
//                                  color: HexColor("#FFFFFF")),
//                              width: MediaQuery
//                                  .of(context)
//                                  .size
//                                  .width * 0.8,
//                              child:TextFormField(
//                                controller:first,
//                                decoration: InputDecoration(
//                                  border: InputBorder.none,
//                                  hintText: "Phone Number",
//                                  errorStyle: TextStyle(fontSize: 20.0),
//                                  prefixIcon: Icon(
//                                    Icons.person_outline,
//                                    size: 30.0,
//                                    color: Colors.grey,
//                                  ),
//                                  hintStyle: TextStyle(
//                                      fontSize: 25.0, color: HexColor("#CECECE")),
//                                ),
//
//                              )
//                          ),
//                        ),
//                        SizedBox(
//                          height: 20.0,
//                        ),
////                        Material(
////                          elevation: 8.0,
////                          shadowColor: Colors.black,
////                          borderRadius: BorderRadius.circular(20.0),
////                          child: Container(
////                            padding: EdgeInsets.only(left: 10.0),
////                              decoration: BoxDecoration(
////                                  borderRadius: BorderRadius.circular(10.0),
////                                  color: HexColor("#FFFFFF")),
////                              width: MediaQuery
////                                  .of(context)
////                                  .size
////                                  .width * 0.8,
////                              child:TextFormField(
////                                controller:seond,
////                                decoration: InputDecoration(
////                                  border: InputBorder.none,
////                                  hintText: "Password",
////                                  errorStyle: TextStyle(fontSize: 20.0),
////                                  suffixIcon:GestureDetector(
////                                    onTap: (){
////
////                                    },
////                                    child: Icon(
////                                      Icons.remove_red_eye,
////                                      size: 30.0,
////                                      color: Colors.grey,
////                                    ),
////                                  ) ,
////                                  prefixIcon: Icon(
////                                    Icons.lock_outline,
////                                    size: 30.0,
////                                    color: Colors.grey,
////                                  ),
////                                  hintStyle: TextStyle(
////                                      fontSize: 25.0, color: HexColor("#CECECE")),
////                                ),
////
////                              )
////                          ),
////                        ),
////                        SizedBox(
////                          height: 20.0,
////                        ),
//                        Material(
//                          elevation: 8.0,
//                          shadowColor: Colors.black,
//                          borderRadius: BorderRadius.circular(10.0),
//                          child: Container(
//                              height: MediaQuery
//                                  .of(context)
//                                  .size
//                                  .height * 0.08,
//                              decoration: BoxDecoration(
//                                  borderRadius: BorderRadius.circular(10.0),
//                                  color: HexColor("#616161")),
//                              width: MediaQuery
//                                  .of(context)
//                                  .size
//                                  .width * 0.8,
//                              child: RaisedButton(
//                                child: Text(
//                                  "Send Pin",
//                                  style: TextStyle(
//                                    color: HexColor("#FFFFFF"),
//                                    fontSize: 30.0,
//                                  ),
//                                ),
//                                onPressed: () async {
//                                    setState(() {
//                                      loading =!loading;
//                                    });
//                                    dynamic login = await logic.signin(first.text,seond.text);
//
//                                    if(login==FirebaseUser){
//
//                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
//                                        return home();
//                                      }));
//                                    }
//                                    else{
//                                      setState(() {
//                                        error=login.toString();
//                                        loading =!loading;
////                                        Navigator.push(context, MaterialPageRoute(builder: (context) {
////                                          return home(login);
////                                        }));
//
//                                      });
//
//
//                                    }
//
////                                  FirebaseUser user= await logic.getUser();
////                                  Message mgs=Message.text(user.uid,user2.uid,controller.text,"text",FieldValue.serverTimestamp())
////                                    logic.sendMgs(user, user2, mgs);
//
//
//
//
//                                },
//                                color: HexColor("#616161"),
//                                shape: RoundedRectangleBorder(
//                                    borderRadius: BorderRadius.circular(10.0)),
//                              )
//                          ),
//                        ),
//                        SizedBox(height: 5.0,),
//                        Text(error,style: TextStyle(fontSize: 20.0,color: Colors.red,),)
//
//
//                      ],
//                    ),
//                  ),
//                SizedBox(
//                  height: MediaQuery
//                      .of(context)
//                      .size
//                      .height * 0.02,
//                ),
//                Center(
//                  child: GestureDetector(
//                    child: Text(
//                      "Forgot Password?",
//                      style: TextStyle(
//                          color: Color(0xFFFFFFFFF),
//                          fontSize: 20.0,
//                          fontWeight: FontWeight.bold),
//                    ),
//                    onTap: () {},
//                  ),
//                ),
//                SizedBox(
//                  height: MediaQuery
//                      .of(context)
//                      .size
//                      .height * 0.05,
//                ),
//                Padding(
//                  padding: const EdgeInsets.only(bottom:10.0),
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
//                      Text(
//                        "Dont Have an account?  ",
//                        style: TextStyle(
//                            color: Color(0xFFFFFFFFF),
//                            fontSize: 20.0,
//                            fontWeight: FontWeight.bold),
//                      ),
//                      GestureDetector(
//                        child: Text(
//                          "Sign Up",
//                          style: TextStyle(
//                              color: Colors.red,
//                              fontSize: 30.0,
//                              decoration: TextDecoration.underline,
//                              fontWeight: FontWeight.bold),
//                        ),
//                        onTap: () {
//                          Navigator.push(context, MaterialPageRoute(builder: (context) {
//                            return Register();
//                          }));
//                        },
//                      )
//                    ],
//                  ),
//                ),
//              ],
//            )),
//      ],
//    );
  }
}
