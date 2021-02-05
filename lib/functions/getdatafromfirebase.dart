

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 Widget account(String Email){
   var storage = FirebaseStorage.instance;
   return StreamBuilder(
      stream: Firestore.instance.collection("$Email").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
return UserAccountsDrawerHeader(
  accountName:Text(snapshot.data.documents[1]['Username'],style: TextStyle(fontSize: 20.0),),
  accountEmail:Text(snapshot.data.documents[0]['Email'],style: TextStyle(fontSize: 15.0)),
  currentAccountPicture: GestureDetector(
    child: new CircleAvatar(
      backgroundColor: Colors.grey,
      child: Icon(Icons.person, color: Colors.white,),
     //backgroundImage:
    ),),);});}



