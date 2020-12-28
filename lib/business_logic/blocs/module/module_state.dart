

import 'package:XLNT_APP/data/models/general/module.dart';
import 'package:equatable/equatable.dart';

abstract class ModuleState extends Equatable{
  const ModuleState();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ModuleStateFailure extends ModuleState {}
class ModuleStateSuccess extends ModuleState {
  final List<Module> modules;
  final bool isLoading;
  const ModuleStateSuccess({this.modules,this.isLoading});

  @override
  String toString() => "modules : $modules, isLoading: ${isLoading}";

  @override
  // TODO: implement props
  List<Object> get props => [modules, isLoading];

  ModuleStateSuccess cloneWith({
    List<Module> modules,
    bool isLoading,
  }) {
    return ModuleStateSuccess(
        modules: modules ?? this.modules,
        isLoading: isLoading ?? this.isLoading
    );
  }
}
