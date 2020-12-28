

import 'package:XLNT_APP/data/models/general/function.dart';

class Module {
  final int Id;
  final String NameVi;
  final String NameEn;
  final String Link;
  final int Status;
  final String Code;
  final List<FunctionVM> Function;
  Module(this.Id, this.NameVi, this.NameEn, this.Link, this.Status, this.Code,this.Function);
  Module.fromJson(Map<String,dynamic> map):
        Id =map["Id"],
        NameVi = map["NameVi"],
        NameEn = map["NameEn"],
        Link = map["Link"],
        Status = map["Status"],
        Code = map["Code"]??"",
        Function =(map["Function"] as List).map((e) => FunctionVM.fromJson(e)).toList();

}

