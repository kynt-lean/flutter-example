class Item {
  int itemId;
  int itemTypeId;
  String itemTypeName;
  int isDevice;
  int itemGroupId;
  String itemGroupName;
  String itemCode;
  String itemName;
  String itemPrintName;
  String itemDescription;
  int itemUnitId;
  String itemUnitName;
  String itemModel;
  String itemSerial;
  String itemManufactureCountry;
  int itemManufactureYear;
  double itemLength;
  double itemWidth;
  double itemHeight;
  double itemWeight;
  String createBy;
  String createDate;
  String modifyBy;
  String modifyDate;
  int status;
  String statusName;

  Item(
      {this.itemId,
        this.itemTypeId,
        this.itemTypeName,
        this.isDevice,
        this.itemGroupId,
        this.itemGroupName,
        this.itemCode,
        this.itemName,
        this.itemPrintName,
        this.itemDescription,
        this.itemUnitId,
        this.itemUnitName,
        this.itemModel,
        this.itemSerial,
        this.itemManufactureCountry,
        this.itemManufactureYear,
        this.itemLength,
        this.itemWidth,
        this.itemHeight,
        this.itemWeight,
        this.createBy,
        this.createDate,
        this.modifyBy,
        this.modifyDate,
        this.status,
        this.statusName});

  Item.fromJson(Map<String, dynamic> json) {
    itemId = json['ItemId']??0;
    itemTypeId = json['ItemTypeId']??0;
    itemTypeName = json['ItemTypeName']??"";
    isDevice = json['IsDevice']??0;
    itemGroupId = json['ItemGroupId']??0;
    itemGroupName = json['ItemGroupName']??"";
    itemCode = json['ItemCode']??"";
    itemName = json['ItemName']??"";
    itemPrintName = json['ItemPrintName']??"";
    itemDescription = json['ItemDescription']??"";
    itemUnitId = json['ItemUnitId']??0;
    itemUnitName = json['ItemUnitName']??"";
    itemModel = json['ItemModel']??"";
    itemSerial = json['ItemSerial']??"";
    itemManufactureCountry = json['ItemManufactureCountry']??"";
    itemManufactureYear = json['ItemManufactureYear']??0;
    itemLength = json['ItemLength']??0;
    itemWidth = json['ItemWidth']??0;
    itemHeight = json['ItemHeight']??0;
    itemWeight = json['ItemWeight']??0;
    createBy = json['CreateBy']??"";
    createDate = json['CreateDate']??"";
    modifyBy = json['ModifyBy']??"";
    modifyDate = json['ModifyDate']??"";
    status = json['Status']??0;
    statusName = json['StatusName']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ItemId'] = this.itemId;
    data['ItemTypeId'] = this.itemTypeId;
    data['ItemTypeName'] = this.itemTypeName;
    data['IsDevice'] = this.isDevice;
    data['ItemGroupId'] = this.itemGroupId;
    data['ItemGroupName'] = this.itemGroupName;
    data['ItemCode'] = this.itemCode;
    data['ItemName'] = this.itemName;
    data['ItemPrintName'] = this.itemPrintName;
    data['ItemDescription'] = this.itemDescription;
    data['ItemUnitId'] = this.itemUnitId;
    data['ItemUnitName'] = this.itemUnitName;
    data['ItemModel'] = this.itemModel;
    data['ItemSerial'] = this.itemSerial;
    data['ItemManufactureCountry'] = this.itemManufactureCountry;
    data['ItemManufactureYear'] = this.itemManufactureYear;
    data['ItemLength'] = this.itemLength;
    data['ItemWidth'] = this.itemWidth;
    data['ItemHeight'] = this.itemHeight;
    data['ItemWeight'] = this.itemWeight;
    data['CreateBy'] = this.createBy;
    data['CreateDate'] = this.createDate;
    data['ModifyBy'] = this.modifyBy;
    data['ModifyDate'] = this.modifyDate;
    data['Status'] = this.status;
    data['StatusName'] = this.statusName;
    return data;
  }
}