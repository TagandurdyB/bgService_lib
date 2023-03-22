import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

// ignore: must_be_immutable
class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  // ignore: non_constant_identifier_names
  String stop_start = "Start service";
int counter=0;


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildBnt("Fg service", () {
            FlutterBackgroundService().invoke('setAsFg');
          }),
          buildBnt("Bg service", () {
            FlutterBackgroundService().invoke('setAsBg');
          }),
          buildBnt(stop_start, () async {
            final service = FlutterBackgroundService();
            bool isRuning = await service.isRunning();
            if (isRuning) {
              service.invoke('stopS');
              stop_start = "Stop service";
            } else {
              service.startService();
              stop_start = "Start service";
            }
            setState(() {});
          }),
           Text("$counter",style: const TextStyle(fontSize: 50))
        ],
      ),
    );
  }

  Widget buildBnt(String name, Function func) {
    return ElevatedButton(onPressed: () => func(), child: Text(name));
  }
}
