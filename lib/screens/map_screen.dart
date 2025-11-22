import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatelessWidget {
  final LatLng initial = LatLng(-6.914744, 107.609810);

  MapScreen({super.key}); // Bandung

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lokasi di Peta")),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: initial,
          initialZoom: 13,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            userAgentPackageName: 'com.example.uts_mobile_project',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: initial,
                width: 80,
                height: 80,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 36,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
