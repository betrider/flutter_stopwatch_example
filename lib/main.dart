import 'dart:math';

import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late final CustomTimerController _controller = CustomTimerController(
    vsync: this,
    begin: const Duration(seconds: 1),
    end: const Duration(seconds: 5),
    initialState: CustomTimerState.reset,
    interval: CustomTimerInterval.milliseconds,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("CustomTimer example"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomTimer(
                controller: _controller,
                builder: (state, remaining) {
                  return Column(
                    children: [
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: CustomPaint(
                          painter: CustomCirclePainter(
                            value: remaining.duration.inMilliseconds,
                            minValue: _controller.begin.inMilliseconds,
                            maxValue: _controller.end.inMilliseconds
                          ),
                          child: Center(
                            child: Text(
                              "${remaining.hours}:${remaining.minutes}:${remaining.seconds}.${remaining.milliseconds}",
                              style: const TextStyle(fontSize: 24.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RoundedButton(
                  text: "Start",
                  color: Colors.green,
                  onPressed: () => _controller.start(),
                ),
                RoundedButton(
                  text: "Pause",
                  color: Colors.blue,
                  onPressed: () => _controller.pause(),
                ),
                RoundedButton(
                  text: "Reset",
                  color: Colors.red,
                  onPressed: () => _controller.reset(),
                )
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RoundedButton(
                  text: "Set Begin to 5s",
                  color: Colors.purple,
                  onPressed: () => _controller.begin = const Duration(seconds: 5),
                ),
                RoundedButton(
                  text: "Set End to 5s",
                  color: Colors.purple,
                  onPressed: () => _controller.end = const Duration(seconds: 5),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RoundedButton(
                  text: "Jump to 5s",
                  color: Colors.indigo,
                  onPressed: () => _controller.jumpTo(const Duration(seconds: 5)),
                ),
                RoundedButton(
                  text: "Finish",
                  color: Colors.orange,
                  onPressed: () => _controller.finish(),
                )
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RoundedButton(
                  text: "Add 5s",
                  color: Colors.teal,
                  onPressed: () => _controller.add(const Duration(seconds: 5)),
                ),
                RoundedButton(
                  text: "Subtract 5s",
                  color: Colors.teal,
                  onPressed: () => _controller.subtract(const Duration(seconds: 5)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  final String text;
  final Color color;
  final void Function()? onPressed;

  const RoundedButton({super.key, required this.text, required this.color, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      ),
      onPressed: onPressed,
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}

class CustomCirclePainter extends CustomPainter {
  final int value;
  final int minValue;
  final int maxValue;

  CustomCirclePainter({
    required this.value,
    required this.minValue,
    required this.maxValue,
  });
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue // 원의 바깥 부분 색상
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2 - 4, paint);

    Paint highlightPaint = Paint()
      ..color = Colors.red // 일부 부분의 색상
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    double newMinValue = -0.5; // 목표 범위의 최소값
    double newMaxValue = 1.5; // 목표 범위의 최대값

    // -0.5 ~ 1.5값에 맞게 변환
    double transformedValue = ((value - minValue) / (maxValue - minValue)) * (newMaxValue - newMinValue) + newMinValue;

    double startAngle = -0.5 * pi; // 시작 각도를 0도로 설정
    double endAngle = transformedValue * pi; // 끝 각도 (90도)

    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.width / 2 - 4),
      startAngle,
      endAngle - startAngle,
      false,
      highlightPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
