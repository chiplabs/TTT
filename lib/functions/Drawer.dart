import 'package:flutter/material.dart';
import 'package:studentapp/authentication/signinpage.dart';
import 'package:studentapp/pages/homepage.dart';
import 'package:studentapp/pages/settings.dart';
import 'package:studentapp/readonly%20widgets/helpingcenter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: must_be_immutable
class Drawerinfo extends Signin{
  StatefulBuilder Drawerside(){
  return StatefulBuilder(
        builder:(BuildContext context, StateSetter setState){
        gotosettings(){
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Settings(email: email,),
              ));
        }
          return  Drawer(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://p0.pikrepo.com/preview/819/754/elementary-school-in-kaposvar-hungary.jpg'),fit: BoxFit.fitHeight,
                    colorFilter:ColorFilter.mode(Colors.black.withOpacity(0.2),BlendMode.dstATop),
                  )
                ),
                child: new ListView(

                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      decoration: BoxDecoration()
                      ,accountName:Text(username.substring(0,1).toUpperCase()+username.substring(1),style: TextStyle(color: Colors.black,fontFamily:"Patua_One"),)
                      , accountEmail: Text((email.substring(0,1).toUpperCase()+email.substring(1)),style: TextStyle(color: Colors.black,fontFamily:"Patua_One"),),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Color.fromRGBO(230, 238, 248, 1),
                      child:Text(username.substring(0,2).toUpperCase(),
                        style: TextStyle(fontFamily:'Russo_One',fontSize: 25.0,color: Colors.black),) ,




                    ),
                     onDetailsPressed:gotosettings
                    ),

                    new ListTile(
                      onTap: () {
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Homefun()));
                      },
                      leading: new Icon(Icons.person),
                      title: new Text("Home", style: new TextStyle(fontSize: 15.0)),
                    ),
                    new ListTile(
                      leading: new Icon(Icons.inbox),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          new Text("inbox", style: new TextStyle(fontSize: 15.0)),
                          Row(children: [
                            Text('Coming Soon ',style: TextStyle(fontFamily: "Indie_Flower",fontSize: 14.0),),
                            Icon(Icons.miscellaneous_services,color: Colors.green,size: 14.0,),
                          ],)
                        ],
                      ),
                    ),
                    new ListTile(
                      leading: new Icon(Icons.edit),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          new Text("practice exam ",
                              style: new TextStyle(fontSize: 15.0)),
                          Row(children: [
                            Text('Coming Soon ',style: TextStyle(fontFamily: "Indie_Flower",fontSize: 14.0),),
                            Icon(Icons.miscellaneous_services,color: Colors.green,size: 14.0,),
                          ],)
                        ],
                      ),
                    ),
                    new ListTile(
                      leading: new Icon(Icons.book),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          new Text("Your whole lessons ",
                              style: new TextStyle(fontSize: 15.0)),
                          Row(children: [
                            Text('Coming Soon ',style: TextStyle(fontFamily: "Indie_Flower",fontSize: 14.0),),
                            Icon(Icons.miscellaneous_services,color: Colors.green,size: 14.0,),
                          ],)
                        ],
                      ),
                    ),
                    new ListTile(
                      onTap: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Settings(email: email,),
                              ));
                        });
                      },
                      leading: new Icon(Icons.settings),
                      title: new Text("Settings",
                          style: new TextStyle(fontSize: 15.0)),
                    ),

                    new ListTile(
                      onTap: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Help(),
                              ));});},
                      leading: new Icon(Icons.help),
                      title: new Text("Help Center ?",
                          style: new TextStyle(fontSize: 15.0)),),
                    new ListTile(
                      onTap: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Signin(),
                              ));});},
                      leading: new Icon(Icons.logout),
                      title: new Text("Sign out",
                          style: new TextStyle(fontSize: 15.0)),),
                  ],shrinkWrap: true

                  ,),
              ));});}}