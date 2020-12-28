import 'package:XLNT_APP/data/constans/constans.dart';
import 'package:XLNT_APP/data/models/categories/items/item.dart';
import 'package:XLNT_APP/data/utilities/string_extension.dart';
import 'package:XLNT_APP/presentation/screens/categories/item/components/item_row_detail.dart';
import 'package:XLNT_APP/presentation/widgets/tab/custom_tab_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

class ItemDetailScreen extends StatefulWidget {
  final String title;
  final Color color;
  final Item item;

  const ItemDetailScreen({Key key, this.title, this.color, this.item})
      : super(key: key);
  @override
  _ItemDetailScreenState createState() => _ItemDetailScreenState(item);
}

class _ItemDetailScreenState extends State<ItemDetailScreen>
    with SingleTickerProviderStateMixin {
  int initPositionTab = 1;
  TabController tabController;
  final Item item;
  _ItemDetailScreenState(this.item);

  //table
  final columns = 5;
  final rows = 4;

  List<List<String>> makeData() {
    final List<List<String>> output = [];
    for (int i = 0; i < columns; i++) {
      final List<String> row = [];
      for (int j = 0; j < rows; j++) {
        row.add('T$i : L$j');
      }
      output.add(row);
    }
    return output;
  }

  /// Simple generator for column title
  List<String> makeTitleColumn() => List.generate(columns, (i) => 'Top $i');

  /// Simple generator for row title
  List<String> makeTitleRow() => List.generate(rows, (i) => 'Left $i');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(vsync: this, length: 5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
            color: Colors.white,
          ),
          backgroundColor: widget.color,
          title: Text(widget.title)),
      body: Container(
          padding: EdgeInsets.all(10),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Container(
                child: Column(
                  children: [
                    ItemRowDetail(title: "Tên vật tư: ", value: item.itemName),
                    ItemRowDetail(title: "Mã vật tư: ", value: item.itemCode),
                    ItemRowDetail(
                        title: "Đơn vị tính: ", value: item.itemUnitName),
                    ItemRowDetail(title: "Tên in: ", value: item.itemPrintName),
                    ItemRowDetail(
                        title: "Quốc gia: ",
                        value: item.itemManufactureCountry),
                    ItemRowDetail(
                        title: "Năm sản xuất: ",
                        value: item.itemManufactureYear.toString()),
                    ItemRowDetail(title: "Nhãn hiệu: ", value: item.itemModel),
                    ItemRowDetail(title: "Số Serial: ", value: item.itemSerial),
                    ItemRowDetail(
                        title: "Dài: ", value: item.itemLength.toString()),
                    ItemRowDetail(
                        title: "Rộng: ", value: item.itemWidth.toString()),
                    ItemRowDetail(
                        title: "Cao: ", value: item.itemHeight.toString()),
                    ItemRowDetail(
                        title: "Nặng: ", value: item.itemWeight.toString()),
                    ItemRowDetail(
                        title: "Loại vật tư: ", value: item.itemTypeName),
                    ItemRowDetail(
                        title: "Nhóm vật tư: ", value: item.itemGroupName),
                    ItemRowDetail(
                        title: "Mô tả: ", value: item.itemDescription),
                    ItemRowDetail(
                        title: "Tình trạng: ", value: item.statusName),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: TabBar(
                    controller: tabController,
                    indicatorColor: colorMain,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorWeight: 3.0,
                    isScrollable: true,
                    labelColor: colorMain,
                    labelStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500
                    ),

                    unselectedLabelColor: Color(0xFF000000),
                    tabs: [
                      Tab(text: "Nhà máy"),
                      Tab(text: "Thuộc tính"),
                      Tab(text: "Đóng gói"),
                      Tab(text: "Tệp đính kèm"),
                      Tab(text: "Hình"),
                    ]),
              ),
              Container(
                padding: EdgeInsets.all(10),
                //Add this to give height
                height: MediaQuery.of(context).size.height,
                child: TabBarView(controller: tabController, children: [
                  Container(
                    child: StickyHeadersTable(
                      columnsLength: makeTitleColumn().length,
                      rowsLength: makeTitleRow().length,
                      columnsTitleBuilder: (i) => Text(makeTitleColumn()[i]),
                      rowsTitleBuilder: (i) => Text(makeTitleRow()[i]),
                      contentCellBuilder: (i, j) => Text(makeData()[i][j]),
                      legendCell: Text('Sticky Legend'),
                    ),
                  ),
                  Container(
                    child: Text("Articles Body"),
                  ),
                  Container(
                    child: Text("User Body"),
                  ),
                  Container(
                    child: Text("tệp Body"),
                  ),
                  Container(
                    child: Text("hình Body"),
                  ),
                ]),
              ),
            ],
          )),
    );
  }
}
