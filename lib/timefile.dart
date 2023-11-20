import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'dart:convert';
import 'package:intl/intl.dart';
import 'main.dart';

class OnlineTime{

  String? Time;
  String? Location;
  String? Temperature;
  String? URL;
  OnlineTime({this.Location, this.URL, this.Temperature});
  Future<void> gettime() async {

    Response response = await get(
        Uri.parse('https://worldtimeapi.org/api/timezone/$URL'));
    Map Data = {};
    Data = jsonDecode(response.body);

    DateTime currenttime = DateTime.parse(Data['datetime']);
    String Locoffsite = Data['utc_offset'].substring(1, 3);
    currenttime = currenttime.add(Duration(hours: int.parse(Locoffsite)));
    Time = DateFormat.jm().format(currenttime);
    ////////////////////////////
    final weatherUrl = 'https://api.weatherapi.com/v1/current.json?key=9ce6148ebf5e45ea990192255230211&q=${this.Location}&aqi=yes';

    try {
      final weatherResponse = await get(Uri.parse(weatherUrl));
      if (weatherResponse.statusCode == 200) {
        final weatherData = json.decode(weatherResponse.body);
        Temperature = weatherData['current']['temp_c'].toString();
        print('Temperature: $Temperature');
      } else {
        print('Error: Failed to fetch weather data with status code: ${weatherResponse.statusCode}');
      }
    } catch (e) {
      print('Error fetching weather data: $e');
    }

  }

 /* Future<void> getTemperature(String city) async {
    final url = 'https://api.weatherapi.com/v1/current.json?key=9ce6148ebf5e45ea990192255230211&q=Cairo&aqi=yes';

    try {
      final response = await get(
          Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final temperature = data['current']['temp_c'];
        Temperature=temperature;
        print('lllllllllllll$Temperature');
      } else {

        print('no data');
      }
    } catch (e) {
      print('Error fetching weather data: $e');

    }
  }*/

}