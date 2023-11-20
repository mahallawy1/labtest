import 'package:flutter/material.dart';
import 'world_time.dart';
import 'choose_location.dart';
//city
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  void updateData(Map worldTimeData) {
    setState(() {
      data = worldTimeData;
    });
  }

  @override
  Widget build(BuildContext context) {
    // We check if ModalRoute.of(context)?.settings.arguments is not null and cast it safely.
    data = ModalRoute.of(context)?.settings.arguments as Map? ?? data;

    return Scaffold(
      appBar: AppBar(
        title: Text('World Time'),
        centerTitle: true,

        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Container(
        decoration: BoxDecoration(

        ),
        child: Padding(
          padding: EdgeInsets.all(50.0),
          child: Column(
            children: <Widget>[
              TextButton.icon(
                onPressed: () async {
                  dynamic result = await Navigator.pushNamed(context, '/location');
                  if (result != null) {
                    updateData(result);
                  }
                },
                icon: Icon(
                  Icons.edit_location,
                  color: Colors.red[300],
                ),
                label: Text(
                  'Edit Location',
                  style: TextStyle(
                    color: Colors.red[300],
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    data['location'] ?? 'Loading...', // Provide a default value to avoid null
                    style: TextStyle(
                      fontSize: 28.0,
                      letterSpacing: 2.0,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                data['time'] ?? 'Loading...', // Provide a default value to avoid null
                style: TextStyle(
                  fontSize: 66.0,
                  color: Colors.lightGreenAccent,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                data['temperature'] ?? 'Loading...', // Provide a default value to avoid null
                style: TextStyle(
                  fontSize: 66.0,
                  color: Colors.brown,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}