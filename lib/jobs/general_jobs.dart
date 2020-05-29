import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/jobs/general_jobs_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './search.dart';
class GeneralJobs extends StatefulWidget {

  @override
  _GeneralJobsState createState() => _GeneralJobsState();
}

class _GeneralJobsState extends State<GeneralJobs> {
  generalJobs genJobs;
  List<Data> data;

//  General quiz;
//  List<QuestionList> questionList;
//  List<Question> question;

  Future<void> fetchJobs() async {
    final response = await http.get(
      'http://harshraj.pythonanywhere.com/organization/list-of-job',
      headers: {HttpHeaders.authorizationHeader: "token 2788cceaa03bfa393b411dad71787847be63d075"},
    );
    var responseJson = json.decode(response.body);
    print(responseJson);

    genJobs = generalJobs.fromJson(responseJson);
    data = genJobs.data;

  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Job List"),

        elevation: 0.0,
      ),
      body:
      RefreshIndicator(
        onRefresh: fetchJobs,
        child:
        new FutureBuilder(
          future: fetchJobs(),
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
            return Text("hellofhgfhkhv",textScaleFactor: 50.0,);
            //Container(height:10.0,width:20.0);
          },
        ),
      ),
      extendBodyBehindAppBar: true,

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
              fetchJobs();
              setState(() {

              });
            },
            child: new Text("Try Again"),
          )
        ],
      ),
    );
  }





  ListView questionsList(){
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context,i,)=>Card(
        color: Colors.blue,
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ExpansionTile(
            title: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: <Widget>[
                //SearchInput(),
                // if(questionList[i].domain == 2)
                // {
                //       new Text(questionList[i].questionText,style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
                // },
                new Text(data[i].jobTitle,style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
                //new Text(questionList[i].question[i].answerText),

                FittedBox(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FilterChip(
                        backgroundColor: Colors.grey[100],
                        label: Text("${data[i].name}"),
                        //label: Text("vhgfhvvhvv"),
                        onSelected: (b){},
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      FilterChip(
                        backgroundColor: Colors.grey[100],
                        label: Text("${data[i].preferedCity}"),
                        // label: Text("vhgfhvvhvv"),
                        onSelected: (b){},
                      )

                    ],
                  ),
                )
              ],
            ),
            leading: new CircleAvatar(
              backgroundColor: Colors.grey[100],
              child: new Text("J"
                //questionList[i].domain.toString(),
                // .startsWith("1")?"M":"B"
              ),
            ),

            children: <Widget>[
                JobDetail(data[i].jobDescreption, data[i].minimumExperience, data[i].id),
//              AnswerWidget(questionList[i].question,questionList[i].question[0].answerText,questionList[i].question[0].weightage,0,questionList[i].question[0].fromDomain),
//              AnswerWidget(questionList[i].question,questionList[i].question[1].answerText,questionList[i].question[1].weightage,1,questionList[i].question[1].fromDomain),
              // AnswerWidget(questionList[i].question,questionList[i].question[2].answerText,questionList[i].question[2].weightage,2,questionList[i].question[1].fromDomain),

            ],

          ),
        ),
      ),
    );
  }
}



class JobDetail extends StatefulWidget {


  Data data;
 // final List<Question> question;

  final  String jobdescription;
  final int minimum_exp;
  final int id;
  //final int domain;


  //final int id;

  JobDetail(this.jobdescription,this.minimum_exp,this.id,);

  @override
  _JobDetailState createState() => _JobDetailState();
}
//
class _JobDetailState extends State<JobDetail> {

  Color c = Colors.black;



  @override
  Widget build(BuildContext context) {

    return
      ListTile(
        onTap: (){

          setState(() {


//            if(widget.question[widget.index].fromDomain == 2)
//            {
//              list.add(widget.question[widget.index].weightage);
//              print(list);
//              print("list");
//              print(list.length);
//
//
//            }
//            else if(widget.question[widget.index].fromDomain == 1)
//            {
//              list1.add(widget.question[widget.index].weightage);
//              print(list1);
//              print("list1");
//              print(list.length);
//
//            }

            // if(widget.weightage <= 4)
            // {
            //    c = Colors.green[100];
            //   print("${widget.question[widget.index].weightage}");

            // }



          }
          );
        },



        title:
        new Text(
          widget.jobdescription,
          textAlign: TextAlign.start,
          style: new TextStyle(
            color: c,
            fontWeight: FontWeight.bold,
          ),

        ),
        trailing: new Text("Minimum Exp:${widget.minimum_exp}"),
        subtitle:  RaisedButton(

            onPressed: () {
              Text("Apply Now");
            },
            textColor: Colors.white,
            padding:  EdgeInsets.all(0.0),
            child: Container(

            decoration: const BoxDecoration(

            gradient: LinearGradient(
            colors: <Color>[
            Color(0xFF0D47A1),
            Color(0xFF1976D2),
            Color(0xFF42A5F5),
        ],
      ),

    ),
              padding: const EdgeInsets.all(5.0),
              child: const Text(
                  'Apply Now',
                  style: TextStyle(fontSize: 20)
              ),
    ),
        ),

      );

  }
}

