import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qr_reader/models/scan_model.dart';

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController _controller = MapController();
  bool satelite = false;

  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;
    final punto = scan.getLatLng();

    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
        actions: [
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () => _controller.move(punto, 17),
          ),
        ],
      ),
      body: FlutterMap(
        mapController: _controller,
        options: MapOptions(initialCenter: punto, initialZoom: 17),
        children: [
          TileLayer(
            urlTemplate: satelite
                ? 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}'
                : 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.qr_reader',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: punto,
                width: 40,
                height: 40,
                child: Icon(Icons.location_on, color: Colors.red, size: 40),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.layers),
        onPressed: () => setState(() => satelite = !satelite),
      ),
    );
  }
}
