import 'package:flutter/material.dart';
import 'package:myapp/logic/model.dart';

class Inputwidget extends StatefulWidget {
  final String hintText;
  const Inputwidget(
      {super.key, required this.hintText, required this.notifyParent});
  final Function() notifyParent;

  @override
  State<Inputwidget> createState() => _InputwidgetState();
}

class _InputwidgetState extends State<Inputwidget> {
  int _input = -1;
  var model = Model();
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: widget.hintText,
        ),
        onSubmitted: (value) {
          setState(() {
            _input = int.tryParse(value) ?? -1;
            Model().ipAdress[0] = 1;
            widget.notifyParent;
            debugPrint('Input: $_input');
          });
        },
      ),
    );
  }
}
