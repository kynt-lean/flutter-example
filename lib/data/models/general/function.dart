class FunctionVM {
  final int Id;
  final int ModuleId;
  final String NameVi;
  final String NameEn;
  final String Link;
  final String IconApp;
  final String LinkApp;
  final int Status;
  final String Code;
  FunctionVM(this.Id,this.ModuleId, this.NameVi, this.NameEn, this.Link,this.IconApp,this.LinkApp, this.Status, this.Code);
  FunctionVM.fromJson(Map<String,dynamic> map):
        Id =map["Id"],
        ModuleId =map["ModuleId"],
        NameVi = map["NameVi"],
        NameEn = map["NameEn"],
        Link = map["Link"],
        IconApp = map["IconApp"],
        LinkApp = map["LinkApp"],
        Status = map["Status"],
        Code = map["Code"]??"";

}

