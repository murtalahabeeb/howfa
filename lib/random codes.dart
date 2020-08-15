import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


//QuerySnapshot search=await logic.Search(//this wont be part :await logic.getUser());
//                                   List<DocumentSnapshot> list=search.documents;
//                                   List<Map>sugest=list==null?[]: list.where((DocumentSnapshot snap){
//                                     return snap.data["uid"].toString().contains("query")||snap.data[""name"].toString().contains(query)&&
//                                     snap.data[""name"].toString().!contains(user.uid)&&snap.data[""name"].toString().!contains(user.name);
//                                    }).toList();  the return a list builder JUST IN CASE




//List<Users>userList=await logic.Search(await logic.getUser());
//                               List<Users> searchedmatch=userList==null?[]:userList.where((Users users){
//                                 return users.name.contains("query");
//                                }).toList(); then return a listview builder