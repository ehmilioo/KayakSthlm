import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


import 'information.dart';

class FireScreen extends StatelessWidget {

  int i = 1;

  @override
  Widget build(BuildContext context) {

    Future getCurrentRisk() async {
      String url = "api.msb.se";
      //inte kommit på ett bra sätt att få över koordinater än så kör koordinater för Stockholm bara just nu.
      var response = await http.get(Uri.https(url, '/brandrisk/v2/CurrentRisk/eng/59.34/18.06'));
      var apiData = jsonDecode(response.body);
      List<CurrentRisk> currentRisks = [];

      for(var r in apiData){
        CurrentRisk currentRisk = CurrentRisk(r['periodStartDate'], r['periodEndDate'], r['forecast']);
        currentRisks.add(currentRisk);
      }
    }

    Future getFireProbation() async {
      String url = "api.msb.se";
      //inte kommit på ett bra sätt att få över koordinater än så kör koordinater för Stockholm bara just nu.
      var response = await http.get(Uri.https(url, '/brandrisk/v2/FireProhibition/59.34/18.06'));
      var apiData = jsonDecode(response.body);
      List<CurrentFireProbation> currentFireProbation = [];

      for (var p in apiData) {
        CurrentFireProbation currentFireProbation = CurrentFireProbation(p['county'], p['countyCode'], p['municipality'], p['municipalityCode'], p['fireProhibition']);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Fire Info'),
      ),
      body: Center(
        child: Column(children: <Widget>[
          Card(child: FutureBuilder(
            future: getFireProbation(),
            builder: (context, snapshot) {
              if(snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text('At present there is no fire prohibation in effect in Stockholm'),
                  ),
                );
              } else
                return ListView.builder(
                  itemBuilder: (context, i) {
                    return ListTile(
                      title: Text('Fire Prohibition is currently in effect in ' + snapshot.data.county),
                        // "county": "Stockholm",
                        // "countyCode": "0180",
                        // "municipality": "Stockholms län",
                        // "municipalityCode": "01",
                        // "fireProhibition":
                      subtitle: Text('In ' + snapshot.data.muncipality),
                      trailing: Text(snapshot.data.fireProhibition),
                    );
                  }
                );
            },
          ),
          ),
          Card(child: FutureBuilder(
            future: getCurrentRisk(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text('At present there is no Fire Risk in Stockholm.'),
                  ),
                );
              } else
                return ListView.builder(
                    itemBuilder: (context, i) {
                      return ListTile(
                        title: Text('Stockholm Current Fire Risk'),
                        subtitle: Text('Current risk right now is: ' + snapshot.data.forecast),
                        trailing: Text('Current risk has been ongoing for ' + snapshot.data.periodStartDate + ' to ' + snapshot.data[i].periodEndDate),
                      );
                    }
                );
            },
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
          ),
        ]),
      ),
    );
  }
}

class CurrentFireProbation {

  final String county, countyCode, municipality, municipalityCode;
  final List fireProhibition;

  CurrentFireProbation(this.county, this.countyCode, this.municipality, this.municipalityCode, this.fireProhibition);

}

class CurrentRisk {
  final String periodStartDate, periodEndDate;
  final List forecast;

  CurrentRisk(this.periodStartDate, this.periodEndDate, this.forecast);

}