import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Prince 47 '),
      ),
      body: Clock(),
    ),
  ));
}

class Clock extends StatefulWidget {
  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  @override
  void initState() {
    super.initState();
    // Rafraîchir l'horloge toutes les secondes
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: CustomPaint(
            painter: ClockPainter(),
          ),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    Offset center = Offset(centerX, centerY);

    // Dessiner le cercle de l'horloge
    Paint circlePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;
    canvas.drawCircle(center, centerX - 20, circlePaint);

    // Dessiner les marqueurs horaires
    for (int i = 0; i < 12; i++) {
      double angle = (i * 30) * (math.pi / 180);
      double x1 = centerX + math.cos(angle) * (centerX - 40);
      double y1 = centerY + math.sin(angle) * (centerY - 40);
      double x2 = centerX + math.cos(angle) * (centerX - 20);
      double y2 = centerY + math.sin(angle) * (centerY - 20);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), circlePaint);
    }

    // Obtenir le temps actuel
    DateTime now = DateTime.now();
    int hour = now.hour % 12;
    int minute = now.minute;
    int second = now.second;

    // Dessiner les aiguilles des heures, minutes et secondes
    drawHand(canvas, center, centerX - 80, hour * 30 + (30 / 60) * minute, 10);
    drawHand(canvas, center, centerX - 60, minute * 6 + (6 / 60) * second, 6);
    drawHand(canvas, center, centerX - 40, second * 6, 2);
  }

  void drawHand(Canvas canvas, Offset center, double length, double angle,
      double strokeWidth) {
    double x =
        center.dx + math.cos(-angle * (math.pi / 180) - math.pi / 2) * length;
    double y =
        center.dy + math.sin(-angle * (math.pi / 180) - math.pi / 2) * length;

    Paint handPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawLine(center, Offset(x, y), handPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
