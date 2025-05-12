import 'dart:async';
import 'package:observer/core/exceptions.dart';
import 'package:observer/observer.dart';
import 'package:test/test.dart';

class IntObservable extends ObservableLight<int> {}

void main() {
  group('ObservableLight', () {
    late IntObservable observable;

    setUp(() {
      observable = IntObservable();
    });

    tearDown(() {
      observable.dispose();
    });

    test('emite un solo valor a un observador', () async {
      final completer = Completer<int>();

      observable.listen((value) {
        completer.complete(value);
      });

      observable.update(42);

      expect(await completer.future, equals(42));
    });

    test('emite valores a múltiples observadores', () async {
      final values1 = <int>[];
      final values2 = <int>[];

      observable.listen(values1.add);
      observable.listen(values2.add);

      observable.update(1);
      observable.update(2);

      // Pequeño delay para permitir que los streams se procesen
      await Future.delayed(Duration(milliseconds: 10));

      expect(values1, equals([1, 2]));
      expect(values2, equals([1, 2]));
    });

    test('no emite eventos después de dispose', () async {
      final values = <int>[];
      observable.listen(values.add);

      observable.dispose();
      expect(
        () => observable.update(99),
        throwsA(isA<ObserverAlreadyClosedException>()),
      );
    });

    test('se puede cancelar una suscripción', () async {
      final values = <int>[];

      final sub = observable.listen(values.add);
      await sub.cancel();

      observable.update(50);

      await Future.delayed(Duration(milliseconds: 10));

      expect(values, isEmpty);
    });
  });
}
