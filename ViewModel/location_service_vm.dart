// ignore_for_file: avoid_print

import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geo;

class LocationService {
  late Location _location;
  bool _serviceEnabled = false;
  PermissionStatus? _grantedPermision;

  LocationService() {
    _location = Location();
  }

  Future<bool> _checkPermision() async {
    if (await _checkService()) {
      _grantedPermision = await _location.hasPermission();
      // if(_grantedPermision!=PermissionStatus.granted){
      if (_grantedPermision == PermissionStatus.denied) {
        _grantedPermision = await _location.requestPermission();
      }
    }

    return _grantedPermision == PermissionStatus.granted;
  }

  Future<bool> _checkService() async {
    try {
      _serviceEnabled = await _location.serviceEnabled();
      if (!_serviceEnabled) _serviceEnabled = await _location.requestService();
    } on PlatformException catch (err) {
      print("Error Code :${err.code}");
      print("Error Message :${err.message}");
      _serviceEnabled = false;
      await _checkService();
    }
    return _serviceEnabled;
  }

  Future<LocationData?> getLocation() async {
    if (await _checkPermision()) {
      final locationDate = _location.getLocation();
      return locationDate;
    }
    return null;
  }

  Future<geo.Placemark?> getPlaceMark(
      {required LocationData locationData}) async {
    try {
      final List<geo.Placemark> placeMarks = await geo.placemarkFromCoordinates(
          locationData.latitude!, locationData.longitude!);
      if (placeMarks.isNotEmpty) {
        print("PaceMarks: $placeMarks");
        return placeMarks[0];
      }
    } on PlatformException catch (err) {
      print("getPlaceMark Error Code :${err.code}");
      print("getPlaceMark Error Message :${err.message}");
      return null;
    }
    return null;
  }
}
