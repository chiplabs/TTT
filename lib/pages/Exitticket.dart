import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studentapp/authentication/signinpage.dart';
import 'package:studentapp/pages/homepage.dart';
// ignore: must_be_immutable
class Exitticket extends StatefulWidget {
  String email;
  String grade;
  String level;
  String code;
  Exitticket({this.email,this.grade,this.level,this.code});
  @override
  _ExitticketState createState() => _ExitticketState();
}

class _ExitticketState extends State<Exitticket> {
  bool attendence = false;
  @override
  Widget build(BuildContext context) {
    showalerdialog(BuildContext context) {
      AlertDialog alert = AlertDialog(
        title: Text('Are you sure ?'),
        content:
        Text('are you sure that you want to submit and close the lesson ?'),
        actions: [
          FlatButton(
            child: (Text('Exit now')),
            onPressed: () {
              setState(() {
                Firestore.instance.collection("Attendance").document(grade).collection(widget.code).document(email).updateData(
                    {"Checked in ${DateTime.now().toString().substring(0,16)}" :true});
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Homefun()));
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
    return Theme(
      data: testtheme,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/2.jpg"),fit: BoxFit.cover,
                   colorFilter:ColorFilter.mode(Colors.black.withOpacity(0.1),BlendMode.dstATop),),
               ),
            child: Column(
              children: [
                Text('\n Exit Ticket : \n'
                    'In not  less than 5 lines , write what did you get from this lesson   ',
                  textAlign: TextAlign.center,),
                Divider(
                  thickness: 3.0,),
                TextField(
                  keyboardType: TextInputType.multiline,
                  minLines: 5,
                  maxLines: 7,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      hintText: ('Write your Conclusion here ')),
                ),
                CheckboxListTile(
                  title: Text("i have finished the whole lesson",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 17.0),),
                  subtitle: attendence == true ? Text('') : Text('you have to check your attendence',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 15.0),),
                  value: attendence,
                  onChanged: (newValue) {
                    setState(() {attendence = newValue;});},
                  controlAffinity: ListTileControlAffinity
                      .leading, //  <-- leading Checkbox
                ),
                RaisedButton(
                  onPressed: () {
                    setState(() {
                      if (attendence == false) {
                      } else {
                        showalerdialog(context);
                      }
                    });
                  },
                  child: Text("Submit & Exit"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
