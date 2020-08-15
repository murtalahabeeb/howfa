class UserInfo{
  String uid;
  String Displayname;
  String name;
  String ProfilePic;
  String anon;
  String email;
  String dob;
  String gender;
}


class Users{
  String uid;
  String Displayname;
  String name;
  String ProfilePic;
  String PhoneNo;
  Users(this.uid,this.name);
  Map tomap(){
    Map<String,dynamic>map;
    map["uid"]=this.uid;
    map["name"]=this.name;
    return map;

  }
  Users.secondConstructor(Map data){
    this.uid= data["uid"];
    this.name=data["name"];
    this.PhoneNo=data["PhoneNo"];
  }
  Users.Constructor(Map<String,dynamic> data){
    this.uid= data["ReceverId"];
    this.name=data["name"];
  }
}