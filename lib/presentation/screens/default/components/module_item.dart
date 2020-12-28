
import 'package:XLNT_APP/data/constans/constans.dart';
import 'package:XLNT_APP/data/models/general/function.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ModuleItem extends StatelessWidget{
   FunctionVM function;
   ModuleItem({ this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
      // Navigator.push(
      // context,
      // MaterialPageRoute(builder: (context) => {}),
      // )
      },
      child: InkWell(
        child: Card(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network('${MASTER_URL_IMAGE}/${function.IconApp}',width: 40, height: 40,),
                    SizedBox(height: 10),
                    Text("${ context.locale.toString() =='vi_VN'?function.NameVi:function.NameEn }", style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center)
                  ],
                ),
              ),
            )
        ),
        onTap: ()=>{
          Navigator.pushNamed(context, function.LinkApp)
        },
      )
    );
  }

}

