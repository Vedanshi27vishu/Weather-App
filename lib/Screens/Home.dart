import 'package:flutter/material.dart';
import 'package:weather_app/utils/api.dart';
import 'package:weather_app/utils/weather_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ApiResponse? response;
  bool inProgress = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 175, 197, 246),
        title: const Text(
          'Weather Search',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 7, 9, 96),
            fontSize: 30,
          ),
        ),
      ),
      body: Container(
        
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 175, 197, 246), // Light blue
              Color.fromARGB(255, 7, 9, 96), // Darker blue
            ],
            stops: [0.4, 1.0],
          ),
        ),
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Search any location',
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 7, 9, 96),
                    ), // Blue text color
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 7, 9, 96),
                      ), // Blue border color
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 7, 9, 96),
                      ), // Blue border color when enabled
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 7, 9, 96),
                      ), // Blue border color when focused
                    ),
                  ),
                  style: const TextStyle(
                    color: Color.fromARGB(255, 7, 9, 96),
                    fontWeight: FontWeight.w500,
                  ), // Blue text color
                  onSubmitted: (value) {
                    _getWeatherData(value);
                  },
                ),
                if (inProgress)
                  const CircularProgressIndicator()
                else if (errorMessage.isNotEmpty)
                  Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                  )
                else if (response == null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 600,
                        child: Column(
                          children: [
                            SizedBox(height: 20,),
                            const Text(
                                'Search for a location to get weather data'),
                            SizedBox(
                              height: 100,
                            ),
                            Center(
                              child: Image.asset("assets/location.webp"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  WeatherInfo(response: response),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getWeatherData(String location) async {
    setState(() {
      inProgress = true;
      errorMessage = '';
    });
    try {
      ApiResponse apiResponse = await WeatherApi().getCurrentWeather(location);
      setState(() {
        response = apiResponse;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load weather data. Please try again: $e';
      });
    } finally {
      setState(() {
        inProgress = false;
      });
    }
  }
}

class WeatherInfo extends StatelessWidget {
  final ApiResponse? response;

  const WeatherInfo({Key? key, this.response}) : super(key: key);

  String _getWeatherIconUrl(String conditionText) {
    if (conditionText.toLowerCase().contains('clear')) {
      return 'assets/clear.png';
    } else if (conditionText.toLowerCase().contains('sunny')) {
      return 'assets/clear.png';
    } else if (conditionText.toLowerCase().contains('cloudy')) {
      return 'assets/heavycloud.png';
    } else if (conditionText.toLowerCase().contains('rain')) {
      return 'assets/lightrain.png';
    } else if (conditionText.toLowerCase().contains('heavy')) {
      return 'assets/heavyrain.png';
    } else if (conditionText.toLowerCase().contains('snow')) {
      return 'assets/snow.png';
    } else if (conditionText.toLowerCase().contains('thunder')) {
      return 'assets/thunderstorm.png';
    } else if (conditionText.toLowerCase().contains('mist')) {
      return 'assets/mist.webp';
    }
    return 'assets/normal.png';
  }

  @override
  Widget build(BuildContext context) {
    String iconUrl =
        _getWeatherIconUrl(response?.current?.condition?.text ?? '');

    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: Image(
                    image: AssetImage("assets/pin.png"),
                    width: 80,
                    height: 80,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Text(
  response?.location?.country ?? '',
  overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
  maxLines: 1, // Limit to 1 line before ellipsis is shown
  style: const TextStyle(
    fontSize: 35,
    fontWeight: FontWeight.w700,
    color: Color.fromARGB(255, 7, 9, 96),
  ),
),

                    ),
                    Text(
                      response?.location?.name ?? '',
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                        color: Color.fromARGB(255, 7, 9, 96),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Text(
                  '${response?.current?.tempC ?? ''}',
                  style: const TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 7, 9, 96),
                  ),
                ),
                const SizedBox(width: 10),
                const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "°C",
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 7, 9, 96),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              response?.current?.condition?.text ?? '',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
                color: Color.fromARGB(255, 7, 9, 96),
              ),
            ),
            Center(
              child: SizedBox(
                height: 150,
                child: iconUrl.isNotEmpty
                    ? Image.asset(
                        iconUrl,
                        scale: 0.7,
                      )
                    : const Text('No icon available'),
              ),
            ),
            const SizedBox(height: 5),
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 124, 163, 249), // Light blue
                      Color.fromARGB(255, 48, 49, 154),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildDataRow(
                          'Humidity',
                          '${response?.current?.humidity ?? ''}%',
                          Icons.opacity),
                      const Divider(color: Color.fromARGB(255, 7, 9, 96)),
                      _buildDataRow(
                          'Wind',
                          '${response?.current?.windMph ?? ''} km/hr',
                          Icons.air),
                      const Divider(color: Color.fromARGB(255, 7, 9, 96)),
                      _buildDataRow('UV Index',
                          '${response?.current?.uv ?? ''}', Icons.wb_sunny),
                      const Divider(color: Color.fromARGB(255, 7, 9, 96)),
                      _buildDataRow(
                          'Precipitation',
                          '${response?.current?.precipMm ?? ''} mm',
                          Icons.grain),
                      const Divider(color: Color.fromARGB(255, 7, 9, 96)),
                      _buildDataRow(
                          'Local Time',
                          '${response?.location?.localtime?.split(" ").last ?? ''}',
                          Icons.access_time),
                      const Divider(color: Color.fromARGB(255, 7, 9, 96)),
                      _buildDataRow(
                          'Local Date',
                          '${response?.location?.localtime?.split(" ").first ?? ''}',
                          Icons.date_range),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDataRow(String title, String data, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: Color.fromARGB(255, 7, 9, 96)),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                color: Color.fromARGB(255, 7, 9, 96),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Text(
          data,
          style: const TextStyle(
            fontSize: 20,
            color: Color.fromARGB(255, 7, 9, 96),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
