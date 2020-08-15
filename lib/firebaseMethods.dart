

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:howfa/Messages.dart';
import 'package:howfa/home.dart';
import 'package:howfa/resgister.dart';
import 'package:howfa/try.dart';
import 'package:provider/provider.dart';
import 'user.dart';

class Auth {
  FirebaseAuth auth = FirebaseAuth.instance;
  Firestore ref = Firestore.instance;

  Future<FirebaseUser> getUser() async {
    return await auth.currentUser();
  }


  Future signin(String email, String password) async {
    String errorMessage;

    try {


      AuthResult result = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      FirebaseUser user=result.user;
      print(user);
      return user;
     // FirebaseUser user = result.user;

      //return user;
    } catch (error) {

      print(error);
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "Your password is wrong.";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "User with this email has been disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "ERROR_NETWORK_REQUEST_FAILED":
          errorMessage = "Check internet connection";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      return errorMessage;
    }
  }

  Future register(
    phone, VerificationId,context
  ) async {
      PhoneVerificationCompleted verified = (AuthCredential authresult) async {
        AuthResult user=await auth.signInWithCredential(authresult);
        FirebaseUser result=user.user;
        await add(result);
        print(result);
//        FirebaseUser user = await getUser();
//        Navigator.push(context, MaterialPageRoute(builder: (context) {
//          return home(result);
//        }));
      };
        PhoneVerificationFailed verificationFailed = (
            AuthException authresult) {
          String errorMessage;
          switch (authresult.code) {
            case "ERROR_INVALID_EMAIL":
              errorMessage = "Your email address appears to be malformed.";
              break;
            case "ERROR_WRONG_PASSWORD":
              errorMessage = "Your password is wrong.";
              break;
            case "ERROR_USER_NOT_FOUND":
              errorMessage = "User with this email doesn't exist.";
              break;
            case "ERROR_USER_DISABLED":
              errorMessage = "User with this email has been disabled.";
              break;
            case "ERROR_TOO_MANY_REQUESTS":
              errorMessage = "Too many requests. Try again later.";
              break;
            case "ERROR_NETWORK_REQUEST_FAILED":
              errorMessage = "Check internet connection";
              break;
            case "ERROR_OPERATION_NOT_ALLOWED":
              errorMessage = "Signing in with Email and Password is not enabled.";
              break;
            default:
              errorMessage = "An undefined Error happened.";
          }
          return errorMessage;
          print("${authresult.message}");
        };
        PhoneCodeSent smsSent = (verId, [int forceResent]) {
          VerificationId = verId;
          return VerificationId;
        };
        PhoneCodeAutoRetrievalTimeout autoTimeout = (verId,) {
          VerificationId = verId;
        };
       return await auth.verifyPhoneNumber(phoneNumber: phone,
            timeout: Duration(seconds: 60),
            verificationCompleted: verified,
            verificationFailed: verificationFailed,
            codeSent: smsSent,
            codeAutoRetrievalTimeout: autoTimeout);

  }
  SignInWithOTP(sms,verId)async{
  AuthCredential authCredential=PhoneAuthProvider.getCredential(verificationId: verId, smsCode:sms);

   var result=await auth.signInWithCredential(authCredential);
   var user=result.user;
  await add(user);
   return user;
  }

  Future add(FirebaseUser user,) async {
    await ref.collection("users").document(user.uid).setData(
        {"uid": user.uid, "PhoneNo":user.phoneNumber,});
  }
  Future<DocumentSnapshot> getReceiver(String uid){
   return Firestore.instance.collection("users").document(uid).get();
  }

   Stream<List<Users>>getusers(user) {
    //i might just change it to the way it was and leave used the previous search function for the search functionality
    return ref.collection("users").snapshots()
        .map((event) => event.documents
        .map((e){
      if (e.documentID != user.uid) {
       return Users.secondConstructor(e.data);
      }
      else{
        return null;
      }

        }).toList());
  }
 Stream<List<Message>>getMessage(User){
        return Firestore.instance
            .collection("messagelist")
            .document(User.uid)
            .collection("list")
            .snapshots().map((event) =>
            event.documents.map((e) => Message.fromMap(e.data)).toList());




  }
  Stream<List<Users>> getfriends(User){
    if(User!=null){
      return Firestore.instance
          .collection("Friendslist")
          .document(User.uid)
          .collection("friends")
          .snapshots().map((event) =>
          event.documents.map((e) => Users.secondConstructor(e.data)).toList());
    }
  }
  Future<Users> userdetails(id) async{
    try{
      DocumentSnapshot documentSnapshot=await Firestore.instance.collection("friendlist").document(id).get();
      if(!documentSnapshot.exists){
        documentSnapshot=await Firestore.instance.collection("users").document(id).get();
      }
      return Users.secondConstructor(documentSnapshot.data);
    }catch(e){
      print(e);
    }

  }

  Future Search(FirebaseUser user) async {
    try {
      List<Users> userlist = List<Users>();
//    return await ref.collection("users").getDocuments();

      QuerySnapshot snap = await ref.collection("users").getDocuments();
      print(snap.documents);
      for (int i = 0; i < snap.documents.length; i++) {
        if (snap.documents[i].documentID != user.uid) {
          userlist.add(Users.secondConstructor(snap.documents[i].data));
        }
      }
      return userlist;
    } catch (e) {}
  }

  Future sendMgs(FirebaseUser user, Users user2, Message message) async {
    var map = message.tomap();
    await ref
        .collection("messages")
        .document(user.uid)
        .collection(user2.uid)
        .add(map);
    return await ref
        .collection("messages")
        .document(user2.uid)
        .collection(user.uid)
        .add(map);
  }

  Future AnonMgs(FirebaseUser user, FirebaseUser user2, Message message) async {
    await ref
        .collection("Anonymos essages")
        .document(user.uid)
        .collection(user2.uid)
        .add(message.tomap());
    await ref
        .collection("Anonymos messages")
        .document(user2.uid)
        .collection(user.uid)
        .add(message.tomap());
  }
  Wrapper(){
  return  FutureBuilder(
        future:getUser(),
        builder: (context,user){
          if(user.hasData) {
            return explore();

          }else{
            return Register();
          }
    });


  }
//it wont be a function it will be a stream of this
// await ref.collection("messages").document(user.uid).collection(user2.uid).getDocuments();
/* ref.collection("users").snapshots().map((event) {
        event.documents.map((e) {
          userlist.add(Users.secondConstructor(e.data));
        });
      });*/

}
