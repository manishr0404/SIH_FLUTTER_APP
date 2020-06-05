import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/view/homepage.dart';


import '../main.dart';



class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.white, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
          children: <Widget>[
            headerSection(),
            textSection(),
            buttonSection(),
            sbuttonSection(),

          ],
        ),
      ),
    );
  }


  signIn(String username, password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'username': username,
      'password': password
    };
    var jsonResponse = null;

    var response = await http.post(
        "https://harshraj.pythonanywhere.com/account/login/", body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        sharedPreferences.setString("token", jsonResponse['token']);
        String tk = sharedPreferences.getString("token");
        print(tk);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => MainPage(usertok: tk,)), (
            Route<dynamic> route) => false);
      }
    }
    else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }
  Container sbuttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignUpPage(),),
          );
        },
        elevation: 0.0,
        color: Colors.greenAccent,
        child: Text("Sign Up", style: TextStyle(color: Colors.white70)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }


  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
        onPressed: emailController.text == "" || passwordController.text == "" ? null : () {
          setState(() {
            _isLoading = true;
          });
          signIn(emailController.text, passwordController.text);
        },
        elevation: 0.0,
        color: Colors.greenAccent,
        child: Text("Sign In", style: TextStyle(color: Colors.white70)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: emailController,
            cursorColor: Colors.white,

            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              icon: Icon(Icons.email, color: Colors.black),
              hintText: "Username",
              border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
              hintStyle: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(height: 30.0),
          TextFormField(
            controller: passwordController,
            cursorColor: Colors.black,
            obscureText: true,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              icon: Icon(Icons.lock, color: Colors.black),
              hintText: "Password",
              border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
              hintStyle: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }


  Container headerSection() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
      child: Text("YourPerfectJob",
          style: TextStyle(
              color: Colors.black,
              fontSize: 40.0,
              fontWeight: FontWeight.bold)),
    );
  }
}
