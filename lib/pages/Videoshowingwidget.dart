import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studentapp/authentication/signinpage.dart';
import 'package:studentapp/functions/chewievideoview.dart';
import 'package:studentapp/pages/Evaluatingquiz.dart';
import 'package:studentapp/teststudent.dart';
import 'package:video_player/video_player.dart';

import 'homepage.dart';
// ignore: must_be_immutable
class Showlesson extends StatefulWidget {
  String code;
  Showlesson({this.code});
  @override
  _ShowlessonState createState() => _ShowlessonState();
}

class _ShowlessonState extends State<Showlesson> {
String url='';
  showalerdialog1(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text('Are you sure ?'),
      content:
      Text('are you sure that you want to go to the final assesment ?'),
      actions: [
        FlatButton(
          child: (Text('Let\'s go ')),
          onPressed: () {
            setState(() {
              Navigator.of(context).pop();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>Evaluation(code: widget.code)));
            });
          },
        ),
        FlatButton(
          child: Text('Cancel'),
          onPressed: () {
            setState(() {
              Navigator.of(context).pop();
            });
          },
        ),
      ],
    ); // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  Widget build(BuildContext context) {

    return  Theme(
      data: testtheme,
      child: Scaffold(
        appBar: AppBar(
          title: Text('YOUR LESSON'),
          actions: [
            FlatButton(onPressed:(){setState(() {
              Firestore.instance.collection('streamvideo').document(globallevel).collection("grade").document(widget.code).collection('today').document('intoduction').get().
              then((value) => { url= value[widget.code],});
            });},
              child: Row(children: [
                Text('Start the video',style: TextStyle(color: Colors.black),),
                Icon(Icons.play_arrow,color: Colors.black,),
              ],),
            )
          ],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/2.jpg"),fit: BoxFit.cover,
                   colorFilter:ColorFilter.mode(Colors.black.withOpacity(0.1),BlendMode.dstATop),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Center(
                child: Column(
                  children: [
                    Text("Based on your answers,this is your lesson Listen carefully",
                      style: new TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold,fontFamily:"UbuntuCondensed"),
                    ),
                    Text("*For best watch .. please Full screen the video*",style: new TextStyle(
                        fontSize: 22.0, fontWeight: FontWeight.bold,fontFamily:"UbuntuCondensed"),)
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(13.0),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height - 400,
                        child:url==''?null:ChewieListItem(
                            videoPlayerController
                            :VideoPlayerController.network(url)),
                      ),
                      RaisedButton(onPressed: (){
                        Firestore.instance.collection(email).document("lessons").updateData(
                            {
                              DateTime.now().toString().substring(10,16):url,
                            }
                        );
                        showalerdialog1(context);
                        },
                        child: Text('Next'),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
