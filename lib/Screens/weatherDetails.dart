import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tw_task/helper/utils.dart';
import 'package:tw_task/models/weather.dart';

class WeatherDetails extends StatelessWidget {
  static const routeName = '/weatherDetails';

  const WeatherDetails(
      {super.key, required this.listElement, required this.cityElement});

  final ListElement listElement;
  final City cityElement;

  @override
  Widget build(BuildContext context) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(listElement.dt * 1000);
    String formattedDate = DateFormat('E, MMM d, yyyy').format(dateTime);
    String formattedTime = DateFormat(' h:mm a').format(dateTime);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Colors.white),
          title: Text("Weather Details"),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  formattedDate.toUpperCase(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                ),
              ),
              Text(
                formattedTime.toUpperCase(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.black,
                      size: 45,
                    ),
                    Text(
                      cityElement.name.toUpperCase() ?? "",
                      style: TextStyle(
                        fontSize: 25,
                        letterSpacing: 5,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              MapString.mapInputToWeather(
                context,
                '${listElement.weather[0].main}',
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Image.network(
                      MapString.mapStringToIcon(
                          '${listElement.weather[0].main}',
                          '${listElement.weather[0].icon}'),
                      scale: 0.5,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    listElement.main.temp.toString() + "°C",
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 50),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Temp(max)",
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                listElement.main.tempMax.toString() + "°C",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Center(
                                child: Container(
                              width: 1,
                              height: 30,
                            )),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Temp(min)",
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                listElement.main.tempMin.toString() + "°C",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
