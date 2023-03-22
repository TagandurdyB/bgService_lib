import 'package:bg_service/ViewModel/location_service_vm.dart';
import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: LocationUI());
  }
}

class LocationUI extends StatefulWidget {
  const LocationUI({super.key});

  @override
  State<LocationUI> createState() => _LocationUIState();
}

class _LocationUIState extends State<LocationUI> {
  String? lat, long, country, adminArea;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    final service = LocationService();
    final locationDate = await service.getLocation();
    if (locationDate != null) {
      final placeMark = await service.getPlaceMark(locationData: locationDate);

      setState(() {
        lat = locationDate.latitude!.toString();
        long = locationDate.longitude!.toString();
        country = placeMark?.country ??
            "Could not get country! Please check your internet connection";
        adminArea = placeMark?.administrativeArea ??
            "Could not get admin area! Please check your internet connection";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildText("Latetude: ", lat),
          _buildText("Longetude: ", long),
          _buildText("Country: ", country),
          _buildText("Admin Area: ", adminArea),
        ],
      ),
    );
  }

  Widget _buildText(name, value) {
    return Column(
      children: [
        Text(name),
        Text(
          value ?? "Loading...",
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
