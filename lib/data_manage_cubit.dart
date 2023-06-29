import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'data_manage_state.dart';

class DataManageCubit extends Cubit<DataManageState> {
  DataManageCubit() : super(DataManageState(arrData:[{'name':'Enter Name',
    'class':'5th Standard'}] ));

  void addDataList ({required Map<String, dynamic> value}) {

    emit (DataManageState(arrData: state.arrData, loading: true));

    Timer(Duration(seconds:4), (){
      state.arrData.add(value);
      emit(DataManageState(arrData: state.arrData));
    }
    );

    /*Timer(Duration(seconds: 4), () {
      final List<Map<String, dynamic>> updatedList = List.from(state.arrData);
      updatedList.add(value);
      emit(DataManageState(arrData: updatedList));
    }*/


  }
}
