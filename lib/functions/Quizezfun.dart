import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:studentapp/authentication/signinpage.dart';
import 'package:studentapp/teststudent.dart';
final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
final GlobalKey<FormBuilderState> _fbKeytest = GlobalKey<FormBuilderState>();
List<Icon> answercalculator=[];
int counter=0;
int leveltracker=0;
String valp;
class Quizezfun{

  String code;

  Quizezfun({this.code});

  Future<int> firstquestionsnum()async{
    QuerySnapshot _myDoc =await Firestore.instance.collection('$grade').document(code).collection(globallevel).getDocuments();
    List<DocumentSnapshot> _myDocCount = _myDoc.documents; // Count of Documents in Colle
    return _myDocCount.length-1;// Count of Documents in Collection
}
  Future lastquestionsum()async{
  final _myDoc = await Firestore.instance.collection('$grade').document(code).
  collection(globallevel).document('zzevaluation_exam').collection('zzevaluation_exam').getDocuments();
  List<DocumentSnapshot> _myDocCount = _myDoc.documents;
  return _myDocCount.length;

}
int increment(){
   return leveltracker++;
}
  FormBuilder raselect(String v1,String v2,String v3,String v4,String rightans){
        return FormBuilder(
          key: _fbKey,
          readOnly: false,
          child: Column(
            children: [
              Row(children:answercalculator),
              FormBuilderRadioGroup(
                decoration:
                InputDecoration(labelText: 'Choose the right answer'),
                validators: [FormBuilderValidators.required()],
                attribute:"Test",
                options: [v1, v2, v3, v4]
                    .map((lang) => FormBuilderFieldOption(
                  value: lang,
                  child: Text('$lang'),
                ))
                    .toList(growable: false),
                onChanged: (val)async {
                  valp=val;
                },),],),);}
  void addtrue(){
    answercalculator.add(Icon(Icons.check,color: Colors.green,));
  }
  void addfalse(){
    answercalculator.add(Icon(Icons.close,color: Colors.red,));
  }
  void calculator()async{
    if(leveltracker<=await firstquestionsnum()/3){
    Firestore.instance.collection('$email').document('Level').collection('code').document(code).updateData({'$code': 'Level1'});
    globallevel='Level1';
    }
    else if(leveltracker<=await firstquestionsnum()*2~/3){
      Firestore.instance.collection('$email').document('Level').collection('code').document(code).updateData({'$code': 'Level2'});
      globallevel='Level2';
    }
    else{
      Firestore.instance.collection('$email').document('Level').collection('code').document(code).updateData({'$code': 'Level3'});
      globallevel='Level3';
    }
  leveltracker=0;
  }
  void lastcalculator()async{
    if(leveltracker<=await lastquestionsum()/3){
      Firestore.instance.collection('$email').document('Level').collection('code').document(code).updateData({'$code': 'Level1'});
    }
    else if(leveltracker<=await lastquestionsum()*2~/3){
      Firestore.instance.collection('$email').document('Level').collection('code').document(code).updateData({'$code': 'Level2'});
    }
    else{
      Firestore.instance.collection('$email').document('Level').collection('code').document(code).updateData({'$code': 'Level3'});
    }
    leveltracker=0;
  }

  FormBuilder raselectteacher(String v1,String v2,String v3,String v4,String rightanswer){
    return FormBuilder(
      key: _fbKeytest,
      readOnly: false,
      child: Column(
        children: [
          Row(children:answercalculator),
          FormBuilderRadioGroup(
            decoration:
            InputDecoration(labelText: 'Choose the right answer'),
            validators: [FormBuilderValidators.required()],
            attribute:"Test",
            options:
            [v1, v2, v3, v4]
                .map((lang) => FormBuilderFieldOption(
              value: lang,
              child: Text('$lang'),
            ))
                .toList(growable: false),
            onChanged: (val) {
              rightanswer=val;
              },
          ),
        ],
      ),
    );
  }
}