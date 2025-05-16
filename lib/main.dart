import 'package:flutter/material.dart';
import 'package:myapp/logic/model.dart';
import 'package:myapp/themes/theme.dart';
import 'package:myapp/widgets/input_widget.dart';
import 'package:myapp/widgets/output.dart';
import 'package:provider/provider.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Model(),
      child: const MyApp(),
    ),
  );
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
  late Model model;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    model = Provider.of<Model>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Theme.of(context).cardColor,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildInputRow(
                    model.ipAddress.map((e) => e.toString()).toList() + [model.cidr.toString()],
                    setIPAddress,
                    hasSuffix: true,
                  ),

                  _buildInputRow(
                    ["255", "255", "254", "0"],
                    setSNM,
                    isSubnetMaskField: true,
                  ),
                  const SizedBox(height: 32),
                  Output(model: model)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputRow(
      List<String> hints,
      Function(int, String) setValue, {
        bool hasSuffix = false,
        bool isSubnetMaskField = false,
      }) {
    List<Widget> children = [];

    for (var i = 0; i < hints.length; i++) {
      children.add(SizedBox(
        width: 70,
        child: Input(
          hintText: hints[i],
          setValue: setValue,
          index: i,
          isSubnetMaskField: isSubnetMaskField,
        ),
      ));

      if (i < hints.length - 1) {
        children.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              hasSuffix && i == hints.length - 2 ? '/' : '.',
              style: const TextStyle(
                fontSize: 28,
                color: Colors.grey,
              ),
            ),
          ),
        );
      }
    }

    return Wrap(
      spacing: 8,
      alignment: WrapAlignment.center,
      children: children,
    );
  }


  void refresh() {
    setState(() {});
  }

  void setIPAddress(int index, String value) {
    setState(() {
      if (index > 3) {
        var input = int.tryParse(value) ?? model.cidr;
        model.cidr = input;
        model.setSubnetMaskFromCIDR();
        return;
      }

      var input = int.tryParse(value) ?? model.ipAddress[index];
      model.ipAddress[index] = input;
      debugPrint("IP: ${model.ipAddress}");
    });
  }

  void setSNM(int index, String value) {
    setState(() {
      var input = int.tryParse(value) ?? model.subnetMask[index];
      model.subnetMask[index] = input;
      debugPrint("SNM: ${model.subnetMask}");
      model.setCIDRFromSubnetMask();
    });
  }
}
