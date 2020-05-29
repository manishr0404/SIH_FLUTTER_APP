import 'package:flutter/material.dart';
import 'package:flutter_app/jobs/general_jobs.dart';
import 'package:flutter_app/jobs/search.dart';
import 'package:flutter_app/questions/general_question.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class DashboardTwoPage extends StatelessWidget {
  DashboardTwoPage({Key key, this.usertoken}) : super(key: key);
 final String usertoken;
  static final String path = "lib/src/pages/dashboard/dash2.dart";
  final TextStyle whiteText = TextStyle(color: Colors.black);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.tealAccent,
        elevation: 0,
        title: Text("Dashboard"),
        centerTitle: true,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          _buildHeader(),
          const SizedBox(height: 50.0),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 190,
                      color: Colors.teal,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              "Job Applied :",
                              style:
                              Theme.of(context).textTheme.display1.copyWith(
                                color: Colors.white,
                                fontSize: 24.0,
                              ),
                            ),
                            trailing: Icon(
                              FontAwesomeIcons.suitcase,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              '2 jobs Applied',
                              style: whiteText,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      height: 120,
                      color: Colors.cyanAccent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              "General Jobs",
                              style:
                              Theme.of(context).textTheme.display1.copyWith(
                                color: Colors.white,
                                fontSize: 24.0,
                              ),
                            ),
                            trailing: Icon(
                              FontAwesomeIcons.addressCard,
                              color: Colors.white,
                            ),
                            onTap:  () => Navigator.of(context).push(new MaterialPageRoute(
                                   builder: (BuildContext context) => SearchPage(title: usertoken,)))
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              "List of all Jobs",
                              style: whiteText,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 120,
                      color: Colors.red,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              "4",
                              style:
                              Theme.of(context).textTheme.display1.copyWith(
                                color: Colors.white,
                                fontSize: 24.0,
                              ),
                            ),
                            trailing: Icon(
                              FontAwesomeIcons.list,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              'Recommended Jobs',
                              style: whiteText,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      height: 190,
                      color: Colors.yellow,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              "2",
                              style:
                              Theme.of(context).textTheme.display1.copyWith(
                                fontSize: 24.0,
                                color: Colors.black,
                              ),
                            ),
                            trailing: Icon(
                              FontAwesomeIcons.mailBulk,
                              color: Colors.black,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              'Response',
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: <Widget>[
        Container(
          height: 100,
          width: 100,
          padding: const EdgeInsets.all(8.0),
          child: CircularProgressIndicator(
            value: 1.0,
            valueColor: AlwaysStoppedAnimation(Colors.green),
            backgroundColor: Colors.grey.shade700,
          ),
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Overall\n Job Progress",
                style: whiteText.copyWith(fontSize: 20.0),
              ),
              const SizedBox(height: 20.0),
              Text(
                "45% to go",
                style: TextStyle(color: Colors.grey, fontSize: 16.0),
              ),
            ],
          ),
        )
      ],
    );
  }
}