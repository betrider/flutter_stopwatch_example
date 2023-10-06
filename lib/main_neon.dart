import 'package:flutter/material.dart';
import 'package:neon_circular_timer/neon_circular_timer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final CountDownController controller = CountDownController();

  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: const Text('neon circular timer'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NeonCircularTimer(
                onComplete: () {
                  controller.restart();
                },
                width: 200,
                controller: controller,
                duration: 20000,
                strokeWidth: 10,
                isTimerTextShown: true,
                textFormat: TextFormat.HH_MM_SS,
                neumorphicEffect: true,
                outerStrokeColor: Colors.grey.shade100,
                innerFillGradient: LinearGradient(colors: [Colors.greenAccent.shade200, Colors.blueAccent.shade400]),
                neonGradient: LinearGradient(colors: [Colors.greenAccent.shade200, Colors.blueAccent.shade400]),
                strokeCap: StrokeCap.round,
                innerFillColor: Colors.black12,
                backgroudColor: Colors.grey.shade100,
                neonColor: Colors.blue.shade900,
              ),
              Padding(
                padding: const EdgeInsets.all(40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.play_arrow),
                      onPressed: () {
                        controller.resume();
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.pause),
                      onPressed: () {
                        controller.pause();
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.repeat),
                      onPressed: () {
                        controller.restart();
                        controller.pause();
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
