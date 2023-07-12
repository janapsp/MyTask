import 'package:flutter/cupertino.dart';

class City with ChangeNotifier {
  int id;
  String name;
  String country;
  int population;
  int timezone;
  int sunrise;
  int sunset;

  City({
    required this.id,
    required this.name,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        country: json["country"] ?? "",
        population: json["population"] ?? 0,
        timezone: json["timezone"] ?? 0,
        sunrise: json["sunrise"] ?? 0,
        sunset: json["sunset"] ?? 0,
      );
}

class ListElement with ChangeNotifier {
  int dt;
  Main main;
  List<WeatherElement> weather;
  Clouds clouds;
  Wind wind;
  int visibility;
  double pop;
  Sys sys;
  String dtTxt;
  Rain? rain;

  ListElement({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    required this.sys,
    required this.dtTxt,
    this.rain,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        dt: json["dt"] ?? 0,
        main: Main.fromJson(json["main"]),
        weather: List<WeatherElement>.from(
            json["weather"].map((x) => WeatherElement.fromJson(x))),
        clouds: Clouds.fromJson(json["clouds"]),
        wind: Wind.fromJson(json["wind"]),
        visibility: json["visibility"] ?? 0,
        pop: json["pop"]?.toDouble(),
        sys: Sys.fromJson(json["sys"]),
        dtTxt: json["dt_txt"] ?? "",
        rain: json["rain"] == null ? null : Rain.fromJson(json["rain"]),
      );
}

class Clouds {
  int all;

  Clouds({
    required this.all,
  });

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
        all: json["all"] ?? 0,
      );
}

class Main {
  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int seaLevel;
  int grndLevel;
  int humidity;
  double tempKf;

  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.seaLevel,
    required this.grndLevel,
    required this.humidity,
    required this.tempKf,
  });

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"]?.toDouble() ?? 0.0,
        feelsLike: json["feels_like"]?.toDouble() ?? 0.0,
        tempMin: json["temp_min"]?.toDouble() ?? 0.0,
        tempMax: json["temp_max"]?.toDouble() ?? 0.0,
        pressure: json["pressure"] ?? 0,
        seaLevel: json["sea_level"] ?? 0,
        grndLevel: json["grnd_level"] ?? 0,
        humidity: json["humidity"] ?? 0,
        tempKf: json["temp_kf"]?.toDouble() ?? 0.0,
      );
}

class Rain {
  double the3H;

  Rain({
    required this.the3H,
  });

  factory Rain.fromJson(Map<String, dynamic> json) => Rain(
        the3H: json["3h"]?.toDouble() ?? 0.0,
      );
}

class Sys {
  String pod;

  Sys({
    required this.pod,
  });

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        pod: json["pod"] ?? '',
      );
}

class WeatherElement {
  int id;
  String main;
  String description;
  String icon;

  WeatherElement({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory WeatherElement.fromJson(Map<String, dynamic> json) => WeatherElement(
        id: json["id"] ?? 0,
        main: json["main"] ?? "",
        description: json["description"] ?? "",
        icon: json["icon"] ?? "",
      );
}

class Wind {
  double speed;
  int deg;
  double gust;

  Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json["speed"]?.toDouble() ?? 0.0,
        deg: json["deg"] ?? 0,
        gust: json["gust"]?.toDouble() ?? 0.0,
      );
}
