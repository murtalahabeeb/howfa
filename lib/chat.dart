import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:howfa/Messages.dart';
import 'package:howfa/firebaseMethods.dart';
import 'package:howfa/user.dart';
import 'package:provider/provider.dart';

class Chatpage extends StatefulWidget {
  Users Receiver;

  Chatpage(
    this.Receiver,
  );

  @override
  _ChatpageState createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  Auth logic = Auth();
  bool done = false;
  FirebaseUser Mainuser;
  Message message;
  String messages;
  String r;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logic.getUser().then((user) {
      //print(doc.data);
      setState(() {
        Mainuser = user;
        done = true;
      });
      // print(Receiver.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    Mainuser = Provider.of<FirebaseUser>(context);
    return Scaffold(
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 50.0,
            ),
            Text("unique id is ${widget.Receiver.uid}"),
            SizedBox(height: 20.0,),
            StreamBuilder(
                stream: Firestore.instance
                    .collection("messages")
                    .document(Mainuser.uid)
                    .collection(widget.Receiver.uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return new Text('Loading...');
                    case ConnectionState.none:
                      return new Text('no connection');
                    default:
                      return Expanded(
                        child: ListView.builder(
                            reverse: true,
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              message = Message.fromMap(
                                  snapshot.data.documents[index].data);

                              return Container(
                                child: Text("${message.message}"),
                              );
                            }),
                      );
                  }
                }),
            Row(
              children: <Widget>[
                Expanded(
                    child: TextFormField(
                      controller: controller,
                    )),
                Material(
                  child: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () async {
                        var text = controller.text;
                        var mgs = Message.text(
                          SenderId: Mainuser.uid,
                          ReceiverId: widget.Receiver.uid,
                          name: widget.Receiver.name,
                          message: text,
                          Type: "text",
                          timestamp: Timestamp.now(),
                        );

                        logic.sendMgs(Mainuser, widget.Receiver, mgs);

                        Firestore.instance
                            .collection("messagelist")
                            .document(Mainuser.uid)
                            .collection("list")
                            .document(widget.Receiver.uid)
                            .setData({
                          "SenderId": mgs.SenderId,
                          "ReceverId": mgs.ReceiverId,
                          "Name": mgs.name,
                          "Message": mgs.message,
                          "Timestamp": mgs.timestamp,
                        });
                        await Firestore.instance
                            .collection("messagelist")
                            .document(widget.Receiver.uid)
                            .collection("list")
                            .document(Mainuser.uid)
                            .setData({
                          "SenderId": mgs.ReceiverId,
                          "ReceverId": mgs.SenderId,
                          "Name": mgs.name,
                          "message": mgs.message,
                          "timestamp": mgs.timestamp
                        });
                      }),
                )
              ],
            )
          ],
        ));
  }
  }
