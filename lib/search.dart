import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:howfa/firebaseMethods.dart';
import 'package:howfa/user.dart';

class Search extends StatefulWidget {
  FirebaseUser user;

  Search(this.user);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Auth logic = Auth();
  bool done = false;
  String query = "";
  List<Users> userlist;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logic.Search(widget.user).then((list) {
      setState(() {
        print('done');
        done = true;
        userlist = list;
      });
    });
  }

  Widget show() {
    List<Users> sugest = userlist.where((users) {
      return (users.uid.contains(query) || users.name.contains(query));
    }).toList();
    if (query.isEmpty) {
      return Text("enter a name");
    } else if (sugest.isEmpty) {
      return Text("no matched user");
    } else {
      return ListView.builder(
          itemCount: sugest.length,
          itemBuilder: (context, index) {
            return ListTile(
                title: Text(sugest[index].name),
                subtitle: Text(sugest[index].uid),
                trailing: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () async{
                      await Firestore.instance
                          .collection("Friendlist")
                          .document(widget.user.uid)
                          .collection("friends")
                          .document(sugest[index].uid)
                          .setData({
                        "name": sugest[index].name,
                        "uid": sugest[index].uid
                      });
                    }));
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        SizedBox(
          height: 50.0,
        ),
        TextField(
          onChanged: (val) {
            setState(() {
              query = val;
            });
          },
        ),
        done ? Expanded(child: show()) : Text("loading")
      ],
    ));
  }
}
