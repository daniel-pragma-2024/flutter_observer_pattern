import 'dart:io';

import 'package:observer/observer.dart';

/// Implementación concreta de un observador de enteros (Observer normal).
class IntObserver implements Observer<int> {
  final String name;

  IntObserver(this.name);

  @override
  void update(int newValue) {
    print('[$name] (Observer normal) recibió el valor: $newValue');
  }
}

class IntLightObserver implements Observer<int> {
  final String name;

  IntLightObserver(this.name);

  @override
  void update(int newValue) {
    print('[$name] (Observer light) recibió el valor: $newValue');
  }
}

class IntPublisher extends Publisher<int, Observer<int>> {}

class IntLightPublisher extends ObservableLight<int> {}

void main() {
  while (true) {
    // menú de Observer
    print('Seleccione el tipo de Observer:');
    print('1. Observer normal');
    print('2. Observer light');
    stdout.write('Ingrese su opción: ');
    String? observerChoice = stdin.readLineSync();

    if (observerChoice == '1') {
      print('Usando Observer normal:');
      runNormalObserverExample();
    } else if (observerChoice == '2') {
      print('Usando Observer light:');
      runLightObserverExample();
    } else {
      print('Opción no válida para Observer.');
    }
  }
}

void runNormalObserverExample() {
  final publisher = IntPublisher();

  final observerA = IntObserver('A');
  final observerB = IntObserver('B');

  publisher.addListener(observerA);
  publisher.addListener(observerB);

  publisher.notify(100); // Ambos observadores reciben el valor

  publisher.removeListener(observerA);
  publisher.notify(200); // Solo B recibe este valor
}

void runLightObserverExample() {
  final publisher = IntLightPublisher();

  final observerA = IntLightObserver('A');
  final observerB = IntLightObserver('B');

  publisher.listen((value) => observerA.update(value));
  publisher.listen((value) => observerB.update(value));

  publisher.update(100); // Ambos observadores reciben el valor

  publisher.dispose(); // Se cierra el publisher, ya no se emiten más valores
}
