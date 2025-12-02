import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/camera_service.dart';
import '../services/location_service.dart';
import '../providers/activity_provider.dart';

class NewActivityScreen extends StatefulWidget {
  const NewActivityScreen({super.key});

  @override
  State<NewActivityScreen> createState() => _NewActivityScreenState();
}

class _NewActivityScreenState extends State<NewActivityScreen> {
  String base64Image = '';
  double? lat, lng;
  bool saving = false;

  final CameraService cam = CameraService();
  final LocationService loc = LocationService();

  Future<void> _takePhoto() async {
    final b = await cam.takePhotoAsBase64();
    setState(() => base64Image = b);
  }

  Future<void> _getLocation() async {
    final ok = await loc.requestPermission();
    if (!ok) return;

    final pos = await loc.getCurrentPosition();
    setState(() {
      lat = pos.latitude;
      lng = pos.longitude;
    });
  }

  Future<void> _save() async {
    if (lat == null || lng == null || base64Image.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Take photo and get location first')),
      );
      return;
    }

    setState(() => saving = true);

    try {
      await Provider.of<ActivityProvider>(context, listen: false)
          .createActivity(lat: lat!, lng: lng!, base64Image: base64Image);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Activity saved')),
      );

      setState(() {
        base64Image = '';
        lat = null;
        lng = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed: $e')));
    }

    setState(() => saving = false);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ElevatedButton.icon(
            onPressed: _takePhoto,
            icon: const Icon(Icons.camera_alt),
            label: const Text('Take Photo'),
          ),
          if (base64Image.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.memory(base64Decode(base64Image), height: 200),
            ),

          ElevatedButton.icon(
            onPressed: _getLocation,
            icon: const Icon(Icons.my_location),
            label: const Text('Get Location'),
          ),
          if (lat != null)
            Text("Lat: $lat, Lng: $lng"),

          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: saving ? null : _save,
            child: saving
                ? const CircularProgressIndicator()
                : const Text("Save Activity"),
          ),
        ],
      ),
    );
  }
}
