import 'dart:convert';

import 'package:XLNT_APP/business_logic/blocs/item/item_bloc.dart';
import 'package:XLNT_APP/business_logic/blocs/item/item_event.dart';
import 'package:XLNT_APP/business_logic/blocs/item/item_state.dart';
import 'package:XLNT_APP/data/constans/constans.dart';
import 'package:XLNT_APP/data/enums/action_list_title_enum.dart';
import 'package:XLNT_APP/data/models/general/operation_result.dart';
import 'package:XLNT_APP/data/repositories/items/item_repository.dart';
import 'package:XLNT_APP/data/utilities/alert_service.dart';
import 'package:XLNT_APP/presentation/screens/categories/item/item_detail_screen.dart';
import 'package:flutter/material.dart';

class ItemRow extends StatelessWidget {

  final int index;
  final ItemBloc bloc;
  final ItemStateSuccess currentState;
  ItemRepository _itemRepository = new ItemRepository();

  ItemRow({Key key, this.index, this.bloc, this.currentState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        Navigator.pushNamed(context, "/category/item/detail",arguments: currentState.Items[index]);
      },
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            color: colorMain,
            borderRadius: BorderRadius.circular(50)),
        child: Center(
          child: Text(
            '${index + 1}',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      title: Text(
          "${currentState.Items[index].itemName}",
          style:
          TextStyle(fontWeight: FontWeight.bold)),
      isThreeLine: true,
      subtitle: RichText(
        text: TextSpan(children: <TextSpan>[
          TextSpan(
              text: "Đơn vị tính : ",
              style: TextStyle(
                  color: kTextColor, fontSize: 12)),
          TextSpan(
              text: currentState
                  .Items[index].itemUnitName,
              style: TextStyle(
                  color: kTextColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500))
        ]),
      ),
      trailing: PopupMenuButton<ActionList>(
        onSelected: (ActionList result) {
          if (result == ActionList.DELETE) {
            String content = currentState.Items[index].itemName +" sẽ bị xóa khỏi danh sách vật tư !";
                   showConfirmDelete(context, content,
                    () async {
                         String response = await _itemRepository.delete(currentState.Items[index].itemId);
                          OperationResult result = OperationResult.fromJson(jsonDecode(response));
                          if(result.success){
                            bloc.add(ItemRefeshEvent());
                            SnackBar snackBar = SnackBar(content: Text("Xóa thành công! Đang tải lại dữ liệu..."));
                            Scaffold.of(context).showSnackBar(snackBar);
                          }
                          else{
                            showAlertError("Lỗi","Dữ liệu đã phát sinh! Không được xóa.");
                          }
                         Navigator.pop(context);
                    });
          } else {
            //Chỉnh sửa
          }
        },
        itemBuilder: (BuildContext context) =>
        <PopupMenuEntry<ActionList>>[
          const PopupMenuItem<ActionList>(
            value: ActionList.EDIT,
            child: ListTile(
              leading: Icon(Icons.edit),
              title: Text('Chỉnh sửa'),
            ),
          ),
          const PopupMenuItem<ActionList>(
            value: ActionList.DELETE,
            child: ListTile(
              leading: Icon(Icons.delete),
              title: Text('Xóa'),

            ),
          )
        ],
      ),
    );
  }
}
