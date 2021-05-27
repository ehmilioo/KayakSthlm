import 'package:flutter/material.dart';
import 'package:kayak_sthlm/services/database.dart';

class Events extends StatefulWidget  {
  @override
  State<Events> createState() => EventStart();
}

class EventStart extends State<Events> {
  final Database db = new Database();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Information'),
        backgroundColor: Colors.red[600],
        elevation: 0.0,
      ),
      body: Container(

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: FloatingActionButton(
            onPressed: () {
            },
            tooltip: 'Start',
            backgroundColor: Colors.green[200],
            child: Icon(Icons.play_arrow_outlined)),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 10.0,
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                // Navigationsknapp 1: Routes
                icon: Icon(Icons.place_outlined),
                iconSize: 35,
                onPressed: () {},
              ),
              IconButton(
                // Navigationsknapp 2: Events
                icon: Icon(Icons.calendar_today_outlined),
                iconSize: 35,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Events()));
                  },
              ),
              Container(
                  child: Text("Start",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  width: 32,
                  height:
                  30), // En container som innehåller text till mittenknappen och samtidigt sprider ut ikonerna runt mittenknappen
              IconButton(
                // Navigationsknapp 3: Info
                icon: Icon(Icons.info_outline),
                iconSize: 35,
                onPressed: () {},
              ),
              IconButton(
                // Navigationsknapp 4: Settings
                icon: Icon(Icons.follow_the_signs),
                iconSize: 35,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
