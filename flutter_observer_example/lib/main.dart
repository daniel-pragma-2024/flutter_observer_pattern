import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'color_box.dart';
import 'color_observer/color_publisher.dart';

void main() => runApp(ObserverApp());

class ObserverApp extends StatelessWidget {
  const ObserverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ColorObserverDemo(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ColorObserverDemo extends StatelessWidget {
  const ColorObserverDemo({super.key});

  @override
  Widget build(BuildContext context) {
    Color _color = ColorPublisher().initialColor;
    return Scaffold(
      appBar: AppBar(title: Text('Observer - Múltiples Observadores')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ColorBox(label: 'Observador/subject 1'),
          ColorBox(label: 'Observador/subject 2'),
          ColorBox(label: 'Observador/subject 3'),
          SizedBox(height: 30),
          Center(
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Escoge un color!'),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: _color,
                          onColorChanged: (value) {
                            ColorPublisher().notify(value);
                            _color = value;
                          },
                        ),
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                          child: const Text('Lo tengo'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Cambiar Color'),
            ),
          ),
        ],
      ),
    );
  }
}
