

import 'package:XLNT_APP/data/models/categories/items/item.dart';
import 'package:XLNT_APP/data/models/general/operation_result.dart';
import 'package:equatable/equatable.dart';

abstract class ItemState extends Equatable{
  const ItemState();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ItemStateFailure extends ItemState {}
class ItemStateSuccess extends ItemState {
  final List<Item> Items;
  final bool hasReachedEnd;
  final bool isLoading;
  const ItemStateSuccess({this.Items, this.hasReachedEnd,this.isLoading});

  @override
  String toString() => "Items : $Items, hasReachedEnd: $hasReachedEnd, isLoading: ${isLoading}";

  @override
  // TODO: implement props
  List<Object> get props => [Items, hasReachedEnd,isLoading];

  ItemStateSuccess cloneWith({
    List<Item> Items,
    bool hasReachedEnd,
    bool isLoading,
  }) {
    return ItemStateSuccess(
        Items: Items ?? this.Items,
        hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
        isLoading: isLoading ?? this.isLoading
    );
  }
}
