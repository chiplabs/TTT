import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studentapp/pages/homepage.dart';
import 'package:studentapp/functions/spinkit.dart';
import 'auth.dart';
String email;
String username;
String grade;
class Signin extends StatefulWidget {
  _SigninState createState() => _SigninState();
}
// ignore: camel_case_types
class _SigninState extends State<Signin> {
bool hide=true;
  bool loading=false;
  String password='';
  String error='';
  TextStyle style = TextStyle(fontFamily: 'Russo_One', fontSize: 20.0);
final fs=Firestore.instance;
final authservice _auth=authservice();
final _formkey=GlobalKey<FormState>();

  Widget build(BuildContext context) {
final showpw=IconButton(icon: Icon(Icons.remove_red_eye), onPressed:(){setState(() {hide=!hide;});});
    final emailField = TextFormField(
      validator:(val)=>val.isEmpty ? 'enter your email !':null,
      onChanged: (val){
        setState(() =>email=val);
      },
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordField = TextFormField(
      obscureText: hide==true?true:false,
      validator:(val)=>val.length<8 ? 'enter Strong password':null,
      onChanged: (val){
        setState(() => password=val);
      },
      style: style,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key_sharp),
          suffixIcon:showpw,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(50.0),
      color: Color.fromRGBO(64, 64, 96, 1.0),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: ()async {
          if(_formkey.currentState.validate()){
            setState(()=>loading=true);
         dynamic result=await _auth.signinwithemailandpassword(email.toLowerCase(), password);
            if(result==null){
              setState(()=>error="couldn't Sign in");
              loading=false;
            }
            else{
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Homefun()));
              Firestore.instance.collection(email).document("Username").get().
              then((value) => { username= value['Username']});
              Firestore.instance.collection(email).document("grade").get().
              then((value) => { grade= value['Grade']});
            }}},
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
    return loading?Loading():
    Theme(data: testtheme,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: new AppBar(
          primary: true,
          leading:new Icon(Icons.assignment_ind),
          centerTitle: true,
          title :new Text("Edu Learn App"),
          backgroundColor: Color.fromRGBO(64 , 64, 96, 1.0),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.only(bottom: 45.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://www.pngkey.com/png/full/857-8572216_halton-catholic-district-school-board-student-building-school.png'),
                fit: BoxFit.cover,
                 colorFilter:ColorFilter.mode(Colors.black.withOpacity(0.1),BlendMode.dstATop),
            ),),
            //color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                   child: Text("Sign in  to your account",style: TextStyle(fontSize:30.0,fontFamily:'Patua_One')),
                    ),
                    SizedBox(height: 45.0),
                    emailField,
                    SizedBox(height: 25.0),
                    passwordField,
                    SizedBox(
                      height: 35.0,
                    ),
                    loginButon,
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(error),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }}
