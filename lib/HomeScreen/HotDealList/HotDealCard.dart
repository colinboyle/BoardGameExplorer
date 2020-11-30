import 'package:auto_size_text/auto_size_text.dart';
import 'package:board_game_app/ThreadDetail/ThreadDetail.dart';
import 'package:flutter/material.dart';


class HotDealCard extends StatelessWidget {
  final  hotDealData;
  HotDealCard(this.hotDealData);
  
  @override 
  Widget build(BuildContext context){
    return
      InkWell(
      onTap: () {openThread(context, hotDealData);},
      child: 
      Container(
        height: 55, 
        decoration: BoxDecoration(color: Colors.white, ), 
        margin: EdgeInsets.symmetric(horizontal: 5), 
        padding: EdgeInsets.all(5),
        child:
        Column(
          children: <Widget>[
            Row( 
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width -20,
                  child: AutoSizeText(
                    hotDealData.subject, 
                    maxLines: 2, 
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ]
            ),
            Spacer(),
            Row(
              children: <Widget>[
                Text(hotDealData.user.username),
                SizedBox(width: 10,),
                Icon(Icons.calendar_today, color: Colors.grey, size: 10),Text('${hotDealData.threadPostdate}'),
                SizedBox(width: 10,),
                Icon(Icons.thumb_up, color: Colors.grey, size: 10),Text('${hotDealData.numrecommend.toString()}'),
              ]
            ),
          ],
        ),
      )
    );
  }
  openThread(context, threadData){
    print('Thread id from onTap');
    print(threadData.threadid);
    Navigator.push(context, MaterialPageRoute(builder: (context) => ThreadDetail(threadData)));
  }
}