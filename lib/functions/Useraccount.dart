//import 'package:flutter/material.dart';
//import 'package:studentapp/authentication/signinpage.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//class Useraccount extends Signin{
//
//
//  UAD() async {
//   Signin si=new Signin();
//   Future<String> getname() async {
//     await Firestore.instance.collection("${si.Email}").document('Username').get().then((value){
//       return (value.data.toString().substring(11,(value.data.toString().length-1))).toString();
//     });}
//  return UserAccountsDrawerHeader (
//    //accountEmail:Text(),
//    accountName: Text(await getname()),
//
//
//  );
//
//}
//
//}