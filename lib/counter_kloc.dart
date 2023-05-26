import 'package:poc_kloc/kloc.dart';

enum CounterEvent {
  increment,
  decrement,
}

class CounterKloc extends Kloc<CounterEvent> {
  var _value = 0;
  int get value => _value;

  void increment() {
    _value++;
    emit(CounterEvent.increment);
  }

  void decrement() {
    _value--;
    emit(CounterEvent.decrement);
  }
}
