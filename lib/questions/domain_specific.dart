import 'dart:ffi';

import 'dart:math';


import 'package:flutter/material.dart';
import 'package:flutter_app/questions/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_app/questions/question_level3_domain.dart';
import 'package:flutter_app/results/domainresult.dart';
import 'package:http/http.dart';
 import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_app/questions/domain_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HomePage1 extends StatefulWidget {
   HomePage1({Key key, this.maxdomain,this.token}) : super(key: key);
final String maxdomain;
final String token;
  
  @override
  _HomePageState1 createState() => _HomePageState1();
}

class _HomePageState1 extends State<HomePage1> {
  var mark1 = new List();
  var mark2 = new List();
  var mark3 = new List();
  var mark4 = new List();
  var globmarks = new List();

  

  General quiz;
  Domainspec quiz1;
  
  List<Data> data;
  List<QuestionDomain> questionDomain;
  

  Future<void> fetchQuestions()async{
  
    var res = await http.get("http://harshraj.pythonanywhere.com/user/api/get-domain-question/?Domain=${widget.maxdomain}");
  
    var decRes = jsonDecode(res.body);
    print(decRes);
    quiz1 = Domainspec.fromJson(decRes);
    data = quiz1.data;
      
  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("2nd Round"),
        elevation: 0.0,
      ),
      body: RefreshIndicator(
        onRefresh: fetchQuestions,
        child: new FutureBuilder(
          future: fetchQuestions(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            switch(snapshot.connectionState){
              case ConnectionState.none:
                return Text("Press Button to Start !");
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator(backgroundColor: Color.fromARGB(85, 75, 85, 8),));
              case ConnectionState.done:
                if(snapshot.hasError) return errorData(
                    snapshot
                );
                 return 
                // Container(height:10.0,width:20.0);
                questionsList();

            }
            return null;
          },
        ),
      ),
    );
  }

  Padding errorData(AsyncSnapshot snapshot){
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AlertDialog(title: Text("Your Internet Connection is poor")),
          new Text("Error :${snapshot.error}"),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            onPressed: (){
              fetchQuestions();
              
              setState(() {

              });
            },
            child: new Text("Try Again"),
          )
        ],
      ),
    );
  }
 Container Submit(){
   Text("SUBMIT");
 }


  ListView questionsList(){
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context,i,)=>Card(
        color: Colors.greenAccent,
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ExpansionTile(
            title: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
             
              children: <Widget>[
                
                   Text(data[i].questionText,style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
              
               
              
              ],
            ),
            leading: new CircleAvatar(
              
              backgroundColor: Colors.grey[100],
              child: new Text("Q"
                  //questionList[i].domain.toString(),
                  // .startsWith("1")?"M":"B"
              ),
            ),

            
              children: <Widget>[
                //Text("zsjfjs"),
                AnswerWidget(data.length,data[i].questionDomain,data[i].questionDomain[0].answerText,data[i].questionDomain[0].weightage,0,data[i].questionDomain[0].subDomain,mark1,mark2,mark3,mark4,globmarks,widget.maxdomain,widget.token),
                AnswerWidget(data.length,data[i].questionDomain,data[i].questionDomain[1].answerText,data[i].questionDomain[1].weightage,1,data[i].questionDomain[1].subDomain,mark1,mark2,mark3,mark4,globmarks,widget.maxdomain,widget.token),
             //   AnswerWidget(data[i].questionDomain,data[i].questionDomain[2].answerText,data[i].questionDomain[2].weightage,2,data[i].questionDomain[2].fromDomain,mark1,mark2),

              ],
  

          ),
        ),
      ),
    );
  }
}



class AnswerWidget extends StatefulWidget {
  
 
   QuestionDomain ansers1;

   
    
    QuestionList questionList;
    Data data;
  final int ln;
   final List<QuestionDomain> questionDomain;
  
  final  String answerText;
  final int weightage;
  final int index;
  final int domain;
  final List mj;
  final List dj;
  final List aj;
  final List bj;
  final List glob;
  final String domaindata;
  final String usertok;

   
  //final int id;
  
 AnswerWidget(this.ln,this.questionDomain,this.answerText,this.weightage,this.index,this.domain,this.mj,this.dj,this.aj,this.bj,this.glob,this.domaindata,this.usertok);

  @override
  _AnswerWidgetState createState() => _AnswerWidgetState();
}

class _AnswerWidgetState extends State<AnswerWidget> {
   
   Color c = Colors.black;
  int count = 0;
  int count1 = 0;
  List total ;
  bool tapped = false;
  var marklist = List();
  
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("ALERT"),
          content: new Text("Select Only One Answer"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  int getArraySum(List<dynamic> a,List<dynamic> b,List<dynamic> x, List<dynamic> y,String recdata){
    int i = 0;
    int j;
    
    var subdomaintotal = new List<int>();

    var c = List<int>(b.length);
    var d =  List<int>(a.length);
    var e = List<int>(x.length);
    var f = List<int>(y.length);
    int total1 = 0;
    int total2 = 0;
    int total3 = 0;
    int total4 = 0;
    int finaltotal = 0;
    int threshold ;
    String max;
    for(j = 0; j <= (a.length-1); j++)
    {
      d[j] = int.parse(a[j]);
    }
    for(j= 0; j <= (b.length -1); j++)
    {
      c[j] = int.parse(b[j]);
    }
     for(j= 0; j <= (x.length -1); j++)
    {
      e[j] = int.parse(x[j]);
    }
     for(j= 0; j <= (y.length -1); j++)
    {
      f[j] = int.parse(y[j]);
    }


    
  for(i = 0; i <= (d.length - 1); i++)
  {
    total1 += d[i];
  }
  print(total1);
  subdomaintotal.add(total1);
   for(i = 0; i <= (c.length - 1); i++)
  {
    total2 += c[i];
  }
  print(total2);
  subdomaintotal.add(total2);
   for(i = 0; i <= (e.length - 1); i++)
  {
    total3 += e[i];
  }
  print(total3);
  subdomaintotal.add(total3);
   for(i = 0; i <= (f.length - 1); i++)
  {
    total4 += f[i];
  }
  print(total4);
  subdomaintotal.add(total4);

  print(subdomaintotal);
   subdomaintotal.sort();
   print(subdomaintotal);
   print(subdomaintotal.first);
   print(subdomaintotal.last);
     for(i = 0; i <= (subdomaintotal.length - 1); i++)
  {
    finaltotal += subdomaintotal[i];
  }
 print(finaltotal);
 threshold = (finaltotal * 0.70).floor();

 if(finaltotal > 1)
 {
   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => ResDomPage(resmarks1: finaltotal,round: "3rd",previousround: "2nd",maximum: recdata,usertokenvar: widget.usertok,),),
                   );
 }
 else
 {  
    if(recdata == '1')
    {
       Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) =>HomePage1(maxdomain: 2.toString(),token: widget.usertok,)),
                   );
    }
     else{
        Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) =>HomePage1(maxdomain: 1.toString(),token: widget.usertok)),
                   );
     }
 }
  

  
 }


  

  @override
  Widget build(BuildContext context) {
    
     return
        ListTile(
           onTap: (){
           
             setState(()  {
            
               if(tapped == false)
               {

                 tapped = true;
                 c = Colors.black;
                 print("tapped");
                 count = count + 1;
                 widget.glob.add("${widget.questionDomain[widget.index].weightage.toInt()}");
               

                 if(widget.questionDomain[widget.index].subDomain == 2 || widget.questionDomain[widget.index].subDomain == 9)
                 {
                   widget.mj.add("${widget.questionDomain[widget.index].weightage.toInt()}");
                   widget.mj.toList();
                   print(widget.mj);
                   print("lIST 1");

                 }
                 else if(widget.questionDomain[widget.index].subDomain == 3 || widget.questionDomain[widget.index].subDomain == 10)
                 {
                   widget.dj.add("${widget.questionDomain[widget.index].weightage.toInt()}");
                   print(widget.dj);
                   print("LIST 2");
                 }
                 else if(widget.questionDomain[widget.index].subDomain == 5 || widget.questionDomain[widget.index].subDomain == 11)
                 {  
                    widget.aj.add("${widget.questionDomain[widget.index].weightage.toInt()}");
                     print("LIST 3");
                 }
                 else if(widget.questionDomain[widget.index].subDomain == 7 || widget.questionDomain[widget.index].subDomain == 13)
                 {
                       widget.bj.add("${widget.questionDomain[widget.index].weightage.toInt()}");
                       print("LIST 4");
                 }

               }
               else
               {
                 tapped = false;
                 c = Colors.white;
                 print("untapped");
                 count = 0;
                 widget.glob.remove("${widget.questionDomain[widget.index].weightage.toInt()}");
                   if(widget.questionDomain[widget.index].subDomain == 2 || widget.questionDomain[widget.index].subDomain == 9)
                 {
                   widget.mj.remove("${widget.questionDomain[widget.index].weightage.toInt()}");
                   print(widget.mj);
                   print("LIST 1 ELEMENT REMOVED");
                   
                 }
                 else if(widget.questionDomain[widget.index].subDomain == 3 || widget.questionDomain[widget.index].subDomain == 10)
                 {
                   widget.dj.remove("${widget.questionDomain[widget.index].weightage.toInt()}");
                   print(widget.dj);
                   print("LIST 2 ELEMENT REMOVED");
                 }
                 else if(widget.questionDomain[widget.index].subDomain == 5 || widget.questionDomain[widget.index].subDomain == 11)
                 {
                     widget.aj.remove("${widget.questionDomain[widget.index].weightage.toInt()}");
                     print(widget.aj);
                     print("LIST 3 ELEMENT REMOVED");
                 }
                 else if(widget.questionDomain[widget.index].subDomain == 7 || widget.questionDomain[widget.index].subDomain == 13)
                 {     
                       print(widget.bj);
                        widget.bj.remove("${widget.questionDomain[widget.index].weightage.toInt()}");
                       print("LIST 4 ELEMENT REMOVED");
                 }

                 

                 
               }
               if(count > 1)
               {
                 _showDialog();
               }
               if(widget.glob.length == widget.ln)
               {
                 setState(() {
                   getArraySum(widget.mj, widget.dj, widget.aj, widget.bj,widget.domaindata);
                 });
               }
               
              

           
               
          

             }
            ); 
           },
        
          
         
          title: new Center(child: ChoiceChip(label: Text(widget.answerText,textAlign: TextAlign.center,
          style: new TextStyle(
            color: c,
            fontWeight: FontWeight.bold,),),selectedColor: Colors.lightBlueAccent,selected: tapped,)
          ),
      //     new Text(
      //         widget.answerText,
      //     textAlign: TextAlign.center,
      //     style: new TextStyle(
      //       color: c,
      //       fontWeight: FontWeight.bold,
      //     ),
          
      // ), 
    );
    
  }
}

 