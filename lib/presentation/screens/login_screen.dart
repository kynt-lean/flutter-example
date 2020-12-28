import 'dart:convert';
import 'dart:io';

import 'package:XLNT_APP/data/constans/constans.dart';
import 'package:XLNT_APP/data/models/general/user_login.dart';
import 'package:XLNT_APP/data/repositories/systems/authen_repository.dart';
import 'package:XLNT_APP/data/utilities/alert_service.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LoginScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState()  => _LoginScreen();

}

class _LoginScreen extends State<LoginScreen> {
  AuthenRepository _authenRepository = new AuthenRepository();

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String username;
  String password;
  @override
  Widget build(BuildContext context) {

     _willPopCallback(BuildContext context)  async{
      print("back");
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text('Bạn có chắc chắn muốn thoát ứng dụng ?'),
            action: SnackBarAction(
              label: "Ok !",
              onPressed: ()=>{
                exit(0)
              },
            ),
          ));
      return Future.value(false);
    }

    void _loginApp() async{
      final SharedPreferences  prefs = await _prefs;
      showAlertDialogLoading(context);
      var authenResult = await _authenRepository.login(username.trim(),password.trim());
      Navigator.pop(context);
      if(authenResult!=null && authenResult.Success){
        prefs.setString("token", authenResult.Token);

        UserLogin userLogin =await _authenRepository.getEofficeUser(username);
        if(userLogin!=null){
          prefs.setString("user",jsonEncode(userLogin));
          print(prefs.getString("user"));
        }
        Navigator.of(context).pushNamed('/default');
      }
      else{
        showAlertError("Thông báo lỗi","Tên người dùng hoặc mật khẩu không đúng, vui lòng kiểm tra lại.");
      }
    }

    return WillPopScope(
      child:  Scaffold(
          key: _scaffoldKey,
          body: SafeArea(
              child: Center(
                child: Stack(
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child:  Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 250,
                              child: Image.asset('assets/images/becamex-logonew.png'),
                            ),
                            SizedBox(height: 50),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(tr('authen.login'), style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: kTextColor,letterSpacing: 0.7),)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(tr('authen.loginSubTitle'), style: TextStyle(fontSize:13,fontWeight: FontWeight.w400,color: kTextColor,letterSpacing: 0.7),)
                              ],
                            ),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 30),
                                  TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return tr('authen.loginNullAcc');
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        labelText: tr('authen.account'),
                                        hintText: tr('authen.accPlaceholder'),
                                        hintStyle: TextStyle(color: kTextColor,fontWeight: FontWeight.w400,fontSize: 13),
                                        labelStyle: TextStyle(color: kTextColor,fontWeight: FontWeight.w400,fontSize: 13),
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                        contentPadding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          borderSide: BorderSide(color: kTextColor),
                                          gapPadding: 10,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          borderSide: BorderSide(color: kTextColor),
                                          gapPadding: 10,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          borderSide: BorderSide(color: kTextColor),
                                          gapPadding: 10,
                                        ),
                                        suffixIcon: Icon(Icons.mail_outline,size: 20,color: Colors.black87)
                                    ),
                                    onChanged: (val){
                                      if(val.isNotEmpty){
                                        _formKey.currentState.validate();
                                        setState(() {
                                          username = val;
                                        });
                                      }
                                    },
                                  ),
                                  SizedBox(height: 30,),
                                  TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return tr('authen.loginNullPass');
                                      }
                                      return null;
                                    },
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        labelText:tr('authen.password'),
                                        hintText: tr('authen.passPlaceholder'),
                                        hintStyle: TextStyle(color: kTextColor,fontWeight: FontWeight.w400,fontSize: 13),
                                        labelStyle: TextStyle(color: kTextColor,fontWeight: FontWeight.w400,fontSize: 13),
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                        contentPadding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          borderSide: BorderSide(color: kTextColor),
                                          gapPadding: 10,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          borderSide: BorderSide(color: kTextColor),
                                          gapPadding: 10,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          borderSide: BorderSide(color: kTextColor),
                                          gapPadding: 10,
                                        ),
                                        suffixIcon: Icon(Icons.lock_outline,size: 20,color: Colors.black87)
                                    ),
                                    onChanged: (val){
                                      if(val.isNotEmpty){
                                        _formKey.currentState.validate();
                                        setState(() {
                                          password = val;
                                        });
                                      }
                                    },
                                  ),
                                  SizedBox(height: 20,),
                                  FlatButton(
                                    child: Container(
                                        width: 120,
                                        height: 45,
                                        padding: EdgeInsets.all(cDefaultPadding),
                                        decoration: BoxDecoration(
                                            color: colorMain,
                                            borderRadius: BorderRadius.circular(22.5)
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(tr('authen.login'),style: TextStyle(color: Colors.white,letterSpacing: 0.4,fontSize: 15,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                                          ],
                                        )
                                    ),
                                    onPressed: ()  async{
                                      if(_formKey.currentState.validate()){
                                        _loginApp();
                                      }
                                    },
                                  ),
                                  //FormError(errors: errors,),
                                ],
                              ),
                            ),
                            SizedBox(height: 20,),
                            Text('Ngôn ngữ / Language'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                    onTap:  () async {
                                      //await allTranslations.setNewLanguage('vi',true);
                                      print("Viet nam");
                                      context.locale = Locale('vi', 'VN');
                                      setState(() {});
                                    },
                                    child: Container(
                                      width: 42,
                                      child: Image.asset('assets/images/Vietnam.png'),
                                    )),
                                GestureDetector(
                                    onTap:  () async {
                                     // await allTranslations.setNewLanguage('en',true);
                                      print("English");
                                      context.locale = Locale('en', 'US');
                                      setState(() {});
                                    },
                                    child: Container(
                                      width: 42,
                                      child: Image.asset('assets/images/United-States.png'),
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
          )
      ),
      onWillPop: ()=>_willPopCallback(context),
    );
  }
}