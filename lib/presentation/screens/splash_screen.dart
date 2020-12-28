import 'dart:async';

import 'package:XLNT_APP/data/utilities/convert_utility.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  String token;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    getSharedPrefs();
  }

  Future<Null> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token") ?? "";
    Timer(
        Duration(seconds: 3),
            () => {
          if (token.isNotEmpty && !JwtDecoder.isExpired(token))
            Navigator.of(context).pushNamed('/default')
          else
            Navigator.of(context).pushNamed('/login')
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 250,
                        child: Image.asset('assets/images/becamex-logonew.png'),
                      ),
                      Text(
                        tr("main.title"),
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(fromHex("#e04307"))),
                    SizedBox(height: 20),
                    Text(
                      tr("main.copyright"),
                      style: TextStyle(color: fromHex("#e04307")),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
