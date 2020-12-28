
import 'dart:convert';
import 'package:XLNT_APP/data/constans/constans.dart';
import 'package:XLNT_APP/data/models/general/authentication_result.dart';
import 'package:XLNT_APP/data/models/general/user_login.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';

import '../interceptor/base_interceptor.dart';


class AuthenRepository{
  HttpClientWithInterceptor client = HttpClientWithInterceptor.build(interceptors: [BaseInterceptor()]);

  Future<AuthenticationResult> login(username,password) async{
    final url = "${AUTH_URL}/identity/login";
    try{
      final request = {'username': username, 'password': password, 'rememberMe': true};
      final response = await client.post(url,body: jsonEncode(request));
      if(response.statusCode ==200){
        return AuthenticationResult.fromJson(jsonDecode(response.body));
      }
      else{
        return null;
      }
    }
    catch(ex){
      return null;
    }
  }

  Future<UserLogin> getEofficeUser(username) async{
    final url = "${AUTH_URL}/identity/getEOfficeUserInfo";
    try{
      final request = {'Account': username.toLowerCase()};
      final response = await client.post(url,body: jsonEncode(request));
      if(response.statusCode ==200){
        List res=jsonDecode(response.body);

        UserLogin userLogin = new UserLogin();
        var listUser = res.map((e) => UserLogin.fromJson(e)).toList();
        if(listUser.length>0){
           userLogin = listUser.first;
        }
        return userLogin;
      }
      else{
        return null;
      }
    }
    catch(ex){
      return null;
    }
  }
}