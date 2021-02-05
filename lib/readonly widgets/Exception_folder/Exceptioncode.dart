import 'package:flutter/material.dart';
class exceptioncode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: 
    Scaffold(appBar: 
      AppBar(title:Center(child: Text('Not found !')),),
    body: Center(child: 
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Image.asset('assets/images/1.png',fit: BoxFit.contain,),
            Text('No available lessons for this code today !',style: TextStyle(fontFamily:'UbuntuCondensed',fontSize: 21.0),),
          ],
        ),
      )
      ,),
    )
    );
  }
}
