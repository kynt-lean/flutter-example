
import 'dart:convert';

import 'package:XLNT_APP/business_logic/blocs/module/module_event.dart';
import 'package:XLNT_APP/business_logic/blocs/module/module_state.dart';
import 'package:XLNT_APP/data/models/general/module.dart';
import 'package:XLNT_APP/data/repositories/systems/module_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ModuleBloc extends Bloc<ModuleEvent,ModuleState>{
  ModuleBloc() : super(ModuleStateSuccess(modules:[],isLoading: true));

  @override
  Stream<ModuleState> mapEventToState(ModuleEvent event) async* {
    ModuleRepository _moduleRepository = new ModuleRepository();
    try{
      yield ModuleStateSuccess(modules:[],isLoading: true);
      final List<Module> modules = await _moduleRepository.getAllModule();
      yield ModuleStateSuccess(modules:modules.where((element) => element.Status == 1).toList(),isLoading: false);
    }
    catch(ex){
      yield ModuleStateFailure();
    }
  }

}