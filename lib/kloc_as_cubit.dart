import 'package:meta/meta.dart';
import 'package:poc_kloc/kloc.dart';

@immutable
class StateChangedEvent<S> {
  const StateChangedEvent(this.state);

  final S state;
}

/// A base Kloc that behaves like a Cubit and has a similar api
abstract class CubitKloc<S> extends Kloc<StateChangedEvent<S>> {
  CubitKloc(S initialState) : _state = initialState;

  S _state;
  S get state => _state;

  /// Same as Cubit's emit
  @protected
  @nonVirtual
  set state(S newState) {
    if (newState == _state) return;
    _state = newState;
    emit(StateChangedEvent(newState));
  }

  Stream<S> get stream => events.map((e) => e.state);
}
