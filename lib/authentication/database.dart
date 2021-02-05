import 'package:cloud_firestore/cloud_firestore.dart';
class Databaseservices{
  final String uid;
  Databaseservices({this.uid});
  final CollectionReference TTTdatabase=Firestore.instance.collection('tttmessaging');
Future UpdateStudentdata(String Name , String Class , String Level)async{
  return await TTTdatabase.document(uid).setData({
    'name':Name,
    'class':Class,
    'Level':Level,
  });
}
}