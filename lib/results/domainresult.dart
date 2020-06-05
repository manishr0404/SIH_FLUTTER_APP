 import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/questions/domain_specific.dart';
 import 'dart:async';
 import 'dart:convert';
 import 'package:http/http.dart' as http;
 import 'package:shared_preferences/shared_preferences.dart';
 import 'package:flutter_app/questions/question_level3_domain.dart';
 
class ResDomPage extends StatefulWidget {
ResDomPage({Key key, this.resmarks1,this.resmarks2,this.round,this.previousround,this.maximum,this.usertokenvar}) : super(key: key);
final int resmarks1;
final int resmarks2;
final String round;
final String previousround;
final String maximum;
final String usertokenvar;


  _ResDomPageState createState() => _ResDomPageState();
}

class _ResDomPageState extends State<ResDomPage> {

 
  
  @override
  void initState() {  
    updatedommarks(widget.resmarks1);
  super.initState();    
  }
 Future<void> updatedommarks(int a) async
  {
      int c = a;
      
     
      String total = c.toString();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
       Map data = {
      'Domain': widget.maximum,
      'Total':total,
       };
       var jsonResponse = null;
       var response = await http.post("http://harshraj.pythonanywhere.com/candidate/put-domain-marks/", body: data,headers: {HttpHeaders.authorizationHeader:"token ${widget.usertokenvar}"});
       if(response.statusCode == 200)
       {
         jsonResponse = json.decode(response.body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      print("level 2 marks are applied");
       }
       else
       print("Error");

  }
 
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          //width / 1.2,
          child: Column(
            children: <Widget>[
            
              Expanded(
                flex: 8,
                child: Hero(
                  tag: 'Clipboard',
                  child:  Image(
                                image: AssetImage(
                                  'assets/profile.png',
                                ),
                                height: 100,
                                width: 100,
                              ),
                            
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: <Widget>[
                    
                    Text(
                      'You have Completed ${widget.previousround} round',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Domain 1: ${widget.resmarks1}:\nDomain 2:${widget.resmarks2}',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontFamily: 'sanserrif.ttf'),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Maximum in Domain ${widget.maximum}',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontFamily: 'sanserrif.ttf'),
                      textAlign: TextAlign.center,
                    ),

                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: RaisedButton(
                  onPressed: () {
                    updatedommarks(widget.resmarks1);
                    
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LevelPage(tok: widget.usertokenvar,)),   /// HAVE TO WORK ON IT FOR DYNAMIC
                    );
                  },
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.4,
                    height: 60,
                    decoration: const BoxDecoration(
                      // gradient: LinearGradient(
                      //   colors: <Color>[
                      //     // CustomColors.GreenLight,
                      //     // CustomColors.GreenDark,
                      //     Colors.lightGreenAccent,
                      //     Colors.greenAccent,
                      //   ],
                      // ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.greenAccent,
                          blurRadius: 5.0,
                          spreadRadius: 2.0,
                          offset: Offset(0.0, 0.0),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Center(
                      child: Text(
                        " Start ${widget.round} round",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

  