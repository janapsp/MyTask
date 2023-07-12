import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:tw_task/models/weather.dart';
import 'package:tw_task/widgets/const.dart';
import 'package:tw_task/widgets/locationError.dart';

class WeatherProvider with ChangeNotifier {
  LatLng? currentLocation;
  List<ListElement> sevenDayWeather = [];
  List<City> currentCity = [];
  bool isLoading = false;
  bool isRequestError = false;
  bool isLocationError = false;
  bool serviceEnabled = false;
  LocationPermission? permission;

  Future<Position>? requestLocation(BuildContext context) async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Location service disabled'),
      ));
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Permission denied'),
        ));
        isLocationError = true;
        notifyListeners();
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      isLocationError = true;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Location permissions are permanently denied'),
      ));

      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<bool> getWeatherData(
    BuildContext context, {
    bool isRefresh = false,
  }) async {
    isLoading = true;
    isRequestError = false;
    isLocationError = false;
    if (isRefresh) notifyListeners();

    Position? locData = await requestLocation(context);
    if (locData == null) {
      isLocationError = true;
      notifyListeners();
      return isLocationError;
    }
    try {
      currentLocation = LatLng(locData.latitude, locData.longitude);
      await getCurrentWeather(currentLocation!);
      await getCurrentCity(currentLocation!);
    } catch (e) {
      isLocationError = true;
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return isLocationError;
  }

  Future<List<ListElement>> getCurrentWeather(LatLng location) async {
    Uri url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/forecast?lat=${location.latitude}&lon=${location.longitude}&appid=${Api.apiKey}',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        var rest = jsonResponse['list'] as List;
        sevenDayWeather = rest.map((e) => ListElement.fromJson(e)).toList();
        return sevenDayWeather;
      } catch (error) {
        isLoading = false;
        this.isRequestError = true;
      } finally {
        isLoading = false;
        notifyListeners();
      }
    } else {
      throw Exception('Failed to fetch Data');
    }
    throw Exception('Failed to fetch Data');
  }

  Future<List<City>> getCurrentCity(LatLng location) async {
    Uri url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/forecast?lat=${location.latitude}&lon=${location.longitude}&appid=${Api.apiKey}',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        Map<String, dynamic> rest = jsonResponse['city'];
        currentCity.add(City.fromJson(rest));
        return currentCity;
      } catch (error) {
        isLoading = false;
        this.isRequestError = true;
        throw Exception('Failed to fetch Data');
      } finally {
        isLoading = false;
        notifyListeners();
      }
    } else {
      throw Exception('Failed to fetch Data');
    }
  }
}
