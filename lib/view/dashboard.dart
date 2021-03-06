import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_app/jobs/search.dart';
import './recommendedjobs.dart';

import 'package:flutter_app/jobs/general_jobs.dart';
import 'package:flutter_app/cache/marks.dart';


class Main1Page extends StatefulWidget
{
  Main1Page({Key key, this.usertoken,this.markdisp1,this.markdisp2,this.markdisp3}) : super(key: key);
 final String usertoken;
 final List<dynamic> markdisp1;
 final List<dynamic> markdisp2;
 final List<dynamic> markdisp3;
 
  @override
  _Main1PageState createState() => _Main1PageState();
}

class _Main1PageState extends State<Main1Page>
{
  
 // final List<List<Widget>> gh = [markdisp1,markdisp1];
  
 final  List<List<dynamic>> charts =
  [ 
   
    [0.0, 0.3, 0.7, 0.6, 0.55, 0.8, 1.2, 1.3, 1.35, 0.9, 1.5, 1.7, 1.8, 1.7, 1.2, 0.8, 1.9, 2.0, 2.2, 1.9, 2.2, 2.1, 2.0, 2.3, 2.4, 2.45, 2.6, 3.6, 2.6, 2.7, 2.9, 2.8, 3.4],
    [0.0, 0.3, 0.7, 0.6, 0.55, 0.8, 1.2, 1.3, 1.35, 0.9, 1.5, 1.7, 1.8, 1.7, 1.2, 0.8, 1.9, 2.0, 2.2, 1.9, 2.2, 2.1, 2.0, 2.3, 2.4, 2.45, 2.6, 3.6, 2.6, 2.7, 2.9, 2.8, 3.4, 0.0, 0.3, 0.7, 0.6, 0.55, 0.8, 1.2, 1.3, 1.35, 0.9, 1.5, 1.7, 1.8, 1.7, 1.2, 0.8, 1.9, 2.0, 2.2, 1.9, 2.2, 2.1, 2.0, 2.3, 2.4, 2.45, 2.6, 3.6, 2.6, 2.7, 2.9, 2.8, 3.4,],
    [0.0, 0.3, 0.7, 0.6, 0.55, 0.8, 1.2, 1.3, 1.35, 0.9, 1.5, 1.7, 1.8, 1.7, 1.2, 0.8, 1.9, 2.0, 2.2, 1.9, 2.2, 2.1, 2.0, 2.3, 2.4, 2.45, 2.6, 3.6, 2.6, 2.7, 2.9, 2.8, 3.4, 0.0, 0.3, 0.7, 0.6, 0.55, 0.8, 1.2, 1.3, 1.35, 0.9, 1.5, 1.7, 1.8, 1.7, 1.2, 0.8, 1.9, 2.0, 2.2, 1.9, 2.2, 2.1, 2.0, 2.3, 2.4, 2.45, 2.6, 3.6, 2.6, 2.7, 2.9, 2.8, 3.4, 0.0, 0.3, 0.7, 0.6, 0.55, 0.8, 1.2, 1.3, 1.35, 0.9, 1.5, 1.7, 1.8, 1.7, 1.2, 0.8, 1.9, 2.0, 2.2, 1.9, 2.2, 2.1, 2.0, 2.3, 2.4, 2.45, 2.6, 3.6, 2.6, 2.7, 2.9, 2.8, 3.4]
  ];

  static final List<String> chartDropdownItems = [ 'General Quiz Result' , 'Doamin Quiz Result', 'Subdomain Result' ];
  String actualDropdown = chartDropdownItems[0];
  int actualChart = 0;

 
 
  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
     
     
      body: StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: <Widget>[
          _buildTile(
            Padding
            (
              padding: const EdgeInsets.all(24.0),
              child: Row
              (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>
                [
                  Column
                  (
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>
                    [
                      Text('Total Recruit Views on Resume', style: TextStyle(color: Colors.blueAccent)),
                      Text('26', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 34.0))
                    ],
                  ),
                  Material
                  (
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(24.0),
                    child: Center
                    (
                      child: Padding
                      (
                        padding: const EdgeInsets.all(16.0),
                        child: Icon(Icons.timeline, color: Colors.white, size: 30.0),
                      )
                    )
                  )
                ]
              ),
            ),
          ),
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column
              (
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>
                [
                  Material
                  (
                    color: Colors.teal,
                    shape: CircleBorder(),
                    child: Padding
                    (
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(Icons.list, color: Colors.white, size: 30.0),
                    )
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 16.0)),
                  Text('Recomended ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18.0)),
                  Text('Jobs ', style: TextStyle(color: Colors.black45)),
                ]
              ),
            ),
            onTap: () =>  Navigator.of(context).push(MaterialPageRoute(builder: (_) => RecommPage(tok: "${widget.usertoken}",first: 2.toString(),second: 3.toString(),third: 5.toString(),fourth: 7.toString(),))),
          ),
          _buildTile(
            Padding
            (
              padding: const EdgeInsets.all(24.0),
              child: Column
              (
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>
                [
                  Material
                  (
                    color: Colors.amber,
                    shape: CircleBorder(),
                    child: Padding
                    (
                      padding: EdgeInsets.all(16.0),
                      child: Icon(Icons.notifications, color: Colors.white, size: 30.0),
                    )
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 16.0)),
                  Text('Resonse', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24.0)),
                  Text('All ', style: TextStyle(color: Colors.black45)),
                ]
              ),
            ),
          ),
          // _buildTile(
          //   Padding
          //       (
          //         padding: const EdgeInsets.all(24.0),
          //         child: Column
          //         (
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: <Widget>
          //           [
          //             Row
          //             (
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: <Widget>
          //               [
          //                 Column
          //                 (
          //                   mainAxisAlignment: MainAxisAlignment.start,
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: <Widget>
          //                   [
          //                     Text('Result', style: TextStyle(color: Colors.green)),
          //                     Text('Graph', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 34.0)),
          //                   ],
          //                 ),
          //                 DropdownButton
          //                 (
          //                   isDense: true,
          //                   value: actualDropdown,
          //                   onChanged: (String value) => setState(()
          //                   {
          //                     actualDropdown = value;
          //                     actualChart = chartDropdownItems.indexOf(value).ceil(); // Refresh the chart
          //                   }),
          //                   items: chartDropdownItems.map((String title)
          //                   {
          //                     return DropdownMenuItem
          //                     (
          //                       value: title,
          //                       child: Text(title, style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w400, fontSize: 14.0)),
          //                     );
          //                   }).toList()
          //                 )
          //               ],
          //             ),
          //             Padding(padding: EdgeInsets.only(bottom: 4.0)),
          //             Sparkline
          //             (
          //               data: charts[actualChart],
          //               lineWidth: 3.0,
          //               lineColor: Colors.greenAccent,
          //             )
          //           ],
          //         )
          //       ),
          // ),
          _buildTile(
            Padding
            (
              padding: const EdgeInsets.all(24.0),
              child: Row
              (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>
                [
                  Column
                  (
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>
                    [
                      Text('List Of Jobs Around You', style: TextStyle(color: Colors.redAccent)),
                      Text('200', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 34.0))
                    ],
                  ),
                  Material
                  (
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(24.0),
                    child: Center
                    (
                      child: Padding
                      (
                        padding: EdgeInsets.all(16.0),
                        child: Icon(Icons.business, color: Colors.white, size: 30.0),
                      )
                    )
                  )
                ]
              ),
            ),
            onTap: () =>  Navigator.of(context).push(MaterialPageRoute(builder: (_) => SearchPage(title: "${widget.usertoken}",))),
          ),
           _buildTile(
            Padding
            (
              padding: const EdgeInsets.all(24.0),
              child: Column
              (
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>
                [
                  Material
                  (
                    color: Colors.lightBlueAccent,
                    shape: CircleBorder(),
                    child: Padding
                    (
                      padding: EdgeInsets.all(16.0),
                      child: Icon(Icons.find_in_page, color: Colors.white, size: 30.0),
                    )
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 16.0)),
                  Text('Job Prep Courses', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24.0)),
                  Text('All ', style: TextStyle(color: Colors.black45)),
                ]
              ),
            ),
            //onTap: () =>  Navigator.of(context).push(MaterialPageRoute(builder: (_) => RecomendedPage())),
          ),
        ],
        staggeredTiles: [
          StaggeredTile.extent(2, 110.0),
          StaggeredTile.extent(1, 180.0),
          StaggeredTile.extent(1, 180.0),
          //StaggeredTile.extent(2, 220.0),
          StaggeredTile.extent(2, 110.0),
          StaggeredTile.extent(2, 170.0),
        ],
      )
    );
  }

  Widget _buildTile(Widget child, {Function() onTap}) {
    return Material(
      elevation: 14.0,
      borderRadius: BorderRadius.circular(12.0),
      shadowColor: Color(0x802196F3),
      child: InkWell
      (
        // Do onTap() if it isn't null, otherwise do print()
        onTap: onTap != null ? () => onTap() : () { print('Not set yet'); },
        child: child
      )
    );
  }
}
