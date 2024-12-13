import 'package:flutter/material.dart';
import 'package:myapp/themes/theme.dart';
import 'package:myapp/widgets/input_widget.dart';
import 'package:myapp/widgets/output.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MZG',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var ip = {-1, -1, -1, -1};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding around the card
        child: Center(
          child: Card(
            elevation: 8, // Adds shadow to the card
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Rounded corners
            ),
            color: Theme.of(context).cardColor, // Card color from theme
            child: Padding(
              padding: const EdgeInsets.all(16.0), // Padding inside the card
              child: Column(
                mainAxisSize: MainAxisSize.min, // Adjust size to content
                children: [
                  // IP Address Input Section
                  _buildInputRow([
                    '192',
                    '168',
                    '10',
                    '1',
                    '23',
                  ], hasSuffix: true),
                  const SizedBox(height: 16),
                  // Subnet Mask Input Section
                  _buildInputRow([
                    '255',
                    '255',
                    '255',
                    '0',
                  ]),
                  const SizedBox(height: 32),
                  Output()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Builds a row of input fields with optional separator and suffix
  Widget _buildInputRow(List<String> hints, {bool hasSuffix = false}) {
    List<Widget> children = [];
    for (var i = 0; i < hints.length; i++) {
      children.add(Inputwidget(
        hintText: hints[i],
        notifyParent: refresh,
      ));
      if (i < hints.length - 1) {
        children.add(
          Text(
            hasSuffix && i == hints.length - 2 ? '/' : '.',
            style: const TextStyle(
              fontSize: 30,
              color: Color.fromARGB(162, 0, 0, 0),
            ),
          ),
        );
      }
    }
    return Row(children: children);
  }

  // Builds a column of texts
  Widget _buildColumnWithTexts(List<String> texts) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: texts.map((text) => SelectableText(text)).toList(),
    );
  }

  void refresh() {
    setState(() {});
  }
}
