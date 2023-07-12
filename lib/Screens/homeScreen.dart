import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tw_task/Provider/weatherProvider.dart';
import 'package:tw_task/helper/utils.dart';
import 'package:tw_task/widgets/locationError.dart';
import 'package:tw_task/widgets/requestError.dart';
import 'package:tw_task/Screens/weatherDetails.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/homeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = PageController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  Future<void> _getData() async {
    _isLoading = true;
    final weatherData = Provider.of<WeatherProvider>(context, listen: false);
    weatherData.getWeatherData(context);
    _isLoading = false;
  }
  @override
  Widget build(BuildContext context) {
    final themeContext = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Consumer<WeatherProvider>(
          builder: (context, weatherProv, _) {
            if (weatherProv.isRequestError) return RequestError();
            if (weatherProv.isLocationError) return LocationError();
            return Column(
              children: [
                _isLoading || weatherProv.isLoading
                    ? Expanded(
                        child: Center(
                          child: CircularProgressIndicator(
                            backgroundColor: themeContext.primaryColor,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Expanded(
                        child: PageView(
                          physics: BouncingScrollPhysics(),
                          controller: _pageController,
                          children: [
                            // Second Page of the Page View
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: weatherProv.sevenDayWeather.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Consumer<WeatherProvider>(
                                  builder: (context, weatherProv, _) {
                                    DateTime dateTime =
                                        DateTime.fromMillisecondsSinceEpoch(
                                            weatherProv
                                                    .sevenDayWeather[index].dt *
                                                1000);
                                    String formattedDate =
                                        DateFormat('E, MMM d, yyyy h:mm a')
                                            .format(dateTime);
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  WeatherDetails(
                                                      listElement: weatherProv
                                                              .sevenDayWeather[
                                                          index],
                                                      cityElement: weatherProv
                                                          .currentCity[0]),
                                            ));
                                      },
                                      child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 16),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10),
                                                child: Image.network(
                                                  MapString.mapStringToIcon(
                                                      '${weatherProv.sevenDayWeather[index].weather[0].main}',
                                                      '${weatherProv.sevenDayWeather[index].weather[0].icon}'),
                                                  scale: 2,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 16,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    formattedDate.toString(),
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ),
                                                  MapString.mapInputToWeather(
                                                    context,
                                                    '${weatherProv.sevenDayWeather[index].weather[0].main}',
                                                  ),
                                                  Text(
                                                    'Temp: ${weatherProv.sevenDayWeather[index].main.temp.toStringAsFixed(1)}°C',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
