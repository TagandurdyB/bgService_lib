import 'package:bg_service/ViewModel/bg_service_vm.dart';
import 'package:permission_handler/permission_handler.dart';

import '/ViewModel/Providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ViewModel/routes_vm.dart';
import 'ViewModel/theme_vm.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.notification.isDenied.then((value) {
    if(value){
      Permission.notification.request();
    }
  });
  await initializeSevrive();
  runApp(MultiProvider(providers: MyProvoders.list, child: const MyApp()));
}

void onStart(){

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: MyTheme(context).theme(),
      initialRoute: Rout.logo,
      routes: Rout.pages,
    );
  }
}
