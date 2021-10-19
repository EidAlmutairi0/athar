library my_prj.globals;

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

double latitude = 5;
double longitude = 5;
String currentPlace;
var camPos = LatLng(latitude, longitude);
List<Marker> places = [];
