import 'dart:convert';
import 'dart:io';

import 'package:XLNT_APP/data/constans/constans.dart';
import 'package:XLNT_APP/data/models/general/module.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';

import '../interceptor/base_interceptor.dart';

class ModuleRepository{
  HttpClientWithInterceptor client = HttpClientWithInterceptor.build(interceptors: [BaseInterceptor()]);

  Future<List<Module>> getAllModule() async {
    try {
      final response = await client.get('${MASTER_URL}/Module/GetAll');
      if (response.statusCode == 200) {
        List res=jsonDecode(response.body);
        return res.map((e) => Module.fromJson(e)).toList();
      } else {
        return Future.error(
          "Error while fetching.",
          StackTrace.fromString("${response.body}"),
        );
      }
    } on SocketException {
      return Future.error('No Internet connection 😑');
    } on FormatException {
      return Future.error('Bad response format 👎');
    } on Exception {
      return Future.error('Unexpected error 😢');
    }
  }
}