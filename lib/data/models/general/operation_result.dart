class OperationResult {
  String caption;
  String message;
  bool success;
  String data;
  Object dataResult;
  List<String> validateData;

  OperationResult(
      {this.caption,
        this.message,
        this.success,
        this.data,
        this.dataResult,
        this.validateData});

  OperationResult.fromJson(Map<String, dynamic> json) {
    caption = json['Caption'];
    message = json['Message'];
    success = json['Success'];
    data = json['Data'];
    dataResult = json['DataResult'];
    validateData = json['ValidateData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Caption'] = this.caption;
    data['Message'] = this.message;
    data['Success'] = this.success;
    data['Data'] = this.data;
    data['DataResult'] = this.dataResult;
    data['ValidateData'] = this.validateData;
    return data;
  }
}