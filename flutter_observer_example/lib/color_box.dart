
import 'package:flutter/material.dart';
import 'package:observer/observer.dart';
import 'color_observer/color_publisher.dart';

/// [ColorBox] es un widget que actúa como observador en el patrón Observer.
///
/// Muestra un contenedor con un color de fondo que se actualiza automáticamente
/// cuando el [ColorPublisher] emite un nuevo color.
class ColorBox extends StatefulWidget {
  /// Etiqueta que se mostrará dentro del contenedor.
  final String label;
  
  const ColorBox({required this.label, super.key});

  @override
  State<ColorBox> createState() => _ColorBoxState();
}

/// Estado del widget [ColorBox], que implementa el patrón Observer para reaccionar
/// a cambios emitidos por el [ColorPublisher].
class _ColorBoxState extends State<ColorBox> implements Observer<Color> {
  /// Color actual que se muestra en el contenedor.
  Color _color = ColorPublisher().initialColor;

  @override
  void initState() {
    super.initState();
    // Se registra como observador del ColorPublisher al iniciar.
    ColorPublisher().addListener(this);
  }

  @override
  void dispose() {
    // Se remueve como observador al ser destruido.
    ColorPublisher().removeListener(this);
    super.dispose();
  }

  /// Método invocado cuando el [ColorPublisher] emite un nuevo color.
  /// Actualiza el estado interno para reflejar el nuevo color.
  @override
  void update(Color newValue) {
    setState(() {
      _color = newValue;
    });
  }

  /// Construye el contenedor de color con el texto en el centro.
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: 200,
      height: 100,
      color: _color,
      alignment: Alignment.center,
      child: Text(
        widget.label,
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }
}
