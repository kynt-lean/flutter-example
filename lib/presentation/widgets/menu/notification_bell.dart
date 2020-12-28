

import 'package:flutter/material.dart';

class NotificationBell extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _NotificationBell();
}

class _NotificationBell extends State<NotificationBell> {
  int itemCount =6;


  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(10.0),
      child: new Container(
        child: new GestureDetector(
          onTap: () {},
          child: Stack(
            children: <Widget>[
              new IconButton(
                  icon: new Icon(
                    Icons.notifications_sharp,
                    color: Colors.white,
                  ),
                  onPressed: () {}),
              itemCount == 0
                  ? new Container()
                  : new Positioned(
                  right: 0,
                  child: new Stack(
                    children: <Widget>[
                      new Icon(Icons.brightness_1,
                          size: 20.0, color: Colors.orange.shade500),
                      new Positioned(
                          top: 3.0,
                          right: 6.0,
                          child: new Center(
                            child: new Text(
                              itemCount.toString(),
                              style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          )),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

}