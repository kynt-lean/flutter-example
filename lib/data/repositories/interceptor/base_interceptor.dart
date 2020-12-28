
import 'dart:io';

import 'package:http_interceptor/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseInterceptor  implements InterceptorContract {

  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";

    try {
      data.headers[HttpHeaders.contentTypeHeader] = "application/json";
      data.headers[HttpHeaders.authorizationHeader] =  "Bearer " + token;
    } catch (e) {
      print(e);
    }
    print(data.params);
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async => data;

}