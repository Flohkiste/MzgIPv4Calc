import 'package:flutter/material.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
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
              // Example Text Sections
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildColumnWithTexts(['Netzwix', 'Subwix', 'Wixwix']),
                  _buildColumnWithTexts(['Wert1', 'Wert2', 'Wert3']),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Builds a row of input fields with optional separator and suffix
  Widget _buildInputRow(List<String> hints, {bool hasSuffix = false}) {
    List<Widget> children = [];
    for (var i = 0; i < hints.length; i++) {
      children.add(
        Expanded(
          child: TextField(
            keyboardType: TextInputType.number,
            style: const TextStyle(fontSize: 20),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: hints[i],
            ),
          ),
        ),
      );
      if (i < hints.length - 1) {
        children.add(
          Text(
            hasSuffix && i == hints.length - 2 ? '/' : '.',
            style: const TextStyle(fontSize: 30, color: Color.fromARGB(162, 0, 0, 0)),
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
      children: texts.map((text) => Text(text)).toList(),
    );
  }
}
