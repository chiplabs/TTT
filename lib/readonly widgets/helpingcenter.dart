import 'package:flutter/material.dart';
import 'package:studentapp/functions/Drawer.dart';
class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:Drawerinfo().Drawerside(),
      appBar: AppBar(title: Center(child: Text('Helping Center')),
      backgroundColor: Color.fromRGBO(64 , 64, 96, 1.0),
      ),
      body:Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image:  AssetImage("assets/images/3.jpg"),fit: BoxFit.cover,
            colorFilter:ColorFilter.mode(Colors.black.withOpacity(0.1),BlendMode.dstATop),
          ),
        ),
        padding: const EdgeInsets.only(left:15.0,right: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
             Text("This app is designed for helping student to be examined , getting their lessons at anywhere in the world.",style: new TextStyle(fontSize: 19.0 ,fontWeight: FontWeight.bold,color:Colors.black,fontFamily:"UbuntuCondensed" )),
               Divider(),
                Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  Text('How can i use the app ?',style: new TextStyle(fontSize: 19.0 ,fontWeight: FontWeight.bold,color:Colors.black,fontFamily:"UbuntuCondensed" )),
                  Text('you have to enter your subject code and join your class.',style: new TextStyle(fontSize: 19.0 ,fontWeight: FontWeight.bold,color:Colors.black,fontFamily:"UbuntuCondensed" )),
                ],),
            Divider(),
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(child: Text("what is the system of the app ?",style: new TextStyle(fontSize: 19.0 ,fontWeight: FontWeight.bold,color:Colors.black,fontFamily:"UbuntuCondensed" ))),
            Text("the app is designed with Test Teach Test (TTT) ,which help the students to test themselves ,taking their lessons and being examined in the last of each lesson.",style: new TextStyle(fontSize: 19.0 ,fontWeight: FontWeight.bold,color:Colors.black,fontFamily:"UbuntuCondensed" )),
          ],),
            Divider(),
                Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('what is the duration of each lesson ?',style: new TextStyle(fontSize: 19.0 ,fontWeight: FontWeight.bold,color:Colors.black,fontFamily:"UbuntuCondensed" )),
                  Text(" the session time will be determined by the given teacher , but it will be  almost 50 minutes. ",style: new TextStyle(fontSize: 19.0 ,fontWeight: FontWeight.bold,color:Colors.black,fontFamily:"UbuntuCondensed" )),
                ],),
            Divider(),
                Center(child: Text("For more assistance please contact the school adminstration ",style: new TextStyle(fontSize: 19.0 ,fontWeight: FontWeight.bold,color:Colors.black,fontFamily:"UbuntuCondensed" )))
          ],),),);}}
