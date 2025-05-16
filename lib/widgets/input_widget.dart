import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/logic/model.dart';

class Input extends StatefulWidget {
  final String hintText;
  final int index;
  final Function(int, String) setValue;
  final bool isSubnetMaskField;

  const Input({
    super.key,
    required this.hintText,
    required this.setValue,
    required this.index,
    this.isSubnetMaskField = false,
  });

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  var model = Model();
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    model.addListener(_updateTextField);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    model.removeListener(_updateTextField);
    super.dispose();
  }

  void _updateTextField() {
    if (widget.isSubnetMaskField) {
      setState(() {
        _controller.text = model.subnetMask[widget.index].toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: _focusNode,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.tab)) {
          if (_controller.text.isEmpty) {
            _controller.text = widget.hintText;
            widget.setValue(widget.index, widget.hintText);
          }
          FocusScope.of(context).nextFocus();
        }
      },
      child: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(3),
        ],
        style: const TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey[800]),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        ),
        onSubmitted: (value) {
          if (value.isEmpty) {
            _controller.text = widget.hintText;
            value = widget.hintText;
          }
          widget.setValue(widget.index, value);
          FocusScope.of(context).nextFocus();
        },
      ),
    );
  }
}
