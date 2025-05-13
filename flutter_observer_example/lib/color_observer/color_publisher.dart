
import 'package:flutter/material.dart' show Color, Colors;
import 'package:observer/observer.dart';

/// [ColorPublisher] es una implementación concreta de [Publisher] que
/// emite valores de tipo [Color] a todos sus observadores.
///
/// Esta clase implementa el patrón Singleton para garantizar que solo exista
/// una única instancia en toda la aplicación, asegurando que todos los
/// observadores escuchen al mismo publicador.
class ColorPublisher extends Publisher<Color, Observer<Color>> {
  /// Devuelve el color inicial usado por los observadores al iniciar.
  Color get initialColor => Colors.blue;

  // --- Singleton implementation ---

  /// Instancia única de [ColorPublisher] mantenida de forma privada.
  static final ColorPublisher _singleton = ColorPublisher._internal();

  /// Constructor factory que retorna siempre la misma instancia de [ColorPublisher].
  factory ColorPublisher() {
    return _singleton;
  }

  /// Constructor privado usado internamente para crear la única instancia.
  ColorPublisher._internal();
}
