import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:howfa/changenotifiers.dart';
import 'package:provider/provider.dart';
import 'extralogic/colorConvert.dart';
import 'package:howfa/firebaseMethods.dart';
import 'package:howfa/home.dart';
import 'package:howfa/resgister.dart';
import 'package:howfa/splash.dart';
import 'package:howfa/user.dart';
import 'package:howfa/welcome.dart';

import 'chat.dart';

class Friends extends StatefulWidget {
  FirebaseUser user;
  Friends(this.user);
  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  Auth logic=Auth();
  bool done=false;
  String query="";
  Iterable<Contact> _contacts;
  List<Users>users;

  @override
  void initState() {
    super.initState();
    Auth().Search(widget.user).then((userlist){

      getContacts().then((doc){


        getUsers(userlist);

      }) ;
    });
  }

  @override
  Widget build(BuildContext context) {


    return
          SafeArea(

                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
                    elevation:20.0 ,
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Container(

                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                          color: Colors.black,
                        ),
                          padding: EdgeInsets.all(10.0),

                            child:
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            IconButton(icon: Icon(Icons.more_vert,color: Colors.grey,), onPressed:(){}),
                                            Text("Contacts",style: TextStyle(color: Colors.grey,fontSize: 25.0),),
                                            IconButton(icon: Icon(Icons.arrow_forward,color: Colors.grey,), onPressed:(){})
                                          ],
                                        ),
                                        RaisedButton(
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                          elevation: 20.0,
                                          onPressed: (){},



                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Icon(Icons.add_circle,color: Colors.white,size: 15.0,),
                                              Text("Add New Contacts",style: TextStyle(fontSize: 20.0,color: Colors.white),)
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: StreamBuilder(
                                              stream: Firestore.instance
                                                  .collection("Friendslist")
                                                  .document(widget.user.uid)
                                                  .collection("friends")
                                                  .snapshots(),
                                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                                if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
                                                switch (snapshot.connectionState) {
                                                  case ConnectionState.waiting:
                                                    return new Text('Loading...');
                                                  case ConnectionState.none:
                                                    return new Text('no connection');
                                                  default:
                                                    return ListView.builder(itemCount: snapshot.data.documents.length,
                                                      shrinkWrap: true,
                                                      physics: NeverScrollableScrollPhysics(),
                                                      itemBuilder: (context,index){
                                                        Users user=Users.secondConstructor(snapshot.data.documents[index].data);
                                                        return GestureDetector(
                                                          onTap: (){
                                                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                              return Chatpage(user);
                                                            }));
                                                          },
                                                          child: ListTile(
                                                              title:Text("${user.name}",style: TextStyle(color: Colors.grey),) ,
                                                              subtitle: Text("${user.uid}",style: TextStyle(color: Colors.grey)),
                                                          ),
                                                        );
                                                      },);
                                                }
                                              },
                                            ),
                                        ),
                                      ],
                                    ),
                        ),
                    ),
                  ),
              );
  }
  Future<void> getContacts() async {
    //Make sure we already have permissions for contacts when we get to this
    //page, so we can just retrieve it
    final Iterable<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts;
    });



  }
  getUsers(List<Users>user)async{

   // var list=_contacts.toList();
    user.forEach((user){
      _contacts.forEach((contact){
        contact.phones.forEach((phone){
          if((user.PhoneNo.contains(phone.value.replaceFirst('0', "+234"))||user.PhoneNo.toString().contains(phone.value))){
            print(phone.value);
            print(contact.displayName);
            print(phone);
            Firestore.instance.collection("Friendslist").document(widget.user.uid).collection("friends").document(user.uid).setData({"name":contact.displayName,
              "uid":user.uid});
          };
        });
      });

    });



    print("doneeee");

  }
}
