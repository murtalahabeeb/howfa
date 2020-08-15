import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:howfa/Messages.dart';
import 'package:howfa/changenotifiers.dart';
import 'package:howfa/search.dart';
import 'package:howfa/user.dart';
import 'dart:math';
import 'package:permission_handler/permission_handler.dart';

import 'chat.dart';
import 'firebaseMethods.dart';
import 'friends.dart';
import 'package:provider/provider.dart';

class home extends StatefulWidget {
  home();

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  Auth logic = Auth();
  FirebaseUser User;
  bool done = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPermission();
    logic.getUser().then((value) {
      setState(() {
        User = value;
        done = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var u = Provider.of<FirebaseUser>(context);
    print(u);

    //ScreenScaler scaler = ScreenScaler()..init(context);
    return u != null
        ? MultiProvider(
            providers: [
              StreamProvider(create: (context) {
                return Auth().getusers(u);
              }),
              StreamProvider(create: (context) {
                return Auth().getMessage(u);
              }),
              StreamProvider(create: (context) {
                return Auth().getfriends(u);
              }),
              ChangeNotifierProvider(create: (context) {
                return changes();
              })
            ],
            child: Builder(builder: (context) {
              var c = Provider.of<List<Users>>(context);
              var f = Provider.of<List<Message>>(context);
//          if(c!=null){
//            print(c[0].uid);
//          }else{
//            print(c);
//          }
              if (f != null) {}
              return SafeArea(
                child: Card(
                  elevation: 20.0,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: (BoxDecoration(
                            color: Colors.transparent,
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/backgroundforgold.jpeg"),
                                fit: BoxFit.cover))),
                      ),
                      //Positioned(top: 0,left: 20,child: customAppBar("Chats",Icons.search,Icons.more_vert, () { })),

                      Scaffold(
                        backgroundColor: Colors.transparent,
                        appBar: PreferredSize(
                          preferredSize: Size.fromHeight(20.0),
                          child: AppBar(
                            centerTitle: true,
                            title: Container(
                              //padding:EdgeInsets.all(50.0),
                              width: 100.0,
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(90.0),
                                      bottomLeft: Radius.circular(90.0)),

                                ),
                                child: Center(child: Text("Chats"))),
                            backgroundColor: Colors.transparent,
                            elevation: 0.0,
                            leading: IconButton(
                                icon: Icon(Icons.search),
                                color: Colors.black,
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
//                        print(c[0].uid);
                                    return Search(u);
                                  }));
                                }),
                            actions: <Widget>[
                              IconButton(
                                  icon: Icon(Icons.more_vert),
                                  color: Colors.black,
                                  onPressed: () {}),
                            ],
                          ),
                        ),
                        body: Column(
                          children: <Widget>[
                            Expanded(
                                child:
                                    //StreamBuilder(
//                    stream: Firestore.instance
//              .collection("messagelist")
//              .document(u.uid)
//              .collection("list")
//              .snapshots(),
//                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                      if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
//                      switch (snapshot.connectionState) {
//                        case ConnectionState.waiting:
//                          return new Text('Loading...');
//                        case ConnectionState.none:
//                          return new Text('no connection');
//                        default:
                                    f != null
                                        ? ListView.builder(
                                            itemCount: f.length,
                                            itemBuilder: (context, index) {
                                              // Message mgs=Message.fromMap(snapshot.data.documents[index].data);
//                Firestore.instance.collection("users").document(mgs.ReceiverId).get();
//                Users user=Users.secondConstructor(snapshot.data.documents[index].data)

                                              return contactView(f[index]);
//                                GestureDetector(
//                                onTap: (){
//                                  print(f[index].ReceiverId);
//                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
//                                    return Chatpage(f[index].ReceiverId);
//                                  }));
//                                },
//                                child: ListTile(
//                                  leading: CircleAvatar(
//                                    backgroundColor: Colors.transparent,
//                                    backgroundImage: NetworkImage("http://i.pravatar.cc/300"),
//                                  ),
//                                  title:Text("${f[index].ReceiverId}"),
//                                  subtitle:Text("${f[index].message}") ,
//                                  trailing: Container(
//                                    width: 200.0,
//                                    child: Column(
//                                      children: <Widget>[
//                                        Text("Read"),
//                                        Text("${f[index].timestamp.seconds}")
//                                      ],
//                                    ),
//                                  ),
//                                ),
//                              );
                                            },
                                          )
                                        : Container()
//                      }
//                    },
//                  )

                                ),
                          ],
                        ),
                      ),
                      Positioned(child: contactNav(), top: 25)
                    ],
                  ),
                ),
              );
            }),
          )
        : SpinKitChasingDots(
            color: Colors.green,
          );
  }

  Future<PermissionStatus> _getPermission() async {
    final PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.contacts);
    if (permission != PermissionStatus.granted) {
      final Map<PermissionGroup, PermissionStatus> permissionStatus =
          await PermissionHandler()
              .requestPermissions([PermissionGroup.contacts]);
      return permissionStatus[PermissionGroup.contacts] ??
          PermissionStatus.unknown;
    } else {
      return permission;
    }
  }
}

class contactView extends StatelessWidget {
  Message mgs;
  Auth logic = Auth();

  contactView(this.mgs);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: logic.userdetails(mgs.ReceiverId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Users user = snapshot.data;
            return messageLayout(user, mgs);
          } else {
            return Container(
                child: SpinKitChasingDots(
              color: Colors.green,
            ));
          }
        });
  }
}

class messageLayout extends StatelessWidget {
  Users user;
  Message f;

  messageLayout(this.user, this.f);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(f.ReceiverId);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Chatpage(user);
        }));
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage("http://i.pravatar.cc/300"),
        ),
        title: Text("${user.Displayname}"),
        subtitle: Text("${f.message}"),
        trailing: Container(
          width: 200.0,
          child: Column(
            children: <Widget>[
              Text("Read"),
//              Text("${f.timestamp.seconds}")
            ],
          ),
        ),
      ),
    );
  }
}

class contactNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 1,
      child: Container(
          padding: EdgeInsets.all(5.0),
          height: 20.0,
          width: 150.0,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(90.0),
                topLeft: Radius.circular(90.0)),
          ),
          child: Center(
              child: Text(
            "My contacts",
            style: TextStyle(
              fontSize: 10.0,
              color: Colors.white,
            ),
          ))),
    );
  }
}

class customAppBar extends StatelessWidget {
  VoidCallback onpressed;
  String title;
  IconData first_icon;
  IconData second_icon;

  customAppBar(this.title, this.first_icon, this.second_icon, this.onpressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
              icon: Icon(
                first_icon,
                color: Colors.grey,
              ),
              onPressed: () => onpressed),
          Text(
            title,
            style: TextStyle(color: Colors.grey, fontSize: 25.0),
          ),
          IconButton(
              icon: Icon(
                second_icon,
                color: Colors.grey,
              ),
              onPressed: () => onpressed)
        ],
      ),
    );
  }
}
