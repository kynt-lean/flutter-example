import 'package:XLNT_APP/data/models/categories/items/item.dart';
import 'package:XLNT_APP/data/utilities/string_extension.dart';
import 'package:flutter/material.dart';
class ItemRowDetail extends StatelessWidget {
  final  String title;
  final String value;

  const ItemRowDetail({Key key, this.title, this.value}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          border:Border(
            bottom: BorderSide(
              color: Color(0xffcccccc),
              width: 0.5,
            )
          ),
      ),
      margin: EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700)),
          SizedBox(width: 15),
          Expanded(child: Text(value.toTitleCase(),style:  TextStyle(fontSize: 16),textAlign: TextAlign.right,))
        ],
      ),
    );
  }
}
