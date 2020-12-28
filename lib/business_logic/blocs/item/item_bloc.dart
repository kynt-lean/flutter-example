
import 'dart:convert';

import 'package:XLNT_APP/business_logic/blocs/item/item_event.dart';
import 'package:XLNT_APP/business_logic/blocs/item/item_state.dart';
import 'package:XLNT_APP/data/models/categories/items/item.dart';
import 'package:XLNT_APP/data/repositories/items/item_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemBloc extends Bloc<ItemEvent,ItemState>{
  final ITEM_PER_PAGE = 20;

  ItemBloc() : super(ItemStateSuccess(Items:[],hasReachedEnd: false,isLoading: true));

  @override
  Stream<ItemState> mapEventToState(ItemEvent event) async* {
    ItemRepository _itemRepository = new ItemRepository();
    try{
      if(event is ItemRefeshEvent){
        yield ItemStateSuccess(Items:[],hasReachedEnd: false,isLoading: true);
        final String response = await _itemRepository.getPagination(0,ITEM_PER_PAGE);
        List res=jsonDecode(response);
        List<Item> items =  res.map((e) => Item.fromJson(e)).toList();
        yield ItemStateSuccess(Items:items,hasReachedEnd: false,isLoading: false);
      }
      else{
        final hasReachedEndOfOnePage = (state is ItemStateSuccess && (state as  ItemStateSuccess).hasReachedEnd);
        if(event is ItemFetchEvent && !hasReachedEndOfOnePage){
          if(state is  ItemStateSuccess){
            final currentState = state as ItemStateSuccess;
            int finalIndexOfCurrentPage =(state as ItemStateSuccess).Items.length;
            final String response = await _itemRepository.getPagination(finalIndexOfCurrentPage,ITEM_PER_PAGE);
            List res=jsonDecode(response);
            List<Item> items =  res.map((e) => Item.fromJson(e)).toList();
            if(items.isEmpty){
              yield (state as ItemStateSuccess).cloneWith(hasReachedEnd: true,isLoading: false);
            }
            else{
              yield ItemStateSuccess(
                  Items: currentState.Items + items,
                  hasReachedEnd: false,
                  isLoading: false
              );
            }
          }
        }
      }
    }
    catch(ex){
      yield ItemStateFailure();
    }
  }

}