import 'dart:io';

import 'package:XLNT_APP/business_logic/blocs/module/module_bloc.dart';
import 'package:XLNT_APP/business_logic/blocs/module/module_event.dart';
import 'package:XLNT_APP/business_logic/blocs/module/module_state.dart';
import 'package:XLNT_APP/data/constans/constans.dart';
import 'package:XLNT_APP/data/models/general/module.dart';
import 'package:XLNT_APP/data/repositories/systems/module_repository.dart';
import 'package:XLNT_APP/presentation/screens/default/components/module_item.dart';
import 'package:XLNT_APP/presentation/widgets/menu/draw_sidebar.dart';
import 'package:XLNT_APP/presentation/widgets/menu/notification_bell.dart';
import 'package:XLNT_APP/data/utilities/string_extension.dart';
import 'package:XLNT_APP/presentation/widgets/tab/custom_tab_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DefaultScreen extends StatefulWidget {
  DefaultScreen({Key key, this.title, this.color}) : super(key: key);

  final String title;
  final Color color;
  @override
  State<StatefulWidget> createState() => _DefaultScreen();
}

class _DefaultScreen extends State<DefaultScreen>
    with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ModuleBloc _moduleBloc;
  int initPositionTab = 0;
  @override
  void initState() {
    super.initState();
    _moduleBloc = BlocProvider.of<ModuleBloc>(context);
    _moduleBloc..add(ModuleFetchEvent());
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Color(0xFFF3F3F4),
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
            icon: Icon(Icons.apps_outlined),
            color: Colors.white,
          ),
          backgroundColor: widget.color,
          title: Text(widget.title),
          actions: [NotificationBell()],
        ),
        drawer: DrawMenu(),
        body: SafeArea(
            child: Container(
              child: BlocBuilder<ModuleBloc,ModuleState>(
                builder: (context,state){
                  if (state is ModuleStateFailure) {
                    return Center(
                      child: Text("Lỗi server !",
                          style: TextStyle(fontSize: 22, color: Colors.red)),
                    );
                  }
                  else{
                    final currentState = state as ModuleStateSuccess;
                    if(currentState.isLoading){
                      return LinearProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(colorMain));
                    }
                    else{


                      return  CustomTabView(
                        initPosition: initPositionTab,
                        itemCount: currentState.modules.length,
                        tabBuilder: (context, indexParent) => Tab(
                            text: context.locale.toString() == 'vi_VN'
                                ? currentState.modules[indexParent].NameVi
                                : currentState.modules[indexParent].NameEn),
                        pageBuilder: (context, indexParent) => Container(
                            margin: EdgeInsets.all(cDefaultPadding),
                            child: Container(
                                child: RefreshIndicator(
                                  onRefresh: () async {
                                    _moduleBloc.add(ModuleFetchEvent());
                                  },
                                  child: GridView.builder(
                                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 350,
                                        childAspectRatio: 3 / 2,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10),
                                    itemBuilder: (BuildContext context, int index) {
                                      return ModuleItem(
                                          function: currentState.modules[indexParent].Function[index]);
                                    },
                                    itemCount: currentState.modules[indexParent].Function.length,
                                  ),
                                ))),
                        onPositionChange: (index) {
                          print('current position: $index');
                          initPositionTab = index;
                        },
                        onScroll: (position) => print('$position'),
                      );
                    }
                  }

                },
              ),
        )),
      ),
      onWillPop: () => _willPopCallback(context),
    );
  }

  _willPopCallback(BuildContext context) async {
    print("back");
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('Bạn có chắc chắn muốn thoát ứng dụng?'),
      action: SnackBarAction(
        label: "Ok !",
        onPressed: () => {exit(0)},
      ),
    ));
    return Future.value(false);
  }
}
