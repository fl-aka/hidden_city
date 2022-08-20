import 'package:flutter/foundation.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Directions {
  final LatLngBounds? bounds;
  final List<PointLatLng>? polypoint;
  final String? eqDistance;
  final String? eqTime;

  const Directions({
    @required this.bounds,
    @required this.polypoint,
    @required this.eqDistance,
    @required this.eqTime,
  });

  factory Directions.fromMap(Map<String, dynamic> map) {
    if ((map['routes'] as List).isEmpty) {
      return const Directions(
          bounds: null, polypoint: null, eqDistance: null, eqTime: null);
    }

    final data = Map<String, dynamic>.from(map['routes']);
    final northeast = data['bounds']['northeast'];
    final southwest = data['bounds']['southwest'];
    final bounds = LatLngBounds(
        southwest: LatLng(southwest['lat'], southwest['lng']),
        northeast: LatLng(northeast['lat'], northeast['lng']));

    String eqDistance = '';
    String eqTime = '';
    if ((data['leg'] as List).isNotEmpty) {
      final leg = data['legs'][0];
      eqDistance = leg['distance']['text'];
      eqTime = leg['duration']['text'];
    }

    return Directions(
        bounds: bounds,
        polypoint: PolylinePoints()
            .decodePolyline(data['overview_polyline']['points']),
        eqDistance: eqDistance,
        eqTime: eqTime);
  }
}
