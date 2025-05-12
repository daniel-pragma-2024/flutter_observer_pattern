

import 'observer.dart';

/// Implementación base del patrón Publisher para emitir datos de tipo [T] a observadores.
///
/// [Publisher] mantiene una lista de observadores del tipo [O] que extienden [Observer<T>].
/// Puede agregar, remover y notificar observadores con nuevos valores.
abstract class Publisher<T, O extends Observer<T>> {
  /// Lista interna de observadores registrados.
  final List<O> _observers = [];

  /// Agrega un nuevo observador a la lista de notificaciones.
  void addListener(O observer) {
    _observers.add(observer);
  }

  /// Remueve un observador de la lista.
  void removeListener(O observer) {
    _observers.remove(observer);
  }

  /// Notifica a todos los observadores registrados con el nuevo [data].
  void notify(T data) {
    for (final observer in _observers) {
      observer.update(data);
    }
  }
}


