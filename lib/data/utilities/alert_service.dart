
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import 'convert_utility.dart';

Future<void> showAlertDialog(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Column(
                children: [
                  Icon(Icons.warning,size: 50,color: Colors.amber),
                  SizedBox(height: 20),
                  Text('Tên người dùng hoặc mật khẩu không đúng, vui lòng kiểm tra lại.')
                ],
              )
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Đóng'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void showAlertDialogLoading(BuildContext context){
  AlertDialog alert=AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(valueColor:AlwaysStoppedAnimation<Color>(fromHex("#e04307"))),
        Container(margin: EdgeInsets.only(left: 5),child:Text("Đang tải dữ liệu" )),
      ],),
  );
  showDialog(barrierDismissible: false,
    context:context,
    builder:(BuildContext context){
      return alert;
    },
  );
}

void showAlertError(String title,String content) {
  BotToast.showNotification(
      leading: (cancel) => SizedBox.fromSize(
          size: const Size(40, 40),
          child: IconButton(
            icon: Icon(Icons.warning, color: Colors.red),
            onPressed: cancel,
          )),
      title: (_) => Text(title),
      subtitle: (_) => Text(content),
      trailing: (cancel) => IconButton(
        icon: Icon(Icons.cancel),
        onPressed: cancel,
      ),
      animationDuration:
      Duration(milliseconds: 200),
      animationReverseDuration:
      Duration(milliseconds: 200),
      duration: Duration(seconds: 2));
}

void showConfirmDelete(BuildContext context, String content,callBack){
  AlertDialog alert = AlertDialog(
    title: Text("Bạn có chắc chắn xóa ?",style: TextStyle(fontWeight: FontWeight.bold),),
    content: Text(content),
    actions: [
      TextButton(
        child: Text('Đóng'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      TextButton(
        child: Text('Xóa !',style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500),),
        onPressed: () {
          callBack();
        },
      ),
    ],
    elevation: 24,
  );

  showDialog(barrierDismissible: false,
    context:context,
    builder:(BuildContext context){
      return alert;
    },
  );
}