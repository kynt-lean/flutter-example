class UserLogin{
  final String Address;
  final String DepartmentManager;
  final String Email;
  final String Title;
  final String Manager;

  UserLogin({this.Address, this.DepartmentManager, this.Email, this.Title,
    this.Manager});

  UserLogin.fromJson(Map<String,dynamic> map):
        Address =map["Address"],
        DepartmentManager =map["DepartmentManager"],
        Email =map["Email"],
        Title =map["Title"],
        Manager =map["Manager"];

  Map<String, dynamic> toJson() =>
      {
        'Address': Address,
        'DepartmentManager': DepartmentManager,
        'Email': Email,
        'Title': Title,
        'Manager': Manager
      };
}