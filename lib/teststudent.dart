import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentapp/pages/Videoshowingwidget.dart';
import 'package:studentapp/pages/homepage.dart';
import 'authentication/signinpage.dart';
import 'functions/Quizezfun.dart';
String globallevel;
// ignore: must_be_immutable
class Startlesson extends StatefulWidget {
  String code;
  Startlesson({ this.code});
  @override
  _StartlessonState createState() => _StartlessonState();
}

class _StartlessonState extends State<Startlesson> {
  final fs=Firestore.instance;
  int counter=0;
  bool selected=true;
  int index=0;
  Future getquestions() async {
    QuerySnapshot qn;
    qn=await fs.collection(grade).document('${widget.code}')
        .collection(globallevel).getDocuments();
    return qn.documents;

  }
  Widget build(BuildContext context) {

    FutureBuilder getq(){
      return FutureBuilder(
          future: getquestions(),
          builder: (_,snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(child: Text('Loading....'),);
            }
            else{
              return Column(
                children: [
                  Container(
                      width:MediaQuery.of(context).size.width,height: 50.0,
                      child: Center(child: Text('Question ${index+1} :  ''${snapshot.data[index].data['Question']}'))),
                  Quizezfun(code: widget.code).
                  raselect(snapshot.data[index].data['1'], snapshot.data[index].data['2'],
                      snapshot.data[index].data['3'], snapshot.data[index].data['4'],
                      snapshot.data[index].data['Right']),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton(onPressed:(){
                        setState(() {
                          if(index>0){
                            index--;
                          }
                          else index=0;

                        });
                      }, child: Text('Back')),
                      RaisedButton(onPressed:(){
                         setState(()  {
                           if(index<snapshot.data.length-2){
                             if(valp==snapshot.data[index].data['Right']){
                                Quizezfun(code: widget.code).increment();
                                  Quizezfun(code: widget.code).addtrue();
                             }
                           }
                           else {
                           if(index==snapshot.data.length-2){
                          if(valp==snapshot.data[index].data['Right']){
                          Quizezfun(code: widget.code,).increment();
                           Quizezfun(code: widget.code,).addtrue();

                             }
                          Quizezfun(code: widget.code).calculator();

                          Navigator.pushReplacement(context,
                                 MaterialPageRoute(builder: (context) =>
                                     Showlesson(code: widget.code,)));
                             answercalculator.clear();

                           }
                           }
                         });
                         index++;
                      }, child: index==snapshot.data.length-2?Text("Finish"):Text('Next->')),

                    ],),
                ],
              );
            }
          }
      );
    }
    return Theme(
      data: testtheme,
      child: Scaffold(
        appBar: AppBar(title: Center(child: Text('Test your Level')),),
        body:Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
           Image.network('https://cdn.pixabay.com/photo/2016/06/15/15/25/loudspeaker-1459128__340.png',height:200.0,),
            Center(child: getq()),
          ],),
        )),);
  }
}

