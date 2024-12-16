import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/logic/model.dart';
import 'package:myapp/main.dart';

class Output extends StatefulWidget {
  const Output({super.key});

  @override
  State<Output> createState() => _OutputState();
}

class _OutputState extends State<Output> {
  var model = Model();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildColumnWithTexts(
          ['Network', 'First IP', 'Last IP', 'Broadcast'],
          [model.ipAdress[0].toString(), "-1", "-1"],
          isSelectable: false,
        ),
        _buildColumnWithTexts(
          [
          model.getNetworkID().join("."),
          model.getFirstIP().join("."),
          model.getLastIP().join("."),
          model.getBroadcast().join("."),
          ],
          [],
          isSelectable: true,
        ),
      ],
    );
  }

  Widget _buildColumnWithTexts(List<String> texts, List<String> copyValues, {required bool isSelectable}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: texts.asMap().entries.map((entry) {
        int index = entry.key;
        String text = entry.value;
        return GestureDetector(
          onTap: () {
            if (index < copyValues.length) {
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
          )
              : MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Text(
              text,
            ),
          ),
        );
      }).toList(),
    );
  }
}