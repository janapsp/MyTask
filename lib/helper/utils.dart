import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MapString {
  static Widget mapInputToWeather(BuildContext context, String input) {
    String text;
    switch (input) {
      case 'Tornado':
        text = 'Tornado';
        break;
      case 'Thunderstorm':
        text = 'Thunderstorm';
        break;
      case 'Drizzle':
        text = 'Drizzly';
        break;
      case 'Rain':
        text = 'Raining';
        break;
      case 'Snow':
        text = 'Snowing';
        break;
      case 'Mist':
        text = 'Misty';
        break;
      case 'fog':
        text = 'Foggy';
        break;
      case 'Smoke':
        text = 'Smoky';
        break;
      case 'Squall':
        text = 'Squally';
        break;
      case 'Haze':
        text = 'Hazy';
        break;
      case 'Dust':
        text = 'Dusty';
        break;
      case 'Sand':
        text = 'Sandy';
        break;
      case 'Ash':
        text = 'Ashy';
        break;
      case 'Clear':
        text = "Sunny";
        break;
      case 'Clouds':
        text = "Cloudy";
        break;
      default:
        text = "No Info";
    }
    return Text(
      text.toUpperCase(),
      style: TextStyle(
        fontSize: 15,
        letterSpacing: 3,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  static String mapStringToIcon(String input, String type) {
    String icon;
    switch (input) {
      case 'Thunderstorm':
        icon = "https://openweathermap.org/img/wn/${type}@2x.png";
        break;
      case 'Drizzle':
        icon = "https://openweathermap.org/img/wn/${type}@2x.png";
        break;
      case 'Rain':
        icon = "https://openweathermap.org/img/wn/${type}@2x.png";
        break;
      case 'Snow':
        icon = "https://openweathermap.org/img/wn/${type}@2x.png";
        break;
      case 'Clear':
        icon = "https://openweathermap.org/img/wn/${type}@2x.png";
        break;
      case 'Clouds':
        icon = "https://openweathermap.org/img/wn/${type}@2x.png";
        break;
      case 'Mist':
        icon = "https://openweathermap.org/img/wn/${type}@2x.png";
        break;
      case 'fog':
        icon = "https://openweathermap.org/img/wn/${type}@2x.png";
        break;
      case 'Smoke':
        icon = "https://openweathermap.org/img/wn/${type}@2x.png";
        break;
      case 'Haze':
        icon = "https://openweathermap.org/img/wn/${type}@2x.png";
        break;
      case 'Dust':
      case 'Sand':
      case 'Ash':
        icon = "https://openweathermap.org/img/wn/${type}@2x.png";
        break;
      case 'Squall':
      case 'Tornado':
        icon = "https://openweathermap.org/img/wn/${type}@2x.png";
        break;
      default:
        icon = "https://openweathermap.org/img/wn/${type}@2x.png";
    }
    return (icon);
  }
}
