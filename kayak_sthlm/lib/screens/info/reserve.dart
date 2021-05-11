import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'information.dart';

class ReserveScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map of Reserves'),
      ),
      body: Center(
          child: Column(
            children: <Widget>[
              BottomAppBar(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: ElevatedButton(
                    child: Text('Rules when moving in nature'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReserveRulesScreen()));
                    },
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xff7c94b6),
                  image: const DecorationImage(
                    image: AssetImage('asset/images/mapNatureReserves.png'),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                    color: Colors.black,
                    width: 8,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: ElevatedButton(
                    child: Text('Back'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InformationScreen()));
                    },
                  ),
                ),
              )
            ],
          )),
    );
  }
}

class ReserveRulesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map of Reserves'),
      ),
      body: Center(
          child: ListView(
            children: <Widget>[
              Text("Avoid plants and trees. You are not allowed to pick protected plants; such as orchids." + "\n",
                  style: TextStyle(fontSize: 20)),
              Text("Avoid bird nests and their children. Do not hurt or pick up snakes, reptiles and frogs nor other animals." + "\n",
                  style: TextStyle(fontSize: 20)),
              Text("Avoid bird and seal sanctuaries when access to those areas is prohibited." + "\n",
                  style: TextStyle(fontSize: 20)),
              Text("Your dog needs to be tethered at all time." + "\n",
                  style: TextStyle(fontSize: 20)),
              Text("Do not start a fire. It is also forbidden to put disposable grills in the garbage due to the fire risk!" + "\n",
                  style: TextStyle(fontSize: 20)),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: ElevatedButton(
                    child: Text('Back'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReserveScreen()));
                    },
                  ),
                ),
              )
            ],
          )),
    );
  }
}