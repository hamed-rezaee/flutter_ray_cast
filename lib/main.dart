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
  List<Boundary> _walls;

  @override
  void didChangeDependencies() {
    _walls = _generateBox();

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
                  walls: _walls,
                  // circles: _circles,
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
              onPressed: () => setState(() => _walls = _generateBox()),
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

  List<Boundary> _generateWalls({int size}) {
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
        if (Helper.hasIntersectionLine(
            ray: boundary, line: boundaries[index])) {
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

  List<Boundary> _generateBox() {
    final List<Boundary> boundaries = [];

    Boundary boundary = Boundary(
      start: Offset(
        50.0,
        100.0,
      ),
      end: Offset(
        50.0,
        200.0,
      ),
    );

    Boundary boundary1 = Boundary(
      start: Offset(
        50.0,
        100.0,
      ),
      end: Offset(
        200.0,
        100.0,
      ),
    );

    Boundary boundary2 = Boundary(
      start: Offset(
        200.0,
        100.0,
      ),
      end: Offset(
        200.0,
        200.0,
      ),
    );

    Boundary boundary3 = Boundary(
      start: Offset(
        50.0,
        200.0,
      ),
      end: Offset(
        170.0,
        200.0,
      ),
    );

    boundaries.add(boundary);
    boundaries.add(boundary1);
    boundaries.add(boundary2);
    boundaries.add(boundary3);

    boundary = Boundary(
      start: Offset(
        70.0,
        120.0,
      ),
      end: Offset(
        70.0,
        180.0,
      ),
    );

    boundary1 = Boundary(
      start: Offset(
        70.0,
        120.0,
      ),
      end: Offset(
        180.0,
        120.0,
      ),
    );

    boundary2 = Boundary(
      start: Offset(
        180.0,
        120.0,
      ),
      end: Offset(
        180.0,
        180.0,
      ),
    );

    boundary3 = Boundary(
      start: Offset(
        70.0,
        180.0,
      ),
      end: Offset(
        150.0,
        180.0,
      ),
    );

    boundaries.add(boundary);
    boundaries.add(boundary1);
    boundaries.add(boundary2);
    boundaries.add(boundary3);

    return boundaries;
  }
}
