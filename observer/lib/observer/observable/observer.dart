/// Representa una entidad que puede recibir actualizaciones de tipo [T].
///
/// Las clases que implementan [Observer] deben sobrescribir el método [update],
/// el cual se invoca cuando el [Publisher] notifica un nuevo valor.
abstract class Observer<T> {
  /// Método llamado por el [Publisher] cuando se emite un nuevo valor.
  ///
  /// [newValue] es el dato emitido por el publisher.
  void update(T newValue);
}
