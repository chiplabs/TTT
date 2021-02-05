import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studentapp/authentication/signinpage.dart';
import 'dart:async';
class Greeting extends StatefulWidget {

  @override
  _GreetingState createState() => new _GreetingState();
}

class _GreetingState extends State<Greeting> {
  String imageurl='https://www.pngkey.com/png/full/857-8572216_halton-catholic-district-school-board-student-building-school.png';
  @override
  initState() {
    super.initState();
    new Timer(const Duration(seconds: 5), onClose);
  }

  @override
  Widget build(BuildContext context) {
    Firestore.instance.collection('wallpapers').document('greeting').get().then((value) => {imageurl = value['0']});
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageurl),
          fit: BoxFit.cover,
          colorFilter:ColorFilter.mode(Colors.black.withOpacity(0.3),BlendMode.dstATop),
        ),
      ),
    );}

  void onClose() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Signin()));
  }
}