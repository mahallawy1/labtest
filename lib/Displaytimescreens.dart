import 'package:flutter/material.dart';
import 'timefile.dart';
import 'main.dart';

//gettime
class Display extends StatefulWidget {
  final String? time;
  final String? location;
  final String? temperature;

  Display({this.time, this.location, this.temperature});

  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  String? time;
  String? temperature;

  @override
  void initState() {
    super.initState();
    time = widget.time;
    temperature = widget.temperature;
    fetchData();
  }

  Future<void> fetchData() async {
    OnlineTime myTime = OnlineTime(Location: widget.location);
    await myTime.gettime();

    setState(() {
      time = myTime.Time;
      temperature = myTime.Temperature;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('World Time App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Location: ${widget.location}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              'Time: $time', // Use updated time
              style: TextStyle(fontSize: 48),
            ),
            SizedBox(height: 20),
            Text(
              'Temp: $temperature °C', // Use updated temperature
              style: TextStyle(fontSize: 48),
            ),
          ],
        ),
      ),
    );
  }
}
