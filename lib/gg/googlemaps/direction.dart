import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hidden_city/utils/plainVar/api_keys.dart';
import 'directions.dart';

class DirectionRes {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';
  late final Dio _dio;
  DirectionRes({Dio? dio}) : _dio = dio ?? Dio();

  Future<Directions?> getDirections(
      {required LatLng origin, required LatLng destination}) async {
    final response = await _dio.get(_baseUrl, queryParameters: {
      'origin': '${origin.latitude},${origin.longitude}',
      'destination': '${destination.latitude},${destination.longitude}',
      'key': ytAPIKEY
    });
    debugPrint(response.data.toString());
    if (response.statusCode == 200) {
      return Directions.fromMap(response.data);
    } else {
      return null;
    }
  }
}
