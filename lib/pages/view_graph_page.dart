import 'dart:async';
import 'dart:math';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
const pal = [0xFFF2387C, 0xFF05C7F2, 0xFF04D9C4, 0xFFF2B705, 0xFFF26241];
class ViewGraphPage extends StatelessWidget {

  final List<DataItem> dataset = [
    DataItem(0.2, "Quantity Sold ", Color(pal[0])),
    DataItem(0.25, "Income", Color(pal[1])),
    DataItem(0.3, "Fish Quantity", Color(pal[2])),
    DataItem(0.05, "Loss", Color(pal[3])),
    DataItem(0.2, "Expenses", Color(pal[4])),
  ];
  Color color = const Color(0xff004BFE);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD2DCFF),
        title: Text('Graph View',
          style: TextStyle(
              fontWeight: FontWeight.bold
          ),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // This will navigate back when the back button is pressed
          },
        ),
      ),
      backgroundColor: Color(0xFFE9EFFF),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: color,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) {

        },
        items: const [
          Icon(
            Icons.home,
            color: Colors.white,
          ),
          Icon(
            Icons.backup_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.bar_chart,
            color: Colors.white,
          ),
        ],
        index: 2, // Set the initial index to 1
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/images/Insights.jpg'), // Replace with your image asset path
                fit: BoxFit.cover,
              ),
            ),
          ),
          // DonutChartWidget positioned on top
          Positioned(
            top: 280, // Position at the top of the screen
            left: 0, // Align with the left edge of the screen
            right: 0, // Align with the right edge of the screen
            child: DonutChartWidget(dataset),
          ),
        ],
      ),
    );
  }
}

class DataItem {
  final double value;
  final String label;
  final Color color;
  DataItem(this.value, this.label, this.color);
}

class DonutChartWidget extends StatefulWidget {
  final List<DataItem> dataset;
  DonutChartWidget(this.dataset);
  @override
  _DonutChartWidgetState createState() => _DonutChartWidgetState();
}

class _DonutChartWidgetState extends State<DonutChartWidget> {

  late Timer timer;
  double fullAngle = 0.0;
  double secondsToComplete = 3.0;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 1000 ~/ 60), (timer) {
      setState(() {
        fullAngle += 360.0 / (secondsToComplete * 1000 ~/ 60);
        if (fullAngle >= 360.0) {
          fullAngle = 360.0;
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: CustomPaint(
          child: Container(),
          painter: DonutChartPainter(widget.dataset, fullAngle),
        ));
  }
}
final linePaint = Paint()
  ..style = PaintingStyle.stroke
  ..color = Colors.white
  ..strokeWidth = 2.0;
final midPaint = Paint()
  ..style = PaintingStyle.fill
  ..color = Colors.white;
const textFieldTextBigStyle = TextStyle(
  color: Colors.blueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 30.0
);
const labelStyle = TextStyle(
  color: Colors.black,
  fontSize: 12.0
);

class DonutChartPainter extends CustomPainter {
  final List<DataItem> dataset;
  final double fullAngle;
  DonutChartPainter(this.dataset, this.fullAngle);


  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2.0, size.height / 2.0);
    final radius = size.width * 0.9;
    final rect = Rect.fromCenter(center: c, width: radius, height: radius);
    // final fullAngle = 360.0;
    var startAngle = 0.0;
    canvas.drawArc(rect, startAngle, fullAngle * pi/180.0, false, linePaint);
    //draw sectors
    dataset.forEach((di) {
      final sweepAngle = di.value * fullAngle * pi / 180.0;
      drawSector(di, fullAngle, canvas, rect, startAngle,sweepAngle);
      // drawLabels(canvas, c, radius, startAngle, sweepAngle, di.label);
      startAngle += sweepAngle;
    });
    dataset.forEach((di) {
      final sweepAngle = di.value * fullAngle * pi / 180.0;
      // drawLabels(canvas, c, radius, startAngle, sweepAngle, di.label);
      drawLines(radius, startAngle, c, canvas);
      startAngle += sweepAngle;
    });
    dataset.forEach((di) {
      final sweepAngle = di.value * fullAngle * pi / 180.0;
      drawLabels(canvas, c, radius, startAngle, sweepAngle, di.label);
      startAngle += sweepAngle;
    });

    // draw the middle
    canvas.drawCircle(c, radius * 0.3, midPaint);

    // draw title
    drawTextCentered(canvas, c, "Fish\nLog\nChart",
        textFieldTextBigStyle, radius * 0.6, (Size sz) {});
  }

  void drawLines(double radius, double startAngle, Offset c, Canvas canvas) {
    final dx = radius /2.0* cos(startAngle);
    final dy = radius /2.0* sin(startAngle);
    final p2 = c + Offset(dx, dy);
    canvas.drawLine(c, p2, linePaint);
  }

  double drawSector(DataItem di, double fullAngle, Canvas canvas, Rect rect, double startAngle, double sweepAngle) {
    final sweepAngle = di.value * fullAngle * pi / 180.0;
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = di.color;
    canvas.drawArc(rect, startAngle, sweepAngle, true, paint);
    return sweepAngle;
  }
  TextPainter measureText(
      String s, TextStyle style, double maxWidth, TextAlign align) {
    final span = TextSpan(text: s, style: style);
    final tp = TextPainter(
        text: span, textAlign: align, textDirection: TextDirection.ltr);
    // ellipsis: "...");
    tp.layout(minWidth: 0, maxWidth: maxWidth);
    return tp;
  }

  void drawLabels(Canvas canvas, Offset c, double radius, double startAngle,
      double sweepAngle, String label) {
    final r = radius * 0.4;
    final dx = r * cos(startAngle + sweepAngle / 2.0);
    final dy = r * sin(startAngle + sweepAngle / 2.0);
    final position = c + Offset(dx, dy);
    drawTextCentered(canvas, position, label, labelStyle, 100.0, (Size sz)
    {
      final rect = Rect.fromCenter(
          center: position, width: sz.width + 5, height: sz.height + 5);
      final rrect = RRect.fromRectAndRadius(rect, Radius.circular(5));
      canvas.drawRRect(rrect, midPaint);
    });
  }

  Size drawTextCentered(Canvas canvas, Offset position, String text,
      TextStyle style, double maxWidth, Function(Size sz) bgCb) {
    final tp = measureText(text, style, maxWidth, TextAlign.center);
    final pos = position + Offset(-tp.width / 2.0, -tp.height / 2.0);
    bgCb(tp.size);
    tp.paint(canvas, pos);
    return tp.size;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>true;
}

