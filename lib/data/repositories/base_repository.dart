import 'dart:io';

import 'package:XLNT_APP/data/constans/constans.dart';
import 'package:flutter/material.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';
import 'dart:convert';

import 'interceptor/base_interceptor.dart';

class BaseRepository{
  final entity;
  HttpClientWithInterceptor client = HttpClientWithInterceptor.build(interceptors: [BaseInterceptor()]);
  BaseRepository({this.entity});

  Future<String> getPagination(int start,int pageSize) async {
    try {
      final response = await client.get('${MASTER_URL}/${entity}/Get${entity}sPagination?start=${start}&pageSize=${pageSize}');
      if (response.statusCode == 200) {
        return response.body;
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

  Future<String> delete(int id) async {
    try {
      final response = await client.delete('${MASTER_URL}/${entity}/Delete${entity}?id=${id}');
      if (response.statusCode == 200) {
        return response.body;
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

// typedef FromJsonT<T> = T Function(Object? json);
// typedef ToJsonT<T> = Object Function(T value);