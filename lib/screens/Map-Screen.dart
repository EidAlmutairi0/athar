import 'package:flutter/material.dart';
import '/globals.dart' as globals;
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_map/flutter_map.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final PopupController _popupController = PopupController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterMap(
          options: MapOptions(

            center: globals.camPos,
            zoom: 15,
            onTap: (_, a) => _popupController.hidePopup(),
            plugins: [
              MarkerClusterPlugin(),
            ],
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerClusterLayerOptions(
              showPolygon: false,
              disableClusteringAtZoom: 10,
              maxClusterRadius: 120,
              size: Size(40, 40),
              anchor: AnchorPos.align(AnchorAlign.center),
              fitBoundsOptions: FitBoundsOptions(
                padding: EdgeInsets.all(50),
              ),
              markers: globals.places,
              polygonOptions: PolygonOptions(
                  borderColor: Color(0xFFF2945E),
                  color: Color(0xFFF2945E),
                  borderStrokeWidth: 3),
              popupOptions: PopupOptions(
                popupSnap: PopupSnap.markerTop,
                popupController: _popupController,
              ),
              builder: (context, markers) {
                return FloatingActionButton(
                  backgroundColor: Color(0xFFF2945E),
                  child: Text(markers.length.toString()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
