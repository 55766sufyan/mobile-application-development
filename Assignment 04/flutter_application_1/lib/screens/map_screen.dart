import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/location_service.dart';
import 'package:provider/provider.dart';
import '../providers/activity_provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? current;
  final Completer<GoogleMapController> _controller = Completer();
  final LocationService loc = LocationService();

  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    initLocation();
  }

  Future<void> initLocation() async {
    final ok = await loc.requestPermission();
    if (!ok) return;

    final pos = await loc.getCurrentPosition();
    setState(() => current = LatLng(pos.latitude, pos.longitude));

    Provider.of<ActivityProvider>(context, listen: false)
        .loadActivities()
        .then((_) => loadMarkers());
  }

  void loadMarkers() {
    final acts =
        Provider.of<ActivityProvider>(context, listen: false).activities;

    final ms = acts
        .map(
          (a) => Marker(
            markerId: MarkerId(a.id),
            position: LatLng(a.latitude, a.longitude),
            infoWindow: InfoWindow(
              title: a.timestamp.toLocal().toString(),
            ),
          ),
        )
        .toSet();

    setState(() => markers = ms);
  }

  @override
  Widget build(BuildContext context) {
    if (current == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: current!,
        zoom: 15,
      ),
      markers: markers.union({
        Marker(markerId: const MarkerId("me"), position: current!)
      }),
      onMapCreated: (c) => _controller.complete(c),
    );
  }
}
