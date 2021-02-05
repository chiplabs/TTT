import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studentapp/authentication/signinpage.dart';
class Settings extends StatefulWidget {
  String email;

  Settings({this.email});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  String name;
  String password;
  String picture;
  String dateofbirth;
  String grade;
  String phone;
  bool editopen1=false;
  bool editopen3=false;
  bool editopen4=false;
  bool editopen6=false;
  bool checkchange=false;
  final nameController =TextEditingController();
  final passwordController =TextEditingController();
  final gradeController =TextEditingController();
  final emailController =TextEditingController();
  final dobController =TextEditingController();
  final phoneController =TextEditingController();
  TextFormField emailfun(String text) {
    return TextFormField(
      readOnly: true,
      enabled:  false,
      controller:emailController..text=text,
    );
  }
  TextFormField gradefun(String text) {
    return TextFormField(
      readOnly: true,
      enabled: false,
      controller:gradeController..text=text,
    );
  }
  TextFormField namefun(String text) {
    return TextFormField(
      readOnly: editopen1==false?true:false,
      enabled:  editopen1==false?false:true,
      controller:nameController..text=text,
      onChanged: (value){
        name=value;
        value=nameController.text;

      },   onEditingComplete:(){
      setState(() {
        text=Firestore.instance.collection(email).document('Username').updateData({"Username": name}).toString();
        name=text;
        editopen1=false;
      });},
      validator: (value)=>value.isEmpty?'this field cannot be blank !':null,
    );
  }
  TextFormField passwordfun(String text) {
    return TextFormField(
      readOnly: editopen3==false?true:false,
      enabled:  editopen3==false?false:true,
      controller:passwordController..text=text,
      obscureText:true,
      onChanged: (value){
        password=value;
        value=passwordController.text;
        },onEditingComplete:() async {
      final form = formKey.currentState;

      if (form.validate()) {
        text=password;
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      user.updatePassword(password).then((_){
        text=Firestore.instance.collection(email).document('password').updateData({"password": password}).toString();
         setState(() {checkchange=true;});}).catchError((error){
      });
      password=text;
      editopen3=false;
      }},
      validator: (value)=>validatepw(value)
    );
  }
  String validatepw(String value) {
    Pattern pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value))
        return ''
            'at least 8 characters\n at least one uppercase letter \n at least one lowercase letter \n at least one special character';
      else
        return null;
    }
 }
  TextFormField phonefun(String text) {
    return TextFormField(
      readOnly: editopen4==false?true:false,
      enabled:  editopen4==false?false:true,
      controller:phoneController..text=text,
      onChanged: (value){
        phone=value;
        value=phoneController.text;

      },   onEditingComplete:(){
       setState(() {
         final form = formKey.currentState;

         if (form.validate()) {
           text=Firestore.instance.collection(email).document('phone').updateData({"phone": phone}).toString();
           phone=text;
           editopen4=false;
         }

       });},
      validator: validateMobile,
    );
  }
  String validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length != 11)
      return 'Mobile Number must be of 10 digit';
    else {
      if (value.substring(0,2) != '01') {
        return 'Mobile must start with 01';
      }
      else
        return null;
    }}
  TextFormField dobfun(String text) {
    return TextFormField(
      readOnly: true,
      enabled:  false,
      controller:dobController..text=text,

    );
  }
  Widget build(BuildContext context) {
    IconButton editname(){
      return IconButton(icon: Icon(Icons.lock_open), onPressed:(){
        editopen1=true;
        setState(() {
          editopen1=true;
        });
      });
    }
    IconButton editpassword(){
      return IconButton(icon: Icon(Icons.lock_open), onPressed:(){
        editopen3=true;
        setState(() {
          editopen3=true;
        });
      });
    }
    IconButton editphone(){
      return IconButton(icon: Icon(Icons.lock_open), onPressed:(){
        editopen4=true;
        setState(() {
          editopen4=true;
          phoneController.clear();
          phone='';
        });
      });
    }
    return Form(
      key: formKey,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(title: Text('Your basic information'),
            backgroundColor: Color.fromRGBO(64, 64, 96, 1.0),),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image:  AssetImage("assets/images/2.jpg"),fit: BoxFit.cover,
                colorFilter:ColorFilter.mode(Colors.black.withOpacity(0.1),BlendMode.dstATop),
              ),
            ),
            child: Row(children: [
                StreamBuilder(
                    stream: Firestore.instance.collection(email).snapshots(),
                    builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                      if(!snapshot.hasData){
                        return Text('Loading ...',style: TextStyle(fontFamily: 'Russo_One'),);
                      }
                      else{
                         return Container(
                           padding: EdgeInsets.only(left:10.0,right: 20.0,bottom: 80.0),
                           width:MediaQuery.of(context).size.width,
                           height: MediaQuery.of(context).size.height,
                           child: Column (
                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                             children: [
                             Row(
                                children: [
                                  Expanded(child: Text("Name :",style: TextStyle(fontFamily: 'Russo_One'),)),
                                  Expanded(child: namefun(snapshot.data.documents[3]['Username'].toString())),
                                  editname(),],),
                               Column(
                                 children: [
                                   Row(children: [
                                     Expanded(child: Text ("password  :",style: TextStyle(fontFamily: 'Russo_One'),)),
                                     Expanded(child: passwordfun(snapshot.data.documents[5]['password'].toString())),
                                     editpassword(),

                                   ],),
                                   checkchange==true?Text('Succesfull changed password',style: TextStyle(fontFamily: 'Russo_One'),):Text(''),
                                 ],
                               ),

                               Row(children: [
                                 Expanded(child: Text ("Phone number :",style: TextStyle(fontFamily: 'Russo_One'),)),
                                 Expanded(child: phonefun(snapshot.data.documents[6]['phone'].toString())),
                                 editphone(),
                               ],),
                                Row(children: [
                                Expanded(child: Text ("Email :",style: TextStyle(fontFamily: 'Russo_One'),)),
                                Expanded(child: emailfun (snapshot.data.documents[1]['Email'].toString())),
                                  Icon(Icons.lock),
                                ],),

                               Row(children: [

                                 Expanded(child: Text ("Birthdate :",style: TextStyle(fontFamily: 'Russo_One'),)),
                                 Expanded(child: dobfun(snapshot.data.documents[0]['Birthdate'].toString())),
                                 Icon(Icons.lock),
                               ],),


                            Row(children: [
                            Expanded(child: Text ("Grade :",style: TextStyle(fontFamily: 'Russo_One'),)),
                            Expanded(child: gradefun(snapshot.data.documents[4]['Grade'].toString())),
                              Icon(Icons.lock),
                            ],),],),);}})],),),),),);}}
