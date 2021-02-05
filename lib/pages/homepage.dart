import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studentapp/readonly widgets//Exception_folder/Exceptioncode.dart';
import 'package:studentapp/functions/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:studentapp/authentication/signinpage.dart';
import 'package:studentapp/teststudent.dart';


var testtheme = new ThemeData(
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.white70, textTheme: ButtonTextTheme.primary,
      // ignore: deprecated_member_use
    ),
    textTheme: TextTheme(
      // ignore: deprecated_member_use
      body1: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17.0,
          fontFamily: "UbuntuCondensed"),
      // ignore: deprecated_member_use
      body2: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
          fontFamily: "UbuntuCondensed"),
    ).apply(
      bodyColor: Colors.black87,
      displayColor: Colors.black87,
    ),
    fontFamily: "LibreBaskerville");

class Homefun extends StatefulWidget {
  @override
  _HomefunState createState() => _HomefunState();
}

class _HomefunState extends State<Homefun> with SingleTickerProviderStateMixin {
 bool check;
 bool error=false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool validateAndSave() {
    final FormState form = _formKey.currentState;
    if(form.validate())
      return true;

    else return false;
  }
  final fs=Firestore.instance;
  final codecontroller = TextEditingController();
  String code='';
  void initState() {
    super.initState();
  }
String imageurl='https://www.pngkey.com/png/full/857-8572216_halton-catholic-district-school-board-student-building-school.png';
  void dispose() {
    super.dispose();
  }
  Future<bool> checkExist(String docID) async {

   try {
    await Firestore.instance.collection(grade).document("$docID").get().then((doc) {

       if (doc.exists)
         Firestore.instance.collection(email).document("Level").collection("code").document(code).setData(
             {"$code" : "Level1",}).then((_){check=true;});
       else
         check=false;
     });
     return check;
   } catch (e) {
     return false;
   }
 }
  Widget build(BuildContext context) {
    fs.collection(email).document('grade').get().then((value) => {grade = value['Grade']});
   void getdata(){
      setState(() {
        //search for code
        Firestore.instance.document("$email/Level/code/$code")
            .get()
            .then((doc) {
          if (doc.exists){
            fs.document("$email/Level/code/$code").get().then((value) => {globallevel = value['$code']});
          check=true;
          }
          else {
            checkExist(code);
            }});});

    }
//    Future<bool> checkavailabledoc() async {
//      var _myDoc = await Firestore.instance.collection(email).document('Level').collection('code').getDocuments();
//      for(int i=0;i<_myDoc.documents.length;i++){
//        if(_myDoc.documents[i].documentID==code){
//          check= true;
//          getdata();
//          break;
//        }
//        else{
//          check =false;
//        }
//
//      }  // Count of Documents in Collection
//      return check;
//    }

    return Form(
      key: _formKey,
      child: Theme(
        data: testtheme,
        child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomPadding: false,
            drawer: Drawerinfo().Drawerside(),
            backgroundColor: Colors.white,
            appBar: new AppBar(
              primary: true,
              //leading:new Icon(Icons.home),
              centerTitle: true,
              title: new Text("Edu Learn App"),
              backgroundColor: Color.fromRGBO(64, 64, 96, 1.0),
            ),
            body: Container(
              padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imageurl),
                    fit: BoxFit.cover,
                    colorFilter:ColorFilter.mode(Colors.black.withOpacity(0.3),BlendMode.dstATop),
                  ),
                ),
                child: Center(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          new Text("Enter Subject Code"),
                          Expanded(
                            child: TextFormField(
                              controller: codecontroller,
                              decoration: InputDecoration(
                                  prefixIcon:Icon(Icons.alternate_email_rounded),
                                  hintText: 'Subject Code'),
                              onChanged: (value) {
                                value=codecontroller.text;
                                code = value;
                              },
                              onEditingComplete:()async{
                                  getdata();
                                  },
                              validator: (value)=>value==''||value==null?'Please enter a right code !':null,
                            ),
                          ),
                        ],
                      ),
                      Column(children: [
                        Text('Steps for Completing Lesson : ',style: TextStyle(fontSize: 20.0),),
                        Text('1- Enter the subject code',style: TextStyle(fontSize: 20.0),),
                        Text('2- answer the entry test',style: TextStyle(fontSize: 20.0),),
                        Text('3- Listen to the lesson',style: TextStyle(fontSize: 20.0),),
                        Text('4- Answer the evaluation test',style: TextStyle(fontSize: 20.0),),
                        Text('5- Write your exit ticket and check your attendance',style: TextStyle(fontSize: 20.0),),


                      ],),
                      Row(
                       crossAxisAlignment: CrossAxisAlignment.end,
                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                       children: [
                       new RaisedButton(
                           child: new Text("Enter"),
                           onPressed: () async{
                             if(validateAndSave()==true) {
                               setState(() {
                                if(check){
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Startlesson(
                                                code: code,
                                              )));

                                }
                                else{
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              exceptioncode()));
                                }
                               });
                             }

                           }
                       ),
                       new RaisedButton(
                           child: new Text("Sign out"),
                           onPressed: () {
                             setState(() {});
                             Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                   builder: (context) => Signin(),
                                 ));
                           }),
                     ],)
                    ],
                  ),
                ),
              )),
        )),
    );
  }
}
