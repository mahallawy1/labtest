import 'package:flutter/material.dart';
import 'world_time.dart';


class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}
//city
class _ChooseLocationState extends State<ChooseLocation> {
  List<WorldTime> locations = [
    WorldTime(location: 'Berlin', url: 'Europe/Berlin'),
    WorldTime(location: 'London', url: 'Europe/London'),
    WorldTime(location: 'Cairo', url: 'Africa/Cairo'),
    // Add more locations here
  ];

  void updateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getTime(); // This should now also update the temperature
    // Navigate back to the home screen with updated time and temperature
    Navigator.pop(context, {
      'location': instance.location,
      'time': instance.time,
      'temperature': instance.temperature, // Pass the temperature here
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose a Location'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue[900],
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                updateTime(index);
              },
              title: Text(locations[index].location),
            ),
          );
        },
      ),
    );
  }
}