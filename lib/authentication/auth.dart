import 'package:firebase_auth/firebase_auth.dart';
import 'user.dart';
import 'database.dart';
class authservice{
final FirebaseAuth _auth=FirebaseAuth.instance;
User _userFromFirebaseUser(FirebaseUser user){
  return user !=null ? User(uid:user.uid):null;
}
String email,password;
//signin anno
Future signanon()async{
  try{
    AuthResult result=await _auth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user=result.user;
    return user;
  }catch(e){
return null;

  }
}
//register
  Future registerwithemailandpassword(String email , String password)async{
  try{
    AuthResult result =await _auth.createUserWithEmailAndPassword(email: email, password: password);
    FirebaseUser user =result.user;
    await Databaseservices(uid:user.uid).UpdateStudentdata('ahmed', 'grade 3', 'level 2');
    return _userFromFirebaseUser(user);
  }
  catch(e){
  return null;
  }

  }

//sign out
Future signout()async{
  try{
    return await _auth.signOut();
  }
  catch(e){

    return null;
  }

}
  Future signinwithemailandpassword(String email , String password)async{
    try{
      AuthResult result =await _auth.signInWithEmailAndPassword(email: email, password:password);
      FirebaseUser user =result.user;
      return _userFromFirebaseUser(user);
    }
    catch(e){

      return null;
    }

  }
}