part of 'cubit_counter_cubit.dart';

class CounterState {

  int counterValue= 0;
  bool loading;
  bool error;

  CounterState({required this.counterValue,
    this.loading= false, this.error= false});

}
