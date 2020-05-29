import 'dart:ffi';
import 'dart:js_util';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/Total/general_total.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/questions/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';
import './domain_specific.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/results/genresult.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var mark1 = new List();
  var mark2 = new List();
 
 
  int total1;
  General quiz;
  List<QuestionList> questionList;
  List<Question> question;
  


  Future<void> fetchQuestions()async{
    var res = await http.get("https://harshraj.pythonanywhere.com/user/api/get-question/?format=json");
    var decRes = jsonDecode(res.body);
    print(decRes);
    quiz = General.fromJson(decRes);
    questionList = quiz.questionList;  
  }

//  Widget choicebutton(String k) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//         vertical: 10.0,
//         horizontal:10.0,
//       ),
      
//       child: MaterialButton(
//         onPressed:(){
//          setState(() {
           
//          });
//         },
//         child:Text(
//           k,
//           style: TextStyle(
//             color: Colors.black,
//             fontFamily: "Alike",
//             fontSize: 16.0,
//           ),
//           maxLines: 10,
//         ),
//         color: Colors.white,
//         focusColor: Colors.yellow,
//         splashColor: Colors.greenAccent[400],
//         highlightColor: Colors.greenAccent[400],
//         disabledColor: Colors.yellow,
//         minWidth: 200.0,
//         height: 45.0,
//         shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
//       ),
//     );
//   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Recommendation Quiz",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.greenAccent,
        
        elevation: 0.0,
      ),
      body: 
      RefreshIndicator(
        onRefresh: fetchQuestions,
        child: 
        new FutureBuilder(
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
                return questionsList();
                // Container(height:10.0,width:20.0);
                //questionsList();
                
            }
            return Text("hellofhgfhkhv",textScaleFactor: 50.0,);
            //Container(height:10.0,width:20.0);
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

  Widget Container()
  {
    RaisedButton(onPressed: null,child: Text("Submit"),color: Colors.cyan,);
  }

 


  ListView questionsList(){
    return ListView.builder(
      itemCount: questionList.length,
      itemBuilder: (context,i,)=>Card(
        color: Colors.greenAccent,
        elevation: 0.0,
        child: Padding(
          padding:  EdgeInsets.all(0.0),
          child: ExpansionTile(
            title: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              
              children: <Widget>[
               
               new Text(questionList[i].questionText,style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
              
              
              
                FittedBox(
                  child: Center(child:new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    
                    
                    children: <Widget>[
                      
                      FilterChip(
                        backgroundColor: Colors.grey[100],
                        padding: EdgeInsets.all(10.0),
                        
                        label: Text("Domain:${questionList[i].domain}"),
                        //label: Text("vhgfhvvhvv"),
                        onSelected: (b){},
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      FilterChip(
                        backgroundColor: Colors.grey[100],
                        label: Text("${questionList[i].id}"),
                        // label: Text("vhgfhvvhvv"),
                        onSelected: (b){},
                      )
                      
                    ],
                  ),
                  ),
                )
              ],
            ),
            leading: new CircleAvatar(
              backgroundColor: Colors.grey[100],
              child: new Text("Q"
                  //questionList[i].domain.toString(),
                  // .startsWith("1")?"M":"B"
              ),
            ),

            // for (var i = 0; i < 18; i++) {
            //   for (var j = 0; i <= 2; j++) {
            //      AnswerWidget(questionList[i].question,questionList[i].question[j].answerText,questionList[i].question[j].weightage,j);
            //   }
            // }
            
              children: <Widget>[
                 
                
                AnswerWidget(questionList[i].question,questionList[i].question[0].answerText,questionList[i].question[0].weightage,0,questionList[i].question[0].fromDomain,mark1,mark2,total1,),
                AnswerWidget(questionList[i].question,questionList[i].question[1].answerText,questionList[i].question[1].weightage,1,questionList[i].question[1].fromDomain,mark1,mark2,total1,),
                AnswerWidget(questionList[i].question,questionList[i].question[2].answerText,questionList[i].question[2].weightage,2,questionList[i].question[2].fromDomain,mark1,mark2,total1,),
                //AnswerWidget(questionList[i].question,questionList[i].question[2].answerText,questionList[i].question[3].weightage,3,questionList[i].question[3].fromDomain),
                 

              ],
        //     children: questionList[i].question.map((weightage)
  //           {


  //  var j=0;
    
    


  //           return  AnswerWidget(questionList[i].question,questionList[i].question[j].answerText,questionList[i].question[j].weightage,j);
          

  //           })
  //           .toList(),         //LECASA DE Pappel

          ),
        ),
      ),

    );

  }

}

class AnswerWidget extends StatefulWidget {
  
   Question ansers;

   
    
    QuestionList questionList;
  
   final List<Question> question;
  
  final String answerText;
  final int weightage;
  final int index;
  final int domain;
  final List mj;
  final List dj;
  final int tot1;
  
 
   
  //final int id;
  
 AnswerWidget(this.question,this.answerText,this.weightage,this.index,this.domain,this.mj,this.dj,this.tot1,);

  @override
  _AnswerWidgetState createState() => _AnswerWidgetState();
}

class _AnswerWidgetState extends State<AnswerWidget> {
  Color c = Colors.white;
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
  int getArraySum(List<dynamic> a,List<dynamic> b){
    int i = 0;
    int j;
    var c = List<int>(b.length);
    var d =  List<int>(a.length);
    int total1 = 0;
    int total2 = 0;
    String max;
    for(j = 0; j <= (a.length-1); j++)
    {
      d[j] = int.parse(a[j]);
    }
    for(j= 0; j <= (b.length -1); j++)
    {
      c[j] = int.parse(b[j]);
    }
 
  for(i = 0; i <= (d.length - 1); i++)
  {
    total1 += d[i];
  }
  print(total1);
   for(i = 0; i <= (c.length - 1); i++)
  {
    total2 += c[i];
  }
  if(total1 > total2)
  {
    max = 1.toString();
  }
  else
  {
    max = 2.toString();

  }
   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => ResPage(resmarks1: total1,resmarks2:total2,round: "2nd",previousround: "1st",maximum: max,),),
                   );

}

   @override
  Widget build(BuildContext context) {
    
     return 
           ListTile(
           onTap: (){
           
             setState(() {
               tapped = true;
               count = count + 1;
                count1 = count1 +1;
               c = Colors.black;
               if(widget.question[widget.index].fromDomain == 1 )
               {
                 widget.mj.add("${widget.question[widget.index].weightage.toInt()}");
                 widget.mj.toList();
                 
                 
                
                 print(widget.mj);
                 
               }
               if(widget.question[widget.index].fromDomain == 2 )
               {
                 widget.dj.add("${widget.question[widget.index].weightage.toInt()}");
                 widget.dj.toList();
                 print(widget.dj);
                //print(widget.question[widget.index].weightage.toInt());
               }
              
               
               
               if(count > 1)
               {
                 tapped = false;
                  count = 0;
                  
                 c = Colors.white;
                 if(widget.question[widget.index].fromDomain == 1 )
               {
                 widget.mj.remove("${widget.question[widget.index].weightage.toInt()}");
                 widget.mj.remove("${widget.question[widget.index].weightage.toInt()}");

                 print(widget.mj);
                 
               }
               if(widget.question[widget.index].fromDomain == 2 )
               {
                 widget.dj.remove("${widget.question[widget.index].weightage.toInt()}");
                 widget.dj.remove("${widget.question[widget.index].weightage.toInt()}");
                 print(widget.dj);
               }
                
               }
               if(count1 > 1)
               {
                 
                 _showDialog( );
                 count1 = 0;
                 
                
               }
               
                 if (widget. question[widget.index].id == 156 ||
                   widget. question[widget.index].id == 157) {
                 print("${widget. question[widget.index].id}");
                 setState(() {
                  //resultmarks(widget.mj);
                //resultmarks(widget.mj);
                getArraySum(widget.mj,widget.dj);
                //print(widget.mj.length);
                  //   Navigator.push(
                  //    context,
                  //    MaterialPageRoute(builder: (context) => ResPage(resmarks1: total1,resmarks2:total2,round: "2nd",previousround: "1st",),),
                  //  );

                 }
                 );
               }
               
                

                }
              );
           },
          
            
          
        
          
         
          title: 
          new Text(
              widget.answerText,
          textAlign: TextAlign.center,
          style: new TextStyle(
            color: c,
            fontWeight: FontWeight.bold,
            
          ),
         
    ),
    );
    
  }

}
