import 'package:flutter/material.dart';

class TrendingGameCard extends StatelessWidget{
  @override 
  Widget build(BuildContext context){
    return
      Container(
        width: 285,
        height: 190,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [new BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(5,5))]),
        margin: EdgeInsets.all(5),

        child:
          Stack(
            children: <Widget>[
              Positioned(top: 15, right: 10, child:IconButton(icon: Icon(Icons.favorite_border, color: Colors.black), alignment: Alignment.topRight, onPressed: (){}),),
              //],
              //child: 
              Row(
                children: <Widget>[
                 // Stack(
                    //children: <Widget>[
                      //Positioned(top: 10, right: 35, child:IconButton(icon: Icon(Icons.favorite_border, color: Colors.black), alignment: Alignment.topRight, onPressed: (){}),),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center, 
                        children: <Widget>[
                          Image.network('https://cf.geekdo-images.com/thumb/img/t9mRnhW6swyL2nPSScv9iroCyZQ=/fit-in/200x150/pic3615739.png')
                        ],
                      ),
                      SizedBox(width: 10),
                      //Padding(padding: EdgeInsets.all(5), child:
                      Expanded(
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(height: 10,),
                            RichText(text: TextSpan(children:[TextSpan(text:'Spirit'+'\n', style: TextStyle(color: Colors.black, fontSize: 18)),TextSpan(text:'ISLAND', style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w800))])),
                            Text('Greater than Games', style: TextStyle(fontSize: 13, color: Colors.black54),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Container(
                                  //width: 25,
                                  height: 15,
                                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.all(Radius.circular(10))),
                                  child: Padding(padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2), child: Text('Deck Building', style: Theme.of(context).textTheme.caption,),)
                                ),
                                Container(
                                  //width: 25,
                                  height: 15,
                                  decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.all(Radius.circular(10))),
                                  child: Padding(padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2), child: Text('Invader', style: Theme.of(context).textTheme.caption,),)
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Column(children: <Widget>[Icon(Icons.star, color: Colors.yellow, size: 20,),Text('8.2', style: Theme.of(context).textTheme.caption)]),
                                Column(children: <Widget>[Icon(Icons.group, color: Colors.grey, size: 20),Text('1-4',style: Theme.of(context).textTheme.caption)]),
                                Column(children: <Widget>[Icon(Icons.timer, color: Colors.blue, size: 20),Text('45-90',style: Theme.of(context).textTheme.caption)]),
                              ],
                            ),
                            SizedBox(height: 10,),
                          ],
                        )
                      ),
                    //],
                  //),
                ],
              ),
            ],
          )
      );

  }
}
