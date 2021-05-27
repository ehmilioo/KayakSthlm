import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'RoutesInfo_dialog.dart';
import 'infoInfo_dialog.dart';

class EventsInfoDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EventsInfoOverlayState();
}

class EventsInfoOverlayState extends State<EventsInfoDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(bottom: 85),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          Align(
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: <
                Widget>[
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      minimumSize: Size(74, 31),
                      primary: Colors.black,
                      backgroundColor: Color.fromRGBO(212, 230, 251, 1),
                      shadowColor: Colors.black,
                      elevation: 10,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      textStyle:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                  child: Text('Back'),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(PageRouteBuilder(
                        pageBuilder: (context, _, __) => RoutesInfoDialog(),
                        opaque: false,
                        barrierColor: Colors.black.withOpacity(0.2)));
                  }),
              SizedBox(width: 11),
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      minimumSize: Size(74, 31),
                      primary: Colors.white,
                      backgroundColor: Color.fromRGBO(86, 151, 211, 1),
                      shadowColor: Colors.black,
                      elevation: 10,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      textStyle:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                  child: Text('Next'),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(PageRouteBuilder(
                        pageBuilder: (context, _, __) => InfoInfoDialog(),
                        opaque: false,
                        barrierColor: Colors.black.withOpacity(0.2)));
                  }),
              SizedBox(width: 11)
            ]),
          ),
          Container(
              padding: EdgeInsets.only(bottom: 10, top: 10),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              child: Material(
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.all(15),
                    height: 180,
                    width: 370,
                    alignment: Alignment.topCenter,
                    child: RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Montserrat',
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                            children: <TextSpan>[
                          TextSpan(text: 'This icon represents '),
                          TextSpan(
                              text: 'Events. \n \n',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: 'Here you can '),
                          TextSpan(
                              text: 'find, join, ',
                              style: TextStyle(fontStyle: FontStyle.italic)),
                          TextSpan(text: 'see more '),
                          TextSpan(
                              text: 'information ',
                              style: TextStyle(fontStyle: FontStyle.italic)),
                          TextSpan(text: 'on and '),
                          TextSpan(
                              text: 'create ',
                              style: TextStyle(fontStyle: FontStyle.italic)),
                          TextSpan(text: 'events. \n')
                        ])),
                  ))),
          Container(
            padding: EdgeInsets.only(right: 160),
            child: CustomPaint(
              painter: TrianglePainter(
                  strokeColor: Colors.white,
                  strokeWidth: 10,
                  paintingStyle: PaintingStyle.fill),
              child: Container(height: 43, width: 40),
            ),
          ),
        ]));
  }
}

class Constants {
  Constants._();
  static const double padding = 10;
  static const double avatarRadius = 45;
}

class TrianglePainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;

  TrianglePainter(
      {this.strokeColor = Colors.black,
      this.strokeWidth = 3,
      this.paintingStyle = PaintingStyle.stroke});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
  }

  Path getTrianglePath(double x, double y) {
    return Path()
      ..moveTo(0, 0)
      ..lineTo(x / 2, y)
      ..lineTo(x, 0)
      ..lineTo(0, 0);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
