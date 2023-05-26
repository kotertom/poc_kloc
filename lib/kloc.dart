import 'dart:async';

import 'package:meta/meta.dart';

abstract class Kloc<E> {
  final _eventController = StreamController<E>.broadcast();

  Stream<E> get events => _eventController.stream;

  @protected
  @nonVirtual
  void emit(E event) {
    _eventController.add(event);
  }

  @mustCallSuper
  Future<void> close() async {
    await _eventController.close();
  }
}
