import 'package:equatable/equatable.dart';

abstract class ModuleEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];

}

class  ModuleFetchEvent extends ModuleEvent{}

