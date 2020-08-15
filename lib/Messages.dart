
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Message{
  String SenderId;
  String ReceiverId;
  String Type;
  String message;
  String name;
  Timestamp timestamp;
  String url;

  Message.text({this.SenderId,this.ReceiverId,this.name,this.message,this.Type, this.timestamp});
  Message.media({this.SenderId,this.ReceiverId,this.name,this.message,this.Type,this.timestamp,this.url});

  Map tomap(){
    Map<String,dynamic>map={"SenderId":this.SenderId,"ReceiverId":this.ReceiverId,"Name":this.name,"Message":this.message,"Type":this.Type};
//    map['SenderId'] = this.SenderId;
//    map['ReceiverId'] = this.ReceiverId;
//    map['Message'] = this.message;
//    map['Type'] = this.Type;

    return map;

  }
  Message.fromMap(Map<String,dynamic> data){
     this.SenderId = data["SenderId"] ;
     this.ReceiverId = data["ReceverId"];
    this.message = data["Message"];
     this.Type = data["Type"];
     this.timestamp=data["Timestamp"];
     this.name=data["Name"];
  }
}