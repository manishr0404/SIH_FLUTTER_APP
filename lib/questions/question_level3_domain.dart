import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_app/questions/question_level3_domain_model.dart';
import 'package:flutter_app/questions/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_app/results/finalresult.dart';


class LevelPage extends StatefulWidget {
   LevelPage({Key key, this.tok}) : super(key: key);
final String tok;


  
  @override
  _LevelPageState createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage> {
   var mark1 = new List();
  var mark2 = new List();
  var globalmarks = new List();
 
  Level _level;
  List<Data> data;
  
  List<QuestionDomain> questionDomain;
  

  Future<void> fetchQuestions()async{
    var res = await http.get("http://harshraj.pythonanywhere.com/user/level3/2/5/");
    var decRes = jsonDecode(res.body);
    print(decRes);
    _level = Level.fromJson(decRes);
    data = _level.data;
   
    
  }

 
  



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("3rd Round"),
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
                new Text(data[i].questionText,style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
                
              
                // FittedBox(
                //   child: new Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: <Widget>[
                //       FilterChip(
                //         backgroundColor: Colors.grey[100],
                //         label: Text("${data[i].domain}"),
                //         //label: Text("vhgfhvvhvv"),
                //         onSelected: (b){},
                //       ),
                //       SizedBox(
                //         width: 10.0,
                //       ),
                //       FilterChip(
                //         backgroundColor: Colors.grey[100],
                //         label: Text("${data[i].id}"),
                //         // label: Text("vhgfhvvhvv"),
                //         onSelected: (b){},
                //       )
                      
                //     ],
                //   ),
                // )
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
                AnswerWidget(data[i].questionDomain,data[i].questionDomain[0].answerText,data[i].questionDomain[0].weightage,0,data[i].questionDomain[0].subDomain,mark1,mark2,globalmarks,widget.tok),
                AnswerWidget(data[i].questionDomain,data[i].questionDomain[1].answerText,data[i].questionDomain[1].weightage,1,data[i].questionDomain[1].subDomain,mark1,mark2,globalmarks,widget.tok),
                AnswerWidget(data[i].questionDomain,data[i].questionDomain[2].answerText,data[i].questionDomain[2].weightage,2,data[i].questionDomain[2].subDomain,mark1,mark2,globalmarks,widget.tok),
                 AnswerWidget(data[i].questionDomain,data[i].questionDomain[3].answerText,data[i].questionDomain[3].weightage,3,data[i].questionDomain[3].subDomain,mark1,mark2,globalmarks,widget.tok),


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
  
   final List<QuestionDomain> questionDomain;
  
  final  String answerText;
  final int weightage;
  final int index;
  final int domain;
   final List mj;
  final List dj;
  final List glob;
  final String tokvar;

   
  //final int id;
  
 AnswerWidget(this.questionDomain,this.answerText,this.weightage,this.index,this.domain,this.mj,this.dj,this.glob,this.tokvar);

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
  int getArraySum(List<dynamic> a,List<dynamic> b,List<dynamic> x){
    int i = 0;
    int j;
    
    var subdomaintotal = new List<int>();
   
   var e = x.length;
    var c = List<int>(b.length);
    var d =  List<int>(a.length);
    
    int total1 = 0;
    int total2 = 0;
    
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
  

  print(subdomaintotal);
   subdomaintotal.sort();
   print(subdomaintotal);
   print(subdomaintotal.first);
   print(subdomaintotal.last);
     for(i = 0; i <= (subdomaintotal.length - 1); i++)
  {                                                                     
    finaltotal += subdomaintotal[i];
  }
 double rating = (finaltotal/e);
 int rate = rating.ceil();
 print(finaltotal);
                                                                      // LOGIC IS WRONG HAVE TO CHANGE LATER
  
  if(total1 > total2)
  {
     Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => ResDomPage(resmarks1: total1,previousround: "3rd",maximum: 1.toString(),token: widget.tokvar, ),),
                   );
  }
  else{
    Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => ResDomPage(resmarks1: total2,previousround: "3rd",maximum: 2.toString(),token:widget.tokvar),),
                   );

  }













   
  }


  @override
  Widget build(BuildContext context) {
    
     return
        ListTile(
           onTap: (){
           
             setState(() {
                 if(tapped == false)
               {

                 tapped = true;
                 c = Colors.black;
                 print("tapped");
                 count = count + 1;
                 widget.glob.add("${widget.questionDomain[widget.index].weightage.toInt()}");
               

                 if(widget.questionDomain[widget.index].subDomain == 2)
                 {
                   widget.mj.add("${widget.questionDomain[widget.index].weightage.toInt()}");
                   widget.mj.toList();
                   print(widget.mj);
                   print("lIST 1");

                 }
                 else if(widget.questionDomain[widget.index].subDomain == 5 )
                 {
                   widget.dj.add("${widget.questionDomain[widget.index].weightage.toInt()}");
                   print(widget.dj);
                   print("LIST 2");
                 }
               

               }
               else
               {
                 tapped = false;
                 c = Colors.white;
                 print("untapped");
                 count = 0;
                 widget.glob.remove("${widget.questionDomain[widget.index].weightage.toInt()}");
                   if(widget.questionDomain[widget.index].subDomain == 2 )
                 {
                   widget.mj.remove("${widget.questionDomain[widget.index].weightage.toInt()}");
                   print(widget.mj);
                   print("LIST 1 ELEMENT REMOVED");
                   
                 }
                 else if(widget.questionDomain[widget.index].subDomain == 5)
                 {
                   widget.dj.remove("${widget.questionDomain[widget.index].weightage.toInt()}");
                   print(widget.dj);
                   print("LIST 2 ELEMENT REMOVED");
                 }
                
                 

                 
               }
                if(count > 1)
               {
                 _showDialog();
               }
               if(widget.glob.length == 20)
               {
                 setState(() {
                   getArraySum(widget.mj, widget.dj,widget.glob);
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

 