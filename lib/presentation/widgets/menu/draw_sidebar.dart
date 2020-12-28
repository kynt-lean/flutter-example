
import 'dart:convert';

import 'package:XLNT_APP/data/models/general/user_login.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
class DrawMenu extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _DrawMenu();

}

class _DrawMenu extends State<DrawMenu> {
  String fullname;
  UserLogin userLogin = new UserLogin();
  String currentLocale;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLogin();
  }

  Future<Null> getUserLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString("user") ?? "";
    if (user.isNotEmpty)
    {
      Map<String, dynamic> map = jsonDecode(user);
       setState(() {
         userLogin = UserLogin.fromJson(map);
       });
    }
    else
    {
      Navigator.of(context).pushNamed('/login');
    }
  }


  @override
  Widget build(BuildContext context) {
   currentLocale = context.locale.toString();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg.png'),
                  fit:  BoxFit.cover
              )
            ),
            accountName: Text(userLogin.Title??"", style: TextStyle(color: Colors.orangeAccent,fontWeight: FontWeight.bold)),
            accountEmail: Text(userLogin.Email??"", style: TextStyle(color: Colors.orangeAccent,fontWeight: FontWeight.w500)),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile.jpg'),
            ),
          ),
          ListTile(
            title: Text('Tiếng Việt'),
            trailing: Wrap(
              spacing: 12, // space between two icons
              children: <Widget>[
                currentLocale =='vi_VN' ?Icon(Icons.check,size: 12):SizedBox(width:0.1)
              ],
            ),
            leading: Image(image: AssetImage('assets/images/Vietnam.png')),
            onTap: () {
              context.locale = Locale('vi', 'VN');
              Navigator.pop(context);
            },

          ),
          ListTile(
            title: Text('Tiếng Anh'),
            trailing: Wrap(
              spacing: 12, // space between two icons
              children: <Widget>[
                currentLocale =='en_US' ?Icon(Icons.check,size: 12):SizedBox(width:0.1)
              ],
            ),
            leading: Image(image: AssetImage('assets/images/United-States.png')),
            onTap: () {
              context.locale = Locale('en', 'US');
              Navigator.pop(context);
            },
          ),
          const Divider(color: Colors.red,height: 5,),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(tr("authen.logout")),
            onTap: () async{
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove('token');
              Navigator.of(context).pushNamed('/login');
            },
          ),
        ],
      ),
    );
  }
}

