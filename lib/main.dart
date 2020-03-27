import 'dart:math';
import 'package:flutter/material.dart';

import 'package:flutter_ray_cast/helper.dart';
import 'package:flutter_ray_cast/boundary.dart';
import 'package:flutter_ray_cast/environment_painter.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Offset _position = Offset(0.0, 0.0);
  List<Boundary> boundaries;

  @override
  void didChangeDependencies() {
    boundaries = _generateBoundaries(size: 5);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black,
            child: GestureDetector(
              child: CustomPaint(
                painter: EnvironmentPainter(
                  position: _position,
                  walls: boundaries,
                  maxRayLenght: max(
                    MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height,
                  ),
                ),
              ),
              behavior: HitTestBehavior.opaque,
              onHorizontalDragUpdate: (DragUpdateDetails tapDetail) =>
                  setState(() => _position = tapDetail.localPosition),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: FlatButton(
              onPressed: () =>
                  setState(() => boundaries = _generateBoundaries(size: 5)),
              child: Text(
                'RANDOMIZE',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Boundary> _generateBoundaries({int size}) {
    int counter = 0;
    final List<Boundary> boundaries = [];

    while (counter < size) {
      final int deviceWidth = MediaQuery.of(context).size.width.toInt();
      final int deviceHeight = MediaQuery.of(context).size.height.toInt();

      Boundary boundary = Boundary(
        start: Offset(
          Random().nextInt(deviceWidth).toDouble(),
          Random().nextInt(deviceHeight).toDouble(),
        ),
        end: Offset(
          Random().nextInt(deviceWidth).toDouble(),
          Random().nextInt(deviceHeight).toDouble(),
        ),
      );

      bool hadIntersection = false;

      for (int index = 0; index < boundaries.length; index++) {
        if (Helper.hasIntersection(boundary, boundaries[index])) {
          hadIntersection = true;
          break;
        }
      }

      if (!hadIntersection) {
        boundaries.add(boundary);
        counter++;
      }
    }

    return boundaries;
  }
}
