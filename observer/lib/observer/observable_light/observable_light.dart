import 'dart:async';


import '../../core/exceptions.dart' show ObserverAlreadyClosedException;

/// Una implementación ligera del patrón Observer utilizando Streams.
///
/// La clase [ObservableLight] permite a los observadores suscribirse a una fuente
/// de datos genérica de tipo [T]. Cuando se llama a [update], todos los observadores
/// activos son notificados automáticamente.
///
/// Esta clase es útil para situaciones simples donde se desea implementar una
/// comunicación tipo "publish-subscribe" sin dependencias externas como RxDart.
abstract class ObservableLight<T> {
  /// Controlador interno de tipo broadcast para permitir múltiples suscriptores.
  final _controller = StreamController<T>.broadcast();

  /// Notifica a todos los observadores suscritos con un nuevo [item].
  ///
  /// Este método agrega el [item] al stream, lo cual dispara el callback
  /// de todos los suscriptores registrados mediante [listen].
  void update(T item) {
    if (_controller.isClosed) {
      throw ObserverAlreadyClosedException();
    }
    _controller.add(item);
  }

  /// Cierra el stream para liberar recursos.
  ///
  /// Después de llamar a este método, no se pueden agregar más datos ni
  /// suscribirse al stream.
  void dispose() {
    _controller.close();
  }

  /// Permite que un observador escuche los eventos emitidos por el observable.
  ///
  /// Retorna una [StreamSubscription] que puede ser utilizada para cancelar
  /// la suscripción posteriormente.
  ///
  /// Ejemplo de uso:
  /// ```dart
  /// final subscription = observable.listen((data) {
  ///   print('Nuevo valor recibido: $data');
  /// });
  /// ```
  StreamSubscription<T> listen(void Function(T item) onUpdate) {
    return _controller.stream.listen(onUpdate);
  }
}
