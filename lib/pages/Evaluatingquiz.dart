import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studentapp/authentication/signinpage.dart';
import 'package:studentapp/functions/Quizezfun.dart';
import 'package:studentapp/pages/Exitticket.dart';
import 'package:studentapp/teststudent.dart';
import 'homepage.dart';
class Evaluation extends StatefulWidget {

  String code;
  Evaluation({this.code});

  @override
  _EvaluationState createState() => _EvaluationState();
}

class _EvaluationState extends State<Evaluation> {
  int index=0;
  final fs=Firestore.instance;
  Future getquestions() async {
    QuerySnapshot qn;
    qn=await fs.collection('${grade}').document('${widget.code}')
        .collection('${globallevel}').document('zzevaluation_exam').collection('zzevaluation_exam').getDocuments();
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
                  new Text("Test to evaluate your understanding to the lesson !",style: TextStyle(fontFamily: "UbuntuCondensed"),),
                  Container(
                      width:MediaQuery.of(context).size.width,height: 50.0,
                      child: Center(child: Text('Question ${index+1} :  ''${snapshot.data[index].data['Question']}'))),
                  Quizezfun().raselect(snapshot.data[index].data['1'], snapshot.data[index].data['2'],
                      snapshot.data[index].data['3'], snapshot.data[index].data['4'],
                      snapshot.data[index].data['Right']),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton(onPressed:(){
                        setState(() {
                          index>0?index--:index=0;
                        });
                      }, child: Text('Back')),
                      RaisedButton(onPressed:(){
                        setState(() {
                          if(index<snapshot.data.length-1){
                            if(valp==snapshot.data[index].data['Right']){
                              Quizezfun(code: widget.code).increment();
                              Quizezfun(code: widget.code).addtrue();
                            }
                          }
                          else {
                            if (index == snapshot.data.length - 1) {
                              if (valp == snapshot.data[index].data['Right']) {
                                Quizezfun(code: widget.code,).increment();
                                Quizezfun(
                                    code: widget.code,).addtrue();
                              }
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) =>
                                      Exitticket(email: email,
                                        grade: grade,
                                        level: globallevel,
                                      code: widget.code,)));
                              answercalculator.clear();
                              answercalculator.clear();
                              Quizezfun(code: widget.code).lastcalculator();
                            }
                          }});
                      }, child: index==snapshot.data.length-1?Text("Finish"):Text('Next->')),

                    ],),
                ],
              );
            }
          }
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
                image: AssetImage("assets/images/2.jpg"), fit: BoxFit.cover,
                   colorFilter:ColorFilter.mode(Colors.black.withOpacity(0.1),BlendMode.dstATop),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: getq(),
            )
          ),
        ),
      ),
    );}
}
