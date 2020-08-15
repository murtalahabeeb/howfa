import 'dart:convert';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:howfa/Login.dart';
import 'package:howfa/Messages.dart';
import 'package:howfa/firebaseMethods.dart';
import 'package:howfa/home.dart';
import 'package:howfa/welcome.dart';
import 'extralogic/colorConvert.dart';
import 'user.dart';
import 'package:http/http.dart'as http;

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Widget back;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  Auth logic = Auth();
  TextEditingController first = TextEditingController();
  TextEditingController second = TextEditingController();
  TextEditingController third = TextEditingController();
  TextEditingController fouth = TextEditingController();
  TextEditingController fifth = TextEditingController();
  TextEditingController sixth = TextEditingController();
  String error = "";
  bool loading = false;
  bool codeSent=true;
  String sms;
  String VerificationId;

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
    setState(() {
      back = background();
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Welcome()
        : Stack(
            children: <Widget>[
              back,
              Scaffold(
                  backgroundColor: Colors.black.withOpacity(0),
                  body: ListView(
                    children: <Widget>[
                      Form(
                        key: key,
                        child:codeSent? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Hero(
                                  tag: "Logo",
                                  child: Image.asset(
                                    "assets/logohowfa.png",
                                    width: 90.0,
                                    height: 90.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  "How",
                                  style: TextStyle(
                                    fontSize: 50.0,
                                    color: Color(0xFFFFFFFFF),
                                  ),
                                ),
                                Text(
                                  "fa",
                                  style: TextStyle(
                                    fontSize: 50.0,
                                    color: HexColor("#CECECE"),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Have an account?  ",
                                  style: TextStyle(
                                      color: Color(0xFFFFFFFFF),
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
//                                GestureDetector(
//                                  child: Text(
//                                    "Login",
//                                    style: TextStyle(
//                                        color: Colors.red,
//                                        fontSize: 30.0,
//                                        decoration: TextDecoration.underline,
//                                        fontWeight: FontWeight.bold),
//                                  ),
//                                  onTap: () {
//                                    Navigator.push(context,
//                                        MaterialPageRoute(builder: (context) {
//                                      return Login();
//                                    }));
//                                  },
//                                )
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Material(
                              elevation: 8.0,
                              shadowColor: Colors.black,
                              borderRadius: BorderRadius.circular(20.0),
                              child: Container(
                                  padding: EdgeInsets.only(left: 10.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: HexColor("#FFFFFF")),
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: TextFormField(
                                    controller: first,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "First Name",
                                      errorStyle: TextStyle(fontSize: 20.0),
                                      hintStyle: TextStyle(
                                          fontSize: 25.0,
                                          color: HexColor("#CECECE")),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Material(
                              elevation: 8.0,
                              shadowColor: Colors.black,
                              borderRadius: BorderRadius.circular(20.0),
                              child: Container(
                                  padding: EdgeInsets.only(left: 10.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: HexColor("#FFFFFF")),
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: TextFormField(
                                    controller: second,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Second Name",
                                      errorStyle: TextStyle(fontSize: 20.0),
                                      prefixIcon: Icon(
                                        Icons.person_outline,
                                        size: 30.0,
                                        color: Colors.grey,
                                      ),
                                      hintStyle: TextStyle(
                                          fontSize: 25.0,
                                          color: HexColor("#CECECE")),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Material(
                              elevation: 8.0,
                              shadowColor: Colors.black,
                              borderRadius: BorderRadius.circular(20.0),
                              child: Container(
                                  padding: EdgeInsets.only(left: 10.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: HexColor("#FFFFFF")),
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: TextFormField(
                                    controller: third,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "when is your Birthday",
                                      errorStyle: TextStyle(fontSize: 20.0),
                                      hintStyle: TextStyle(
                                          fontSize: 25.0,
                                          color: HexColor("#CECECE")),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Material(
                              elevation: 8.0,
                              shadowColor: Colors.black,
                              borderRadius: BorderRadius.circular(20.0),
                              child: Container(
                                  padding: EdgeInsets.only(left: 10.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: HexColor("#FFFFFF")),
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: TextFormField(
                                    controller: fouth,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "User Name",
                                      errorStyle: TextStyle(fontSize: 20.0),
                                      hintStyle: TextStyle(
                                          fontSize: 25.0,
                                          color: HexColor("#CECECE")),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Material(
                              elevation: 8.0,
                              shadowColor: Colors.black,
                              borderRadius: BorderRadius.circular(20.0),
                              child: Container(
                                  padding: EdgeInsets.only(left: 10.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: HexColor("#FFFFFF")),
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: TextFormField(
                                    controller: fifth,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      errorStyle: TextStyle(fontSize: 20.0),
                                      hintStyle: TextStyle(
                                          fontSize: 25.0,
                                          color: HexColor("#CECECE")),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Material(
                              elevation: 8.0,
                              shadowColor: Colors.black,
                              borderRadius: BorderRadius.circular(20.0),
                              child: Container(
                                  padding: EdgeInsets.only(left: 10.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: HexColor("#FFFFFF")),
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: TextFormField(
                                    controller: sixth,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Email",
                                      errorStyle: TextStyle(fontSize: 20.0),
                                      hintStyle: TextStyle(
                                          fontSize: 25.0,
                                          color: HexColor("#CECECE")),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Material(
                              elevation: 8.0,
                              shadowColor: Colors.black,
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: HexColor("#616161")),
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: RaisedButton(
                                    child: Text(
                                      "Verify",
                                      style: TextStyle(
                                        color: HexColor("#FFFFFF"),
                                        fontSize: 35.0,
                                      ),
                                    ),
                                    onPressed: () async {
//                                      setState(() {
//                                        loading=!loading;
//                                      });
//                                     var res=await http.post("http://10.0.2.2/new folder/try.php",body: {"name":first.text});
//                                     print(res.body.runtimeType);
//                                      print(jsonDecode(res.body).runtimeType);
//
//
//                                    Map map=jsonDecode(res.body);
//                                    print(map["ha"][0]['habeeb']);

                                    await verify();
                                    print("click");


//                                      print(login);
//                                      Navigator.push(context,
//                                          MaterialPageRoute(builder: (context) {
//                                        return home(login);
//                                      }));

//                                if(login == null){
//                                  setState(() {
//                                    error=login.toString();
//                                    loading = false;
//
//                                  });
//                                }
//                                else if(login==FirebaseUser){
//                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
//                                    return home();
//                                  }));
//                                }

//                                  FirebaseUser user= await logic.getUser();
//                                  Message mgs=Message.text(user.uid,user2.uid,controller.text,"text",FieldValue.serverTimestamp())
//                                    logic.sendMgs(user, user2, mgs);
                                    },
                                    color: HexColor("#616161"),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                  )),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              error,
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.red,
                              ),
                            )
                          ],
                        ):Center(
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 20.0,
                              ),
                              Material(
                                elevation: 8.0,
                                shadowColor: Colors.black,
                                borderRadius: BorderRadius.circular(20.0),
                                child: Container(
                                    padding: EdgeInsets.only(left: 10.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        color: HexColor("#FFFFFF")),
                                    width:
                                    MediaQuery.of(context).size.width * 0.8,
                                    child: TextFormField(
                                      controller: sixth,
                                      onChanged: (val){
                                        sms=val;
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Enter OTP",
                                        errorStyle: TextStyle(fontSize: 20.0),
                                        hintStyle: TextStyle(
                                            fontSize: 25.0,
                                            color: HexColor("#CECECE")),
                                      ),
                                    )),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Material(
                                elevation: 8.0,
                                shadowColor: Colors.black,
                                borderRadius: BorderRadius.circular(10.0),
                                child: Container(
                                    height:
                                    MediaQuery.of(context).size.height * 0.08,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        color: HexColor("#616161")),
                                    width:
                                    MediaQuery.of(context).size.width * 0.8,
                                    child: RaisedButton(
                                      child: Text(
                                        "Register",
                                        style: TextStyle(
                                          color: HexColor("#FFFFFF"),
                                          fontSize: 35.0,
                                        ),
                                      ),
                                      onPressed: () async {
                                        setState(() {
                                          loading=!loading;
                                        });
                                       var user= await logic.SignInWithOTP(sms, VerificationId);
                                       setState(() {
                                         loading=!loading;
                                       });
                                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                                          return Login(user);
                                        }));

                                      },
                                      color: HexColor("#616161"),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10.0)),
                                    )),
                              ),
                            ],
                          ),
                        )
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                    ],
                  )),
            ],
          );
  }
  verify()async{
    PhoneVerificationCompleted verified = (AuthCredential authresult) async {
      setState(() {
        loading=!loading;
      });

      AuthResult user=await FirebaseAuth.instance.signInWithCredential(authresult);


     FirebaseUser result=user.user;
      setState(() {
        loading=!loading;
      });

////        FirebaseUser user = await getUser();
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Login(result);
        }));

    };
    PhoneVerificationFailed verificationFailed = (
        AuthException authresult) {
      print("${authresult.message}");
    };
    PhoneCodeSent smsSent = (verId, [int forceResent]) {

      setState(() {
        //loading = !loading;
        VerificationId = verId;
        codeSent=false;
       // loading=!loading;
      });
    };
    PhoneCodeAutoRetrievalTimeout autoTimeout = (verId,) {
      setState(() {
        VerificationId = verId;
      });

    };
   await FirebaseAuth.instance.verifyPhoneNumber(phoneNumber: first.text,
        timeout: Duration(seconds: 60),
        verificationCompleted: verified,
        verificationFailed: verificationFailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}
