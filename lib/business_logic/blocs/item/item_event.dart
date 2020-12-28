

import 'package:equatable/equatable.dart';

abstract class ItemEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];

}

class  ItemFetchEvent extends ItemEvent{}

class  ItemRefeshEvent extends ItemEvent{}

