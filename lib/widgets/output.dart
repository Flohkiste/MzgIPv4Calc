import 'package:flutter/material.dart';
import 'package:myapp/logic/model.dart';

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
        _buildColumnWithTexts(['Network', 'Frist IP', 'Last IP']),
        _buildColumnWithTexts([model.ipAdress[0].toString(), "-1", "-1"]),
      ],
    );
  }

  Widget _buildColumnWithTexts(List<String> texts) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: texts.map((text) => SelectableText(text)).toList(),
    );
  }
}
