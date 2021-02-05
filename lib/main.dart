import 'package:flutter/material.dart';
import 'package:studentapp/authentication/signinpage.dart';
import 'package:studentapp/pages/greeting.dart';
import 'package:studentapp/pages/homepage.dart';

void setErrorBuilder() {
  ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
    return Container(
        padding: EdgeInsets.only(right: 20.0, left: 20.0, top: 50.0),
      child: Text(''),
    );
    };
}
void main(){runApp(
    new MaterialApp(
    builder:  (BuildContext context, Widget widget) {
  setErrorBuilder();
  return widget;
},
    home:Signin()));}
