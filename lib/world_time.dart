import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // name of the location
  String time; // the time in that location
  String temperature; // the temperature in that location
  String url; // location url for api endpoint
//city
  WorldTime({
    required this.location,
    required this.url,
    this.time = '',
    this.temperature = 'Unavailable', // Default temperature as 'Unavailable'
  });

  final String apiKey = '9ce6148ebf5e45ea990192255230211'; // Use your actual API key here

  Future<void> getTime() async {
    try {
      // Request time data
      var timeResponse = await http.get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map timeData = jsonDecode(timeResponse.body);

      // Get properties from time data
      String datetime = timeData['datetime'];
      String offset = timeData['utc_offset'].substring(1, 3);

      // Create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // Set the time property
      time = DateFormat.jm().format(now);

      // Get temperature
      double temp = await getTemperature(location); // Now it's expected to be double as we declared
      temperature = temp.toStringAsFixed(1); // Format to 1 decimal place
    } catch (e) {
      print('Caught error: $e');
      time = 'Could not get time data';
      temperature = 'Could not get temperature data'; // Provide a default error message
    }
  }

  Future<double> getTemperature(String city) async {
    final url = 'https://api.weatherapi.com/v1/current.json?key=$apiKey&q=$city&aqi=no';

    try {
      final response = await http.get(Uri.parse(url));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['current'] != null && data['current']['temp_c'] != null) {
          final temperature = data['current']['temp_c'];
          return temperature.toDouble();
        } else {
          print('Temperature data is not available in the response.');
          return double.nan;
        }
      } else {
        print('Error: Server returned status code ${response.statusCode}');
        return double.nan;
      }
    } catch (e) {
      print('Error fetching weather data: $e');
      return double.nan;
    }
  }


}