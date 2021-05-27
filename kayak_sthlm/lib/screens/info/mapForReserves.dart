import 'dart:collection';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kayak_sthlm/dialogs/preserve_dialog.dart';
import 'package:kayak_sthlm/dialogs/reserveRules_dialog.dart';
import 'information.dart';

class WildlifePreserves extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wildlife Preserves',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  //bound limits
  static final sthlmNE = LatLng(60.380987, 19.644660);
  static final sthlmSW = LatLng(58.653765, 17.205695);
  LatLng pinPosition = LatLng(59.33879, 18.08487);

  //adding custom pins for nature reserved areas
  BitmapDescriptor pinLocation;
  List<Marker> _markers = <Marker>[];
  Set<Polygon> _polygons = HashSet<Polygon>();
  Set<RPA> rpas = HashSet<RPA>();

  @override
  void initState() {
    super.initState();
    dataBasePrep();
  }

  void addReserve1() {
    // ignore: deprecated_member_use
    List<LatLng> polygonLatLngs = List<LatLng>();
    LatLng point1 = LatLng(59.297673, 18.273069);
    LatLng point2 = LatLng(59.307992, 18.296758);
    LatLng point3 = LatLng(59.297117, 18.300983);
    LatLng point4 = LatLng(59.290355, 18.275072);
    polygonLatLngs.add(point1);
    polygonLatLngs.add(point2);
    polygonLatLngs.add(point3);
    polygonLatLngs.add(point4);
    var rpa = RPA('Skogsö Naturreservat', 'Protected since: 1997',
        'Size: 148 hectare', 59.297673, 18.273069, polygonLatLngs);
    rpas.add(rpa);
    _setPolygon(rpa);
  }

  void addReserve2() {
    // ignore: deprecated_member_use
    List<LatLng> polygonLatLngs = List<LatLng>();
    LatLng point1 = LatLng(59.399235, 18.112119);
    LatLng point2 = LatLng(59.413404, 18.106148);
    LatLng point3 = LatLng(59.412489, 18.123150);
    polygonLatLngs.add(point1);
    polygonLatLngs.add(point2);
    polygonLatLngs.add(point3);
    var rpa = RPA('Öarna i Stora Värtan Naturreservat', 'Protected since: 2000',
        'Size: 115 hectare', 59.399235, 18.112119, polygonLatLngs);
    rpas.add(rpa);
    _setPolygon(rpa);
  }

  void addReserve3() {
    // ignore: deprecated_member_use
    List<LatLng> polygonLatLngs = List<LatLng>();
    LatLng point1 = LatLng(59.398822, 18.150283);
    LatLng point2 = LatLng(59.414791, 18.158335);
    LatLng point3 = LatLng(59.396780, 18.339913);
    LatLng point4 = LatLng(59.378234, 18.262887);
    polygonLatLngs.add(point1);
    polygonLatLngs.add(point2);
    polygonLatLngs.add(point3);
    polygonLatLngs.add(point4);
    var rpa = RPA('Bogesundslandet Naturreservat', 'Protected since: 2013',
        'Size: 4341 hectare', 59.398822, 18.150283, polygonLatLngs);
    rpas.add(rpa);
    _setPolygon(rpa);
  }

  void addReserve4() {
    // ignore: deprecated_member_use
    List<LatLng> polygonLatLngs = List<LatLng>();
    LatLng point1 = LatLng(59.398822, 18.150283);
    LatLng point2 = LatLng(59.414791, 18.158335);
    LatLng point3 = LatLng(59.396780, 18.339913);
    LatLng point4 = LatLng(59.378234, 18.262887);
    polygonLatLngs.add(point1);
    polygonLatLngs.add(point2);
    polygonLatLngs.add(point3);
    polygonLatLngs.add(point4);
    var rpa = RPA('Bogesundslandet Naturreservat', 'Protected since: 2013',
        'Size: 4341 hectare', 59.398822, 18.150283, polygonLatLngs);
    rpas.add(rpa);
    _setPolygon(rpa);
  }

  void addReserve5() {
    // ignore: deprecated_member_use
    List<LatLng> polygonLatLngs = List<LatLng>();
    LatLng point1 = LatLng(59.308515, 18.038820);
    LatLng point2 = LatLng(59.305743, 18.046567);
    LatLng point3 = LatLng(59.308009, 18.049062);
    polygonLatLngs.add(point1);
    polygonLatLngs.add(point2);
    polygonLatLngs.add(point3);
    var rpa = RPA(
        'Årstaskogen - Årsta holmar Naturreservat',
        'Protected since: 2018',
        'Size: 66 hectare',
        null,
        null,
        polygonLatLngs);
    rpas.add(rpa);
    _setPolygon(rpa);
  }

  void addReserve6() {
    // ignore: deprecated_member_use
    List<LatLng> polygonLatLngs = List<LatLng>();
    LatLng point1 = LatLng(59.305190, 18.038977);
    LatLng point2 = LatLng(59.301020, 18.041005);
    LatLng point3 = LatLng(59.301085, 18.077578);
    LatLng point4 = LatLng(59.302601, 18.063762);
    polygonLatLngs.add(point1);
    polygonLatLngs.add(point2);
    polygonLatLngs.add(point3);
    polygonLatLngs.add(point4);
    var rpa = RPA(
        'Årstaskogen - Årsta holmar Naturreservat',
        'Protected since: 2018',
        'Size: 66 hectare',
        59.305190,
        18.038977,
        polygonLatLngs);
    rpas.add(rpa);
    _setPolygon(rpa);
  }

  void addReserve7() {
    // ignore: deprecated_member_use
    List<LatLng> polygonLatLngs = List<LatLng>();
    LatLng point1 = LatLng(59.453098, 18.303564);
    LatLng point2 = LatLng(59.465502, 18.292029);
    LatLng point3 = LatLng(59.460147, 18.284563);
    polygonLatLngs.add(point1);
    polygonLatLngs.add(point2);
    polygonLatLngs.add(point3);
    var rpa = RPA('Näsudden Naturreservat', 'Protected since: 2010',
        'Size: 72 hectare', 59.453098, 18.303564, polygonLatLngs);
    rpas.add(rpa);
    _setPolygon(rpa);
  }

  void addReserve8() {
    // ignore: deprecated_member_use
    List<LatLng> polygonLatLngs = List<LatLng>();
    LatLng point1 = LatLng(59.459740, 18.128502);
    LatLng point2 = LatLng(59.453505, 18.115449);
    LatLng point3 = LatLng(59.471238, 18.103737);
    LatLng point4 = LatLng(59.472524, 18.116150);
    polygonLatLngs.add(point1);
    polygonLatLngs.add(point2);
    polygonLatLngs.add(point3);
    polygonLatLngs.add(point4);
    var rpa = RPA(
        'Rönninge by-Skavlöten Naturreservat',
        'Protected since: 2002',
        'Size: 179 hectare',
        59.459740,
        18.128502,
        polygonLatLngs);
    rpas.add(rpa);
    _setPolygon(rpa);
  }

  void addReserve9() {
    // ignore: deprecated_member_use
    List<LatLng> polygonLatLngs = List<LatLng>();
    LatLng point1 = LatLng(59.297673, 18.273069);
    LatLng point2 = LatLng(59.307992, 18.296758);
    LatLng point3 = LatLng(59.297117, 18.300983);
    LatLng point4 = LatLng(59.290355, 18.275072);
    polygonLatLngs.add(point1);
    polygonLatLngs.add(point2);
    polygonLatLngs.add(point3);
    polygonLatLngs.add(point4);
    var rpa = RPA('Grinda Naturreservat', 'Protected since: 2000',
        'Size: 503 hectare', 59.297673, 18.273069, polygonLatLngs);
    rpas.add(rpa);
    _setPolygon(rpa);
  }

  void addReserve10() {
    // ignore: deprecated_member_use
    List<LatLng> polygonLatLngs = List<LatLng>();
    LatLng point1 = LatLng(59.388173, 18.591274);
    LatLng point2 = LatLng(59.382758, 18.598141);
    LatLng point3 = LatLng(59.387202, 18.607784);
    LatLng point4 = LatLng(59.389287, 18.604764);
    LatLng point5 = LatLng(59.390993, 18.612784);
    LatLng point6 = LatLng(59.396677, 18.608526);
    polygonLatLngs.add(point1);
    polygonLatLngs.add(point2);
    polygonLatLngs.add(point3);
    polygonLatLngs.add(point4);
    polygonLatLngs.add(point5);
    polygonLatLngs.add(point6);
    var rpa = RPA('Gällnö Västerholmen Naturreservat', 'Protected since: 1978',
        'Size: 204 hectare', 59.388173, 18.591274, polygonLatLngs);
    rpas.add(rpa);
    _setPolygon(rpa);
  }

  void addReserve11() {
    // ignore: deprecated_member_use
    List<LatLng> polygonLatLngs = List<LatLng>();
    LatLng point1 = LatLng(59.482937, 18.706401);
    LatLng point2 = LatLng(59.496353, 18.713083);
    LatLng point3 = LatLng(59.506443, 18.778272);
    LatLng point4 = LatLng(59.499092, 18.798064);
    LatLng point5 = LatLng(59.499831, 18.812094);
    LatLng point6 = LatLng(59.496603, 18.811769);
    LatLng point7 = LatLng(59.497471, 18.801424);
    LatLng point8 = LatLng(59.493095, 18.800114);
    LatLng point9 = LatLng(59.492513, 18.813329);
    polygonLatLngs.add(point1);
    polygonLatLngs.add(point2);
    polygonLatLngs.add(point3);
    polygonLatLngs.add(point4);
    polygonLatLngs.add(point5);
    polygonLatLngs.add(point6);
    polygonLatLngs.add(point7);
    polygonLatLngs.add(point8);
    polygonLatLngs.add(point9);
    var rpa = RPA('Äpplarö Naturreservat', 'Protected since: 1972',
        'Size: 933 hectare', 59.482937, 18.706401, polygonLatLngs);
    rpas.add(rpa);
    _setPolygon(rpa);
  }

  void addReserve12() {
    // ignore: deprecated_member_use
    List<LatLng> polygonLatLngs = List<LatLng>();
    LatLng point1 = LatLng(59.309940, 17.952465);
    LatLng point2 = LatLng(59.351478, 17.844888);
    LatLng point3 = LatLng(59.355374, 17.802533);
    LatLng point4 = LatLng(59.326743, 17.785612);
    LatLng point5 = LatLng(59.301024, 17.842541);
    LatLng point6 = LatLng(59.296014, 17.870714);
    LatLng point7 = LatLng(59.308170, 17.894602);
    LatLng point8 = LatLng(59.299814, 17.920613);
    polygonLatLngs.add(point1);
    polygonLatLngs.add(point2);
    polygonLatLngs.add(point3);
    polygonLatLngs.add(point4);
    polygonLatLngs.add(point5);
    polygonLatLngs.add(point6);
    polygonLatLngs.add(point7);
    polygonLatLngs.add(point8);
    var rpa = RPA('Äpplarö Naturreservat', 'Protected since: 2014',
        'Size: 3225 hectare', 59.309940, 17.952465, polygonLatLngs);
    rpas.add(rpa);
    _setPolygon(rpa);
  }

  void addReserve13() {
    // ignore: deprecated_member_use
    List<LatLng> polygonLatLngs = List<LatLng>();
    LatLng point1 = LatLng(59.302322, 17.937932);
    LatLng point2 = LatLng(59.285935, 17.870885);
    LatLng point3 = LatLng(59.281630, 17.910636);
    polygonLatLngs.add(point1);
    polygonLatLngs.add(point2);
    polygonLatLngs.add(point3);
    var rpa = RPA('Sätraskogen Naturreservat', 'Protected since: 2006',
        'Size: 256 hectare', 59.281630, 17.910636, polygonLatLngs);
    rpas.add(rpa);
    _setPolygon(rpa);
  }

  void addReserve14() {
    // ignore: deprecated_member_use
    List<LatLng> polygonLatLngs = List<LatLng>();
    LatLng point1 = LatLng(59.431786, 18.628696);
    LatLng point2 = LatLng(59.424030, 18.635596);
    LatLng point3 = LatLng(59.421545, 18.629963);
    LatLng point4 = LatLng(59.429020, 18.625416);
    polygonLatLngs.add(point1);
    polygonLatLngs.add(point2);
    polygonLatLngs.add(point3);
    polygonLatLngs.add(point4);
    var rpa = RPA('Karklö Naturreservat', 'Protected since: 2017',
        'Size: 122 hectare', 59.431786, 18.628696, polygonLatLngs);
    rpas.add(rpa);
    _setPolygon(rpa);
  }

  void addReserve15() {
    // ignore: deprecated_member_use
    List<LatLng> polygonLatLngs = List<LatLng>();
    LatLng point1 = LatLng(59.254017, 18.331659);
    LatLng point2 = LatLng(59.270506, 18.320658);
    LatLng point3 = LatLng(59.261743, 18.303775);
    LatLng point4 = LatLng(59.254388, 18.307915);
    polygonLatLngs.add(point1);
    polygonLatLngs.add(point2);
    polygonLatLngs.add(point3);
    polygonLatLngs.add(point4);
    var rpa = RPA('Svärdsö Naturreservat', 'Protected since: 2014',
        'Size: 148 hectare', 59.254017, 18.331659, polygonLatLngs);
    rpas.add(rpa);
    _setPolygon(rpa);
  }

  void addReserve16() {
    // ignore: deprecated_member_use
    List<LatLng> polygonLatLngs = List<LatLng>();
    LatLng point1 = LatLng(59.295264, 18.345139);
    LatLng point2 = LatLng(59.296631, 18.354092);
    LatLng point3 = LatLng(59.298594, 18.346310);
    LatLng point4 = LatLng(59.297190, 18.344094);
    polygonLatLngs.add(point1);
    polygonLatLngs.add(point2);
    polygonLatLngs.add(point3);
    polygonLatLngs.add(point4);
    var rpa = RPA('Storängsudd Naturreservat', 'Protected since: 1936',
        'Size: 10 hectare', 59.295264, 18.345139, polygonLatLngs);
    rpas.add(rpa);
    _setPolygon(rpa);
  }

  void addReserve17() {
    // ignore: deprecated_member_use
    List<LatLng> polygonLatLngs = List<LatLng>();
    LatLng point1 = LatLng(59.22469538192507, 18.275935380652083);
    LatLng point2 = LatLng(59.21860822426752, 18.246317948131644);
    LatLng point3 = LatLng(59.19984301093744, 18.268166873761476);
    LatLng point4 = LatLng(59.18355489977092, 18.211845198485467);
    LatLng point5 = LatLng(59.163028288423234, 18.24947390359502);
    LatLng point6 = LatLng(59.16987186140362, 18.274236019308827);
    LatLng point7 = LatLng(59.15402772456425, 18.301106178869812);
    LatLng point8 = LatLng(59.16705145583326, 18.406769964081473);
    LatLng point9 = LatLng(59.19944126880667, 18.38049836826287);
    LatLng point10 = LatLng(59.21244770964145, 18.328532572634547);
    polygonLatLngs.add(point1);
    polygonLatLngs.add(point2);
    polygonLatLngs.add(point3);
    polygonLatLngs.add(point4);
    polygonLatLngs.add(point5);
    polygonLatLngs.add(point6);
    polygonLatLngs.add(point7);
    polygonLatLngs.add(point8);
    polygonLatLngs.add(point9);
    polygonLatLngs.add(point10);
    var rpa = RPA(
        'Tyresta Naturreservat',
        'Protected since: 1936',
        'Size: 4900 hectare',
        59.15402772456425,
        18.301106178869812,
        polygonLatLngs);
    rpas.add(rpa);
    _setPolygon(rpa);
  }

  void addReserve18() {
    // ignore: deprecated_member_use
    List<LatLng> polygonLatLngs = List<LatLng>();
    LatLng point1 = LatLng(59.242917830347835, 18.252011375499475);
    LatLng point2 = LatLng(59.226898682022984, 18.262086157873227);
    LatLng point3 = LatLng(59.22609131652503, 18.278837000856104);
    LatLng point4 = LatLng(59.23521964382928, 18.273374769448644);
    LatLng point5 = LatLng(59.23497128629833, 18.28454199810389);
    LatLng point6 = LatLng(59.22801654117301, 18.28514891270472);
    LatLng point7 = LatLng(59.22702289040393, 18.297529970561623);
    LatLng point8 = LatLng(59.235840529744785, 18.292189122074333);
    LatLng point9 = LatLng(59.24378687134164, 18.270340196352315);
    polygonLatLngs.add(point1);
    polygonLatLngs.add(point2);
    polygonLatLngs.add(point3);
    polygonLatLngs.add(point4);
    polygonLatLngs.add(point5);
    polygonLatLngs.add(point6);
    polygonLatLngs.add(point7);
    polygonLatLngs.add(point8);
    polygonLatLngs.add(point9);
    var rpa = RPA(
        'Alvik Naturreservat',
        'Protected since: 1975',
        'Size: 287 hectare',
        59.242917830347835,
        18.252011375499475,
        polygonLatLngs);
    rpas.add(rpa);
    _setPolygon(rpa);
  }

  void addReserve19() {
    // ignore: deprecated_member_use
    List<LatLng> polygonLatLngs = List<LatLng>();
    LatLng point1 = LatLng(59.19575706448923, 18.412190766646113);
    LatLng point2 = LatLng(59.19675162568527, 18.42080895397788);
    LatLng point3 = LatLng(59.201599696867206, 18.417531615133406);
    LatLng point4 = LatLng(59.206882067869415, 18.409398959482303);
    LatLng point5 = LatLng(59.20246979065205, 18.402237367192523);
    polygonLatLngs.add(point1);
    polygonLatLngs.add(point2);
    polygonLatLngs.add(point3);
    polygonLatLngs.add(point4);
    polygonLatLngs.add(point5);
    var rpa = RPA(
        'Sandholmarna Naturreservat',
        'Protected since: 1995',
        'Size: 75 hectare',
        59.19575706448923,
        18.412190766646113,
        polygonLatLngs);
    rpas.add(rpa);
    _setPolygon(rpa);
  }

  void addReserve20() {
    // ignore: deprecated_member_use
    List<LatLng> polygonLatLngs = List<LatLng>();
    LatLng point1 = LatLng(59.196565147666654, 18.409277576562136);
    LatLng point2 = LatLng(59.196813784798586, 18.39859587958755);
    LatLng point3 = LatLng(59.19208936981561, 18.404786408516003);
    polygonLatLngs.add(point1);
    polygonLatLngs.add(point2);
    polygonLatLngs.add(point3);
    var rpa = RPA(
        'Dyviks lövängar Naturreservat',
        'Protected since: 2011',
        'Size: 17 hectare',
        59.196565147666654,
        18.409277576562136,
        polygonLatLngs);
    rpas.add(rpa);
    _setPolygon(rpa);
  }

  void addReserve21() {
    // ignore: deprecated_member_use
    List<LatLng> polygonLatLngs = List<LatLng>();
    LatLng point1 = LatLng(59.2152700368881, 18.340574842546353);
    LatLng point2 = LatLng(59.20980255777839, 18.34992132739911);
    LatLng point3 = LatLng(59.20936760706901, 18.36290929985685);
    LatLng point4 = LatLng(59.21278492766337, 18.361209938974525);
    LatLng point5 = LatLng(59.21371686482377, 18.354776644205742);
    LatLng point6 = LatLng(59.22148201853216, 18.34955717851807);
    LatLng point7 = LatLng(59.21607765848524, 18.34676537135426);
    polygonLatLngs.add(point1);
    polygonLatLngs.add(point2);
    polygonLatLngs.add(point3);
    polygonLatLngs.add(point4);
    polygonLatLngs.add(point5);
    polygonLatLngs.add(point6);
    polygonLatLngs.add(point7);
    var rpa = RPA(
        'Klövberget Naturreservat',
        'Protected since: 2011',
        'Size: 61 hectare',
        59.2152700368881,
        18.340574842546353,
        polygonLatLngs);
    rpas.add(rpa);
    _setPolygon(rpa);
  }

  void addReserve22() {
    // ignore: deprecated_member_use
    List<LatLng> polygonLatLngs = List<LatLng>();
    LatLng point1 = LatLng(59.11817770304928, 18.32627054713121);
    LatLng point2 = LatLng(59.12875876904907, 18.335865170600606);
    LatLng point3 = LatLng(59.13546191156134, 18.36771115488201);
    LatLng point4 = LatLng(59.13619498817842, 18.380776174074377);
    LatLng point5 = LatLng(59.133262587543825, 18.384042428872473);
    LatLng point6 = LatLng(59.125825731623394, 18.376489214651887);
    LatLng point7 = LatLng(59.11985412937611, 18.360974504360943);
    LatLng point8 = LatLng(59.11461502476618, 18.332803056727393);
    polygonLatLngs.add(point1);
    polygonLatLngs.add(point2);
    polygonLatLngs.add(point3);
    polygonLatLngs.add(point4);
    polygonLatLngs.add(point5);
    polygonLatLngs.add(point6);
    polygonLatLngs.add(point7);
    polygonLatLngs.add(point8);
    var rpa = RPA(
        'Sandemar Naturreservat',
        'Protected since: 1997',
        'Size: 390 hectare',
        59.11817770304928,
        18.32627054713121,
        polygonLatLngs);
    rpas.add(rpa);
    _setPolygon(rpa);
  }

  void addReserve23() {
    // ignore: deprecated_member_use
    List<LatLng> polygonLatLngs = List<LatLng>();
    LatLng point1 = LatLng(59.11419586123799, 18.248084570081335);
    LatLng point2 = LatLng(59.11126157687951, 18.25788333447561);
    LatLng point3 = LatLng(59.11157597650543, 18.284625795634994);
    LatLng point4 = LatLng(59.1064404214733, 18.29258729170535);
    LatLng point5 = LatLng(59.11189037324748, 18.328720235641807);
    LatLng point6 = LatLng(59.09333603035089, 18.356075120291397);
    LatLng point7 = LatLng(59.09333603035089, 18.357708247690447);
    LatLng point8 = LatLng(59.081380458848294, 18.334640323161032);
    LatLng point9 = LatLng(59.07361759473207, 18.345051510329952);
    LatLng point10 = LatLng(59.06427885113566, 18.31340966697343);
    LatLng point11 = LatLng(59.052733073249684, 18.24971769759964);
    LatLng point12 = LatLng(59.05819156093437, 18.21603444499431);
    LatLng point13 = LatLng(59.08725389175035, 18.20664396144801);
    polygonLatLngs.add(point1);
    polygonLatLngs.add(point2);
    polygonLatLngs.add(point3);
    polygonLatLngs.add(point4);
    polygonLatLngs.add(point5);
    polygonLatLngs.add(point6);
    polygonLatLngs.add(point7);
    polygonLatLngs.add(point8);
    polygonLatLngs.add(point9);
    polygonLatLngs.add(point10);
    polygonLatLngs.add(point11);
    polygonLatLngs.add(point12);
    polygonLatLngs.add(point13);
    var rpa = RPA(
        'Gålö Naturreservat',
        'Protected since: 1982',
        'Size: 3833 hectare',
        59.11419586123799,
        18.248084570081335,
        polygonLatLngs);
    rpas.add(rpa);
    _setPolygon(rpa);
  }

  void addReserve24() {
    // ignore: deprecated_member_use
    List<LatLng> polygonLatLngs = List<LatLng>();
    LatLng point1 = LatLng(59.03038590499158, 18.287099816675966);
    LatLng point2 = LatLng(58.99821725762443, 18.23886297116115);
    LatLng point3 = LatLng(58.98636737788886, 18.24435613494787);
    LatLng point4 = LatLng(58.981856277558, 18.287614800716565);
    LatLng point5 = LatLng(58.943266675743075, 18.328126884699707);
    LatLng point6 = LatLng(58.96318642794363, 18.391469932745252);
    LatLng point7 = LatLng(59.011828251105676, 18.332242493356333);
    polygonLatLngs.add(point1);
    polygonLatLngs.add(point2);
    polygonLatLngs.add(point3);
    polygonLatLngs.add(point4);
    polygonLatLngs.add(point5);
    polygonLatLngs.add(point6);
    polygonLatLngs.add(point7);
    var rpa = RPA(
        'Utö Naturreservat',
        'Protected since: 1974',
        'Size: 4179 hectare',
        59.03038590499158,
        18.287099816675966,
        polygonLatLngs);
    rpas.add(rpa);
    _setPolygon(rpa);
  }

  void addReserve25() {
    // ignore: deprecated_member_use
    List<LatLng> polygonLatLngs = List<LatLng>();
    LatLng point1 = LatLng(59.011828251105676, 18.332242493356333);
    LatLng point2 = LatLng(59.0303099139965, 18.326542491870068);
    LatLng point3 = LatLng(59.03225321349422, 18.37495099875682);
    LatLng point4 = LatLng(59.001677690292304, 18.452713603308858);
    LatLng point5 = LatLng(59.003441796971316, 18.527020601151328);
    LatLng point6 = LatLng(58.991838780911195, 18.717085235120926);
    LatLng point7 = LatLng(58.895794413377516, 18.537032936525733);
    LatLng point8 = LatLng(58.98134774680124, 18.471450806671456);
    LatLng point9 = LatLng(58.978870776645145, 18.4323120138694);
    LatLng point10 = LatLng(58.953914218886155, 18.42510223624797);
    LatLng point11 = LatLng(58.951612349890134, 18.393173221067343);
    polygonLatLngs.add(point1);
    polygonLatLngs.add(point2);
    polygonLatLngs.add(point3);
    polygonLatLngs.add(point4);
    polygonLatLngs.add(point5);
    polygonLatLngs.add(point6);
    polygonLatLngs.add(point7);
    polygonLatLngs.add(point8);
    polygonLatLngs.add(point9);
    polygonLatLngs.add(point10);
    polygonLatLngs.add(point11);
    var rpa = RPA(
        'Sundby Naturreservat',
        'Protected since: 1965',
        'Size: 5175 hectare',
        59.011828251105676,
        18.332242493356333,
        polygonLatLngs);
    rpas.add(rpa);
    _setPolygon(rpa);
  }

  void addReserve26() {
    // ignore: deprecated_member_use
    List<LatLng> polygonLatLngs = List<LatLng>();
    LatLng point1 = LatLng(59.06789784800449, 18.529172130014715);
    LatLng point2 = LatLng(59.037413980879315, 18.573853165498637);
    LatLng point3 = LatLng(59.038120501946025, 18.61642518573947);
    LatLng point4 = LatLng(59.01612322475785, 18.686978010333412);
    LatLng point5 = LatLng(58.97066923553259, 18.7369806202661);
    LatLng point6 = LatLng(59.003327911004746, 18.568640290211796);
    LatLng point7 = LatLng(59.03443191457614, 18.545980988905264);
    LatLng point8 = LatLng(59.01852997164521, 18.48761612058075);
    LatLng point9 = LatLng(59.02294791558813, 18.465300141907793);
    LatLng point10 = LatLng(59.05438727753432, 18.488989412087786);
    polygonLatLngs.add(point1);
    polygonLatLngs.add(point2);
    polygonLatLngs.add(point3);
    polygonLatLngs.add(point4);
    polygonLatLngs.add(point5);
    polygonLatLngs.add(point6);
    polygonLatLngs.add(point7);
    polygonLatLngs.add(point8);
    polygonLatLngs.add(point9);
    polygonLatLngs.add(point10);
    var rpa = RPA(
        'Fjärdlång Naturreservat',
        'Protected since: 1986',
        'Size: 5100 hectare',
        59.06789784800449,
        18.529172130014715,
        polygonLatLngs);
    rpas.add(rpa);
    _setPolygon(rpa);
  }

  void addReserve27() {
    // ignore: deprecated_member_use
    List<LatLng> polygonLatLngs = List<LatLng>();
    LatLng point1 = LatLng(59.651857, 18.740128);
    LatLng point2 = LatLng(59.649439, 18.743381);
    LatLng point3 = LatLng(59.646303, 18.729977);
    LatLng point4 = LatLng(59.650821, 18.723357);
    LatLng point5 = LatLng(59.647809, 18.720078);
    LatLng point6 = LatLng(59.666515, 18.679863);
    LatLng point7 = LatLng(59.674342, 18.707576);
    polygonLatLngs.add(point1);
    polygonLatLngs.add(point2);
    polygonLatLngs.add(point3);
    polygonLatLngs.add(point4);
    polygonLatLngs.add(point5);
    polygonLatLngs.add(point6);
    polygonLatLngs.add(point7);
    var rpa = RPA(
        'Tranvik Naturreservat',
        'Protected since: 1978',
        'Size: 370 hectare',
        59.651857,
        18.740128,
        polygonLatLngs);
    rpas.add(rpa);
    _setPolygon(rpa);
  }

  void addReserve28() {
    // ignore: deprecated_member_use
    List<LatLng> polygonLatLngs = List<LatLng>();
    LatLng point1 = LatLng(59.663181, 18.794586);
    LatLng point2 = LatLng(59.657982, 18.799821);
    LatLng point3 = LatLng(59.658555, 18.805073);
    LatLng point4 = LatLng(59.654714, 18.804873);
    LatLng point5 = LatLng(59.655878, 18.796293);
    LatLng point6 = LatLng(59.654988, 18.790730);
    LatLng point7 = LatLng(59.661638, 18.790606);
    polygonLatLngs.add(point1);
    polygonLatLngs.add(point2);
    polygonLatLngs.add(point3);
    polygonLatLngs.add(point4);
    polygonLatLngs.add(point5);
    polygonLatLngs.add(point6);
    polygonLatLngs.add(point7);
    var rpa = RPA(
        'Stensholmens Naturreservat',
        'Protected since: 1971',
        'Size: 46 hectare',
        59.663181,
        18.794586,
        polygonLatLngs);
    rpas.add(rpa);
    _setPolygon(rpa);
  }

  void addReserve29() {
    // ignore: deprecated_member_use
    List<LatLng> polygonLatLngs = List<LatLng>();
    LatLng point1 = LatLng(59.588368, 18.973087);
    LatLng point2 = LatLng(59.589086, 18.990934);
    LatLng point3 = LatLng(59.584034, 18.990290);
    LatLng point4 = LatLng(59.580952, 18.975104);
    LatLng point5 = LatLng(59.586872, 18.972306);
    polygonLatLngs.add(point1);
    polygonLatLngs.add(point2);
    polygonLatLngs.add(point3);
    polygonLatLngs.add(point4);
    polygonLatLngs.add(point5);
    var rpa = RPA(
        'Salskären Naturreservat',
        'Protected since: 1973',
        'Size: 75 hectare',
        59.588368,
        18.973087,
        polygonLatLngs);
    rpas.add(rpa);
    _setPolygon(rpa);
  }

  void addReserve30() {
    // ignore: deprecated_member_use
    List<LatLng> polygonLatLngs = List<LatLng>();
    LatLng point1 = LatLng(59.460616, 19.506813);
    LatLng point2 = LatLng(59.411050, 19.455390);
    LatLng point3 = LatLng(59.405077, 19.493510);
    LatLng point4 = LatLng(59.453394, 19.536168);
    polygonLatLngs.add(point1);
    polygonLatLngs.add(point2);
    polygonLatLngs.add(point3);
    polygonLatLngs.add(point4);
    var rpa = RPA(
        'Svenska Högarna Naturreservat',
        'Protected since: 1976',
        'Size: 107 hectare',
        59.460616,
        19.506813,
        polygonLatLngs);
    rpas.add(rpa);
    _setPolygon(rpa);
  }

  void addReserve31() {
    // ignore: deprecated_member_use
    List<LatLng> polygonLatLngs = List<LatLng>();
    LatLng point1 = LatLng(59.481637, 19.214494);
    LatLng point2 = LatLng(59.447569, 19.275021);
    LatLng point3 = LatLng(59.405110, 19.190689);
    LatLng point4 = LatLng(59.430324, 19.157256);
    polygonLatLngs.add(point1);
    polygonLatLngs.add(point2);
    polygonLatLngs.add(point3);
    polygonLatLngs.add(point4);
    var rpa = RPA(
        'Stora Nassa Naturreservat',
        'Protected since: 1965',
        'Size: 276 hectare',
        59.481637,
        19.214494,
        polygonLatLngs);
    rpas.add(rpa);
    _setPolygon(rpa);
  }

  void addReserve32() {
    // ignore: deprecated_member_use
    List<LatLng> polygonLatLngs = List<LatLng>();
    LatLng point1 = LatLng(59.375856, 18.863727);
    LatLng point2 = LatLng(59.348450, 18.945344);
    LatLng point3 = LatLng(59.353663, 19.026292);
    LatLng point4 = LatLng(59.393760, 19.058120);
    LatLng point5 = LatLng(59.457980, 19.020449);
    polygonLatLngs.add(point1);
    polygonLatLngs.add(point2);
    polygonLatLngs.add(point3);
    polygonLatLngs.add(point4);
    polygonLatLngs.add(point5);
    var rpa = RPA(
        'Storö-Bockö-Lökaö Naturreservat',
        'Protected since: 1972',
        'Size: 1876 hectare',
        59.375856,
        18.863727,
        polygonLatLngs);
    rpas.add(rpa);
    _setPolygon(rpa);
  }
  void addReserve33() {
    // ignore: deprecated_member_use
    List<LatLng> polygonLatLngs = List<LatLng>();
    LatLng point1 = LatLng(59.476266, 18.892507);
    LatLng point2 = LatLng(59.479829, 18.877942);
    LatLng point3 = LatLng(59.478151, 18.925288);
    LatLng point4 = LatLng(59.463583, 18.906200);
    LatLng point5 = LatLng(59.468460, 18.897781);
    polygonLatLngs.add(point1);
    polygonLatLngs.add(point2);
    polygonLatLngs.add(point3);
    polygonLatLngs.add(point4);
    polygonLatLngs.add(point5);
    var rpa = RPA(
        'Finnhamn Naturreservat',
        'Protected since: 1972',
        'Size: 190 hectare',
        59.476266,
        18.892507,
        polygonLatLngs);
    rpas.add(rpa);
    _setPolygon(rpa);
  }
  void addReserve34() {
    // ignore: deprecated_member_use
    List<LatLng> polygonLatLngs = List<LatLng>();
    LatLng point1 = LatLng(59.519565, 18.877613);
    LatLng point2 = LatLng(59.524583, 18.873067);
    LatLng point3 = LatLng(59.522472, 18.867350);
    LatLng point4 = LatLng(59.525999, 18.863840);
    LatLng point5 = LatLng(59.532106, 18.892460);
    polygonLatLngs.add(point1);
    polygonLatLngs.add(point2);
    polygonLatLngs.add(point3);
    polygonLatLngs.add(point4);
    polygonLatLngs.add(point5);
    var rpa = RPA(
        'Hallonstenarna Naturreservat',
        'Protected since: 1973',
        'Size: 44 hectare',
        59.519565,
        18.877613,
        polygonLatLngs);
    rpas.add(rpa);
    _setPolygon(rpa);
  }
  void addReserve35() {
    // ignore: deprecated_member_use
    List<LatLng> polygonLatLngs = List<LatLng>();
    LatLng point1 = LatLng(59.529171, 18.836586);
    LatLng point2 = LatLng(59.530654, 18.829934);
    LatLng point3 = LatLng(59.534295, 18.833942);
    LatLng point4 = LatLng(59.531370, 18.838624);
    LatLng point5 = LatLng(59.529853, 18.838882);
    polygonLatLngs.add(point1);
    polygonLatLngs.add(point2);
    polygonLatLngs.add(point3);
    polygonLatLngs.add(point4);
    polygonLatLngs.add(point5);
    var rpa = RPA(
        'Halsfambaken Naturreservat',
        'Protected since: 1974',
        'Size: 60 hectare',
        59.529171,
        18.836586,
        polygonLatLngs);
    rpas.add(rpa);
    _setPolygon(rpa);
  }

  void dataBasePrep() {
    addReserve1();
    addReserve2();
    addReserve3();
    addReserve5();
    addReserve6();
    addReserve7();
    addReserve8();
    addReserve9();
    addReserve10();
    addReserve11();
    addReserve12();
    addReserve13();
    addReserve14();
    addReserve15();
    addReserve16();
    addReserve17();
    addReserve18();
    addReserve19();
    addReserve20();
    addReserve21();
    addReserve22();
    addReserve23();
    addReserve24();
    addReserve25();
    addReserve26();
    addReserve27();
    addReserve28();
    addReserve29();
    addReserve30();
    addReserve31();
    addReserve32();
    addReserve33();
    addReserve34();
    addReserve35();
  }

  void _setPolygon(RPA rpa) {
    final String polygonIdVal = 'polygon_id_$rpa.id';
    _polygons.add(Polygon(
      polygonId: PolygonId(polygonIdVal),
      points: rpa.polygonLatLngs,
      strokeWidth: 2,
      strokeColor: Colors.red,
      fillColor: Colors.redAccent.withOpacity(0.15),
      // onTap: () {
      //   showDialog(
      //       context: context,
      //       builder: (_) => new AlertDialog(
      //             title: new Text(rpa.id),
      //             content: new Text(rpa.protectionInfo + '\n' + rpa.sizeInfo),
      //             actions: <Widget>[
      //               TextButton(
      //                 child: Text('Back'),
      //                 onPressed: () {
      //                   Navigator.of(context, rootNavigator: true).pop();
      //                 },
      //               )
      //             ],
      //           ));
      // },
    ));
    if (rpa.lat != null && rpa.long != null) {
      _markers.add(Marker(
          markerId: MarkerId(rpa.id),
          position: LatLng(rpa.lat, rpa.long),
          onTap: () {
            showDialog(
                context: context,
                builder: (_) => new PreserveDialog(
                      name: rpa.id,
                      info: rpa.protectionInfo,
                      size: rpa.sizeInfo,
                    ));
          }
          // onTap: () {
          //   showDialog(
          //       context: context,
          //       builder: (_) => new AlertDialog(
          //             title: new Text(rpa.id),
          //             content: new Text(rpa.protectionInfo + '\n' + rpa.sizeInfo),
          //             actions: <Widget>[
          //               TextButton(
          //                 child: Text('Back'),
          //                 onPressed: () {
          //                   Navigator.of(context, rootNavigator: true).pop();
          //                 },
          //               )
          //             ],
          //           ));
          // },
          ));
    }
  }

  static final CameraPosition _startPosition = CameraPosition(
    target: LatLng(59.33879, 18.08487),
    zoom: 10,
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(children: <Widget>[
        GoogleMap(
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
          compassEnabled: false,
          initialCameraPosition: _startPosition,
          mapType: MapType.hybrid,
          markers: Set<Marker>.of(_markers),
          polygons: _polygons,
          cameraTargetBounds: new CameraTargetBounds(
            new LatLngBounds(
              northeast: sthlmNE,
              southwest: sthlmSW,
            ),
          ),
        ),
        Positioned(
          top: 40,
          child: Row(
            children: [
              SizedBox(width: 20),
              Container(
                  width: 54,
                  height: 54,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 3.0,
                          offset: Offset(2.0, 3))
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                  ),
                  child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InformationScreen()));
                      })),
              SizedBox(width: 20),
              Container(
                width: 260,
                height: 54,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 3.0,
                        offset: Offset(2.0, 3))
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                ),
                child: Text('Wildlife Preserves',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 30,
                    )),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
            child: Text('Rules',
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
            onPressed: () {
              showDialog(
                  context: context, builder: (_) => ReserveRulesDialog());
            },
          ),
        ),
      ]),
    );
  }
}

class RPA {
  // ignore: deprecated_member_use
  List<LatLng> polygonLatLngs = List<LatLng>();
  String id;
  LatLng latLng;
  String protectionInfo;
  String sizeInfo;
  LatLng markerSpot;
  double lat;
  double long;

  RPA(this.id, this.protectionInfo, this.sizeInfo, this.lat, this.long,
      this.polygonLatLngs);

  getId() {
    return id;
  }

  getInfo() {
    return protectionInfo;
  }

  getSize() {
    return sizeInfo;
  }

  bool operator ==(o) =>
      o is RPA && o.id == id && o.protectionInfo == protectionInfo;

  @override
  int get hashCode => id.hashCode * protectionInfo.hashCode + 1;
}

// class ReserveRulesScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Rules when in nature'),
//       ),
//       body: Center(
//           child: ListView(
//         children: <Widget>[
//           Text(
//               "Avoid plants and trees. You are not allowed to pick up protected plants; such as orchids." +
//                   "\n",
//               style: TextStyle(fontSize: 20)),
//           Text(
//               "Avoid bird nests and their children. Do not hurt or pick up snakes, reptiles and frogs nor other animals." +
//                   "\n",
//               style: TextStyle(fontSize: 20)),
//           Text(
//               "Avoid bird and seal sanctuaries when access to those areas is prohibited." +
//                   "\n",
//               style: TextStyle(fontSize: 20)),
//           Text(
//               "Your dog needs to be tethered at all time when in nature." +
//                   "\n",
//               style: TextStyle(fontSize: 20)),
//           Text(
//               "Do not start a fire. It is also forbidden to put disposable grills in the garbage due to the fire risk!" +
//                   "\n",
//               style: TextStyle(fontSize: 20)),
//           Text(
//               "In Sweden there is a right, allemansrätten, or in english 'right of public access', that says you are allowed to spend time in nature, even when it belongs to landowners, however, you do need to be responsible and not disturb anyone while doing so. \n",
//               style: TextStyle(fontSize: 20)),
//           RichText(
//             text: new TextSpan(
//               children: [
//                 new TextSpan(
//                   text:
//                       'For more information, please see Naturvårdsverket site.',
//                   style: new TextStyle(color: Colors.blue),
//                   recognizer: new TapGestureRecognizer()
//                     ..onTap = () {
//                       launch(
//                           'https://www.naturvardsverket.se/Var-natur/Allemansratten/Det-har-galler/');
//                     },
//                 ),
//               ],
//             ),
//           ),
//           ElevatedButton(
//             child: Text('Back'),
//             onPressed: () {
//               Navigator.pushReplacement(context,
//                   MaterialPageRoute(builder: (context) => WildlifePreserves()));
//             },
//           ),
//         ],
//       )),
//     );
//   }
// }
