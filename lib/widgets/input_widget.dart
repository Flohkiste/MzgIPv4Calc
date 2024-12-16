import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/logic/model.dart';

class Inputwidget extends StatefulWidget {
  final String hintText;
  final int index;
  const Inputwidget(
      {super.key,
      required this.hintText,
      required this.setValue,
      required this.index});
  final Function(int, String) setValue;

  @override
  State<Inputwidget> createState() => _InputwidgetState();
}

class _InputwidgetState extends State<Inputwidget> {
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
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(3)
        ],
        style: const TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey[800]),
        ),
        onSubmitted: (value) {
          setState(() {
            widget.setValue(widget.index, value);
          });
        },
      ),
    );
  }
}
