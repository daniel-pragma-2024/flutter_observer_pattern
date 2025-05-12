
import 'package:observer/observer.dart';
import 'package:test/test.dart';


void main() {
  group('Publisher', () {
    late IntPublisher publisher;
    late IntObserver observer1;
    late IntObserver observer2;

    setUp(() {
      publisher = IntPublisher();
      observer1 = IntObserver();
      observer2 = IntObserver();
    });

    test('agrega observadores y los notifica', () {
      publisher.addListener(observer1);
      publisher.notify(10);

      expect(observer1.lastValue, 10);
    });

    test('notifica a múltiples observadores', () {
      publisher.addListener(observer1);
      publisher.addListener(observer2);
      publisher.notify(5);

      expect(observer1.lastValue, 5);
      expect(observer2.lastValue, 5);
    });

    test('remueve observador correctamente', () {
      publisher.addListener(observer1);
      publisher.removeListener(observer1);
      publisher.notify(99);

      expect(observer1.lastValue, isNull);
    });

    test('remover un observador que no existe no lanza error', () {
      expect(() => publisher.removeListener(observer1), returnsNormally);
    });
  });
}


class IntObserver implements Observer<int> {
  int? lastValue;

  @override
  void update(int newValue) {
    lastValue = newValue;
  }
}

class IntPublisher extends Publisher<int, IntObserver> {}
