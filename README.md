# poc_kloc

An idea for a mix between [bloc's](https://bloclibrary.dev/#/) Cubit and flutter's ChangeNotifier, with something extra. Prior knowledge of how these two work is recommended.


Feature\Implementation|Cubit|ChangeNotifier|kloc|
|---|---|---|---|
|observability|`cubit.stream` (stream)|`changeNotifier.addListener` (callback registration)|`kloc.events` (stream)|
|notifies when|state changes|whenever they want|whenever they want|
|notification payload|new state|nothing|whatever they want (e.g. an event that occurred)|

## Example

This repo contains just a simple demo app with a counter, you can just `flutter run` it in chrome

## Introduction

A cubit allows to observe state but an observer does not know what kind of event introduced that change, nor what exactly changed (unless employing some kind of diffing strategy, which essentially reverse engineers the state change to obtain the initial event that introduced it). It's also worth noting that while a cubit is an object, it keeps its observable state in a single, entirely separate object, which feels to me somewhat unusual regarding traditional OOP. It's not wrong and it's the only way to represent union types I can think of anyway, which is a common use case for cubits, but it just feels weird.

On the other hand we have the extremely simple and less opinionated ChangeNotifier. The only thing it does is it allows us to make an object observable and the object's implementation decides when to notify its listeners about a change. Just like the Cubit, it doesn't let us specify what event actually took place and what changed. Unlike the Cubit, though, the entire object that extends a ChangeNotifier is "observable". A downside of ChangeNotifier is that it's defined inside the flutter package, so it's not really framework agnostic.

Enter [Kloc](lib/kloc.dart) (it's not a serious experiment and I had no idea how to name it); it looks almost like a cubit and works almost like a cubit, with a slight difference: instead of a stream of states that change over time it exposes a stream of events. Just like you would define state for your cubit, you define what events can take place inside your kloc. For example: a CounterCubit's state is an integer. Calling the `CounterCubit.increment` method emits a new state with its value increased by 1. Similarily a CounterKloc has a public integer field that stores the counter's value and calling the `CounterKloc.increment` method increases it by 1, but while the CounterCubit emits the new state in its state stream, the CounterKloc emits a "counter incremented" event that conveys information what happened. In reaction to the event an observer can inspect the CounterKloc instance to obtain the new value. This way the kloc conveys more information than the cubit. In cubit's case we only know that the value changed. In kloc's case we know that the counter was incremented and we know its new value. It's entirely possible to implement a cubit using kloc, simply by having a single event like "state changed" -- after all this all we know when a cubit emits a new state. See [lib/kloc_as_cubit.dart](lib/kloc_as_cubit.dart) for a rudimentary implementation.
