import 'dart:convert';

import 'package:XLNT_APP/data/enums/action_list_title_enum.dart';
import 'package:XLNT_APP/data/utilities/alert_service.dart';
import 'package:XLNT_APP/data/utilities/string_extension.dart';
import 'package:XLNT_APP/business_logic/blocs/item/item_bloc.dart';
import 'package:XLNT_APP/business_logic/blocs/item/item_event.dart';
import 'package:XLNT_APP/business_logic/blocs/item/item_state.dart';
import 'package:XLNT_APP/data/constans/constans.dart';
import 'package:XLNT_APP/presentation/screens/categories/item/components/item_row.dart';
import 'package:XLNT_APP/presentation/widgets/menu/notification_bell.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemScreen extends StatefulWidget {
  ItemScreen({Key key, this.title, this.color}) : super(key: key);

  final String title;
  final Color color;
  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ItemBloc _itemBloc;
  final _scrollController = ScrollController();
  final _scrollThreahold = 250.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _itemBloc = BlocProvider.of<ItemBloc>(context);
    _itemBloc..add(ItemRefeshEvent());
    _scrollController.addListener(() {
      final maxScrollExtent = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if (maxScrollExtent == currentScroll) {
        print("hihi");
        _itemBloc.add(ItemFetchEvent());
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF3F3F4),
        key: _scaffoldKey,
        appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
            ),
            backgroundColor: widget.color,
            title: Text(widget.title)
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: colorMain,
          onPressed: (){

          },
        ),
        body: BlocBuilder<ItemBloc, ItemState>(builder: (context, state) {
          if (state is ItemStateFailure) {
            return Center(
              child: Text("Lỗi server !",
                  style: TextStyle(fontSize: 22, color: Colors.red)),
            );
          } else {
            final currentState = state as ItemStateSuccess;
            if (currentState.isLoading) {
              return LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(colorMain));
            }
            if (currentState.Items.isEmpty) {
              return Center(child: Center(child: Text('Không có dữ liệu')));
            }
            return RefreshIndicator(
                onRefresh: () async {
                  // Handle refresh.
                  _itemBloc.add(ItemRefeshEvent());
                },
                child: ListView.builder(
                    itemBuilder: (BuildContext buildContext, int index) {
                      if (index >= currentState.Items.length) {
                        return Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(bottom: 15,top:20),
                          child: Center(
                            child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(colorMain)),
                          ),
                        );
                      } else {
                        return Container(
                            decoration: BoxDecoration(
                                color: index % 2 != 0
                                    ? colorBackgroud
                                    : Colors.white),
                            child: ItemRow(bloc: _itemBloc, index: index,currentState: currentState)
                        );
                      }
                    },
                    itemCount: currentState.hasReachedEnd
                        ? currentState.Items.length
                        : currentState.Items.length + 1,
                    controller: _scrollController));
          }
        }));
  }
}
