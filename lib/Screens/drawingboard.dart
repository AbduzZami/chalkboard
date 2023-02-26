import 'dart:ui';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:flutter/material.dart';

class DrawingBoard extends StatefulWidget {
  @override
  _DrawingBoardState createState() => _DrawingBoardState();
}

class _DrawingBoardState extends State<DrawingBoard> {
  Color selectedColor = Colors.black;
  double strokeWidth = 5;
  int currentIndex = 0;
  List<List<DrawingPoint?>> drawingPoints = [];
  List<Color> colors = [
    Colors.pink,
    Colors.red,
    Colors.black,
    Colors.yellow,
    Colors.white,
    Colors.purple,
    Colors.green,
  ];
  late InfiniteScrollController controller;
  @override
  void initState() {
    // TODO: implement initState
    controller = InfiniteScrollController();
    drawingPoints.add([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: InfiniteCarousel.builder(
              itemCount: drawingPoints.length,
              itemExtent: MediaQuery.of(context).size.width * 0.8,
              center: true,
              anchor: 0.0,
              velocityFactor: 0.2,
              onIndexChanged: (index) {
                setState(() {
                  currentIndex = index;
                  if (drawingPoints.length <= index) {
                    drawingPoints.add([]);
                  }
                });
              },
              controller: controller,
              axisDirection: Axis.horizontal,
              loop: false,
              itemBuilder: (context, itemIndex, realIndex) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: FittedBox(
                    child: Container(
                      height: 500,
                      width: 1000,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      margin: EdgeInsets.all(20),
                      child: GestureDetector(
                        onPanStart: (details) {
                          setState(() {
                            drawingPoints[currentIndex].add(
                              DrawingPoint(
                                details.localPosition,
                                Paint()
                                  ..color = selectedColor
                                  ..isAntiAlias = true
                                  ..strokeWidth = strokeWidth
                                  ..strokeCap = StrokeCap.round,
                              ),
                            );
                          });
                        },
                        onPanUpdate: (details) {
                          setState(() {
                            drawingPoints[currentIndex].add(
                              DrawingPoint(
                                details.localPosition,
                                Paint()
                                  ..color = selectedColor
                                  ..isAntiAlias = true
                                  ..strokeWidth = strokeWidth
                                  ..strokeCap = StrokeCap.round,
                              ),
                            );
                          });
                        },
                        onPanEnd: (details) {
                          setState(() {
                            drawingPoints[currentIndex].add(null);
                          });
                        },
                        // child: InfiniteCarousel.builder(
                        //   itemCount: 1,
                        //   itemExtent: 120,
                        //   center: true,
                        //   anchor: 0.0,
                        //   velocityFactor: 0.2,
                        //   onIndexChanged: (index) {},
                        //   controller: controller,
                        //   axisDirection: Axis.horizontal,
                        //   loop: true,
                        //   itemBuilder: (context, itemIndex, realIndex) {
                        //     return ClipRect(
                        //         clipBehavior: Clip.hardEdge,
                        //         child: CustomPaint(
                        //           painter: _DrawingPainter(drawingPoints),
                        //         ));
                        //   },
                        // )
                        child: ClipRect(
                            clipBehavior: Clip.hardEdge,
                            child: CustomPaint(
                              painter:
                                  _DrawingPainter(drawingPoints[itemIndex]),
                            )),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 40,
            right: 30,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Center(
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Slider(
                      min: 0,
                      max: 40,
                      value: strokeWidth,
                      onChanged: (val) => setState(() => strokeWidth = val),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                        onPressed: () =>
                            setState(() => drawingPoints[currentIndex] = []),
                        icon: Icon(Icons.clear),
                        label: Text("Clear Board"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                        onPressed: () => controller.previousItem(),
                        icon: Icon(Icons.arrow_back),
                        label: Text("Previous"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                        onPressed: () => controller.nextItem(),
                        icon: Icon(Icons.arrow_forward),
                        label: Text("Next"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            drawingPoints.add([]);
                          });
                          controller.nextItem();
                          currentIndex++;
                        },
                        icon: Icon(Icons.add),
                        label: Text("New"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: selectedColor.withOpacity(0.3),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  colors.length,
                  (index) => _buildColorChose(colors[index]),
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }

  Widget _buildColorChose(Color color) {
    bool isSelected = selectedColor == color;
    return GestureDetector(
      onTap: () => setState(() => selectedColor = color),
      child: Container(
        height: isSelected ? 47 : 40,
        width: isSelected ? 47 : 40,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: isSelected ? Border.all(color: Colors.white, width: 3) : null,
        ),
      ),
    );
  }
}

class _DrawingPainter extends CustomPainter {
  final List<DrawingPoint?> drawingPoints;

  _DrawingPainter(this.drawingPoints);

  List<Offset> offsetsList = [];

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < drawingPoints.length - 1; i++) {
      // print(drawingPoints[i].hashCode);
      if (drawingPoints[i] != null && drawingPoints[i + 1] != null) {
        canvas.drawLine(drawingPoints[i]!.offset, drawingPoints[i + 1]!.offset,
            drawingPoints[i]!.paint);
      } else if (drawingPoints[i] != null && drawingPoints[i + 1] == null) {
        offsetsList.clear();
        offsetsList.add(drawingPoints[i]!.offset);

        canvas.drawPoints(
            PointMode.points, offsetsList, drawingPoints[i]!.paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class DrawingPoint {
  Offset offset;
  Paint paint;

  DrawingPoint(this.offset, this.paint);
}
