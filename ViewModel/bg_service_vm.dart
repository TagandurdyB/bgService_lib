import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';

Future<void> initializeSevrive() async {
  final service = FlutterBackgroundService();
  await service.configure(
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: onStart,
        onBackground: onIosBg,
      ),
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        isForegroundMode: true,
        autoStart: true,
      ));
}

@pragma('vm:entry-point')
Future<bool> onIosBg(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

int counter = 0;

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  if (service is AndroidServiceInstance) {
    service.on('setAsFg').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsBg').listen((event) {
      service.setAsBackgroundService();
    });
  }
  service.on('stopS').listen((event) {
    service.stopSelf();
  });
  Timer.periodic(const Duration(seconds: 5), (timer) async {
    counter += 5;
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        service.setForegroundNotificationInfo(
          title: "Demo Service",
          content: "Plyse WORK $counter",
          
        );
      }
    }
    debugPrint("Bg service is runing! $counter");
    service.invoke('update');
  });
}
