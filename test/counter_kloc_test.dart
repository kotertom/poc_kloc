import 'package:flutter_test/flutter_test.dart';
import 'package:poc_kloc/counter_kloc.dart';

void main() {
  group('CounterKloc', () {
    test(
      'Initial state is 0',
      () {
        final counter = CounterKloc();

        expect(counter.value, equals(0));
      },
    );

    test(
      'Calling increment emits the increment event and increases value by 1',
      () {
        final counter = CounterKloc();

        assert(counter.value == 0);

        expectLater(
          counter.events,
          emitsInOrder([CounterEvent.increment, emitsDone]),
        );

        counter
          ..increment()
          ..close();

        expect(counter.value, equals(1));
      },
    );

    test(
      'Calling increment 3 times synchronously emits the increment '
      'event 3 times and increases value by a total of 3',
      () {
        final counter = CounterKloc();

        assert(counter.value == 0);

        expectLater(
          counter.events,
          emitsInOrder([
            CounterEvent.increment,
            CounterEvent.increment,
            CounterEvent.increment,
            emitsDone,
          ]),
        );

        counter
          ..increment()
          ..increment()
          ..increment()
          ..close();

        expect(counter.value, equals(3));
      },
    );

    test(
      'When events are emitted synchronously the listeners read the state '
      'after the final event; i.e. calling increment 3 times results in the '
      'listener printing value "3" 3 times',
      () {
        final counter = CounterKloc();

        assert(counter.value == 0);

        final values = counter.events.map((event) => counter.value);

        expectLater(values, emitsInOrder([3, 3, 3, emitsDone]));

        counter
          ..increment()
          ..increment()
          ..increment()
          ..close();

        expect(counter.value, equals(3));
      },
    );
  });
}
