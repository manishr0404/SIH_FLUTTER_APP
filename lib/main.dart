
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:flutter_app/questions/general_question.dart';
import 'package:flutter_app/view/login.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app/view/splash.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_app/view/dashboard.dart';
import 'package:flutter_app/view/profile.dart';

import 'package:flutter_app/view/splash.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) { 
    return MaterialApp(
      title: "YourPerfectJob",
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),//MainPage(),
      theme: ThemeData(
          primaryColor: Colors.greenAccent,
      ),
    );
  }
}

class MainPage extends StatefulWidget {
    MainPage({Key key, this.usertok}) : super(key: key);
   final String usertok;
  
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();


  SharedPreferences sharedPreferences;

  @override
  void initState() {
    //super.initState();
    checkLoginStatus();
    super.initState();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 50.0,
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.search, size: 30),
          Icon(Icons.settings, size: 30),

        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.greenAccent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
          switch(_page){


          }
        },
      ),
      appBar: AppBar(
        title: Text("YourPerfectJob", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.greenAccent,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              sharedPreferences.clear();

              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
            },
            child: Text("Log Out", style: TextStyle(color: Colors.white)),

          ),
        ],
      ),
      body:
      // SearchPage(),
      //ProfilePage(),
      //GeneralJobs(),
      //HomePage(),
     DashboardTwoPage(usertoken: widget.usertok ,),
      //Center(child: DashboardTwoPage() ),
      drawer: Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text('Manish'),
              accountEmail: new Text('1234@gmail.com'),
              
              
              // decoration: new BoxDecoration(
              //   image: new DecorationImage(
              //     fit: BoxFit.fill,
              //    image: AssetImage("assets/profile10.png"),
              //   )
              // ),
            ),
            new Divider(),
            new ListTile(
              title: new Text("Profile"),
              trailing: new Icon(Icons.person),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => ProfilePage(),
              )),
            ),
            new Divider(),
            new ListTile(
              title: new Text("Job Recommendation Quiz"),
              trailing: new Icon(Icons.question_answer),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => HomePage(),
              )),
            ),

          ],
        ),
      ),
    );
  }
}