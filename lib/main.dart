import 'package:flutter/material.dart';
import 'package:myapp/logic/model.dart';
import 'package:myapp/themes/theme.dart';
import 'package:myapp/widgets/input_widget.dart';
import 'package:myapp/widgets/output.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

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
      scaffoldMessengerKey: scaffoldMessengerKey,
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
  Model model = Model();

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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min, // Adjust size to content
                children: [
                  // IP Address Input Section
                  _buildInputRow([
                    '192',
                    '168',
                    '10',
                    '1',
                    '23',
                  ], setIPAdress, hasSuffix: true),
                  const SizedBox(height: 16),
                  // Subnet Mask Input Section
                  _buildInputRow([
                    '255',
                    '255',
                    '255',
                    '0',
                  ], setSNM),
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
  Widget _buildInputRow(List<String> hints, Function(int, String) setValue,
      {bool hasSuffix = false}) {
    List<Widget> children = [];
    for (var i = 0; i < hints.length; i++) {
      children.add(IntrinsicWidth(
          child: Inputwidget(
        hintText: hints[i],
        setValue: setValue,
        index: i,
      )));
      if (i < hints.length - 1) {
        children.add(
          Text(
            hasSuffix && i == hints.length - 2 ? '/' : '.',
            style: const TextStyle(
              fontSize: 30,
              color: Colors.grey,
            ),
          ),
        );
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // Center horizontally
      children: children,
    );
  }

  void refresh() {
    setState(() {});
  }

  void setIPAdress(int index, String value) {
    setState(() {
      var input = int.tryParse(value) ?? model.ipAdress[index];
      model.ipAdress[index] = input;
      debugPrint("IP: " + model.ipAdress.toString());
    });
  }

  void setSNM(int index, String value) {
    setState(() {
      var input = int.tryParse(value) ?? model.subnetMask[index];
      model.subnetMask[index] = input;
      debugPrint("SNM: " + model.subnetMask.toString());
    });
  }
}
