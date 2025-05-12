import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/logic/model.dart';
import 'package:myapp/main.dart';

class Output extends StatefulWidget {
  final Model model;
  const Output({super.key, required this.model});

  @override
  State<Output> createState() => _OutputState();
}

class _OutputState extends State<Output> {
  @override
  Widget build(BuildContext context) {
    // Holt die darzustellenden IP-Werte aus dem Modell
    final rightColumnTexts = [
      widget.model.getNetworkID().join("."),
      widget.model.getFirstIP().join("."),
      widget.model.getLastIP().join("."),
      widget.model.getBroadcast().join("."),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Linke Spalte
        _buildColumnWithTexts(
          ['Network', 'First IP', 'Last IP', 'Broadcast'],
          rightColumnTexts,
          isSelectable: false,
        ),
        // Rechte Spalte
        _buildColumnWithTexts(
          rightColumnTexts,
          rightColumnTexts,
          isSelectable: true,
        ),
      ],
    );
  }

  // Baut eine Spalte mit Texten auf – entweder klickbar oder nicht
  Widget _buildColumnWithTexts(List<String> texts, List<String> copyValues,
      {required bool isSelectable}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: texts.asMap().entries.map((entry) {
        int index = entry.key;
        String text = entry.value;

        return GestureDetector(
          onTap: () {
            if (index < copyValues.length) {
              // Kopiert den Wert in die Zwischenablage
              Clipboard.setData(ClipboardData(text: copyValues[index]));
              scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
              scaffoldMessengerKey.currentState?.showSnackBar(
                SnackBar(content: Text('Copied to clipboard: ${copyValues[index]}')),
              );
            }
          },
          child: isSelectable
              ? SelectableText(
            text,
            style: const TextStyle(color: Colors.white),
          )
              : MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      }).toList(),
    );
  }
}