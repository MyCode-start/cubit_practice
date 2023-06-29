import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'cubit_counter_state.dart';

class CounterCubit extends Cubit<CounterState> {

  CounterCubit() : super(CounterState(counterValue: 0));


  void increment() {

    emit (CounterState(counterValue: state.counterValue, loading: true ));

    var randomValue = Random().nextInt(10);
    print(randomValue);
     if(randomValue%2==0) {

       emit (CounterState(counterValue: state.counterValue, error: true ));

     } else {
       Timer(Duration(seconds:randomValue), (){
         emit(CounterState(counterValue: state.counterValue+1));
       }
       );
     }
  }

}
