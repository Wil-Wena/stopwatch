import 'dart:async';

import 'package:flutter/material.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({super.key});

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  int seconds = 0;
  Timer? timer;
  bool isTicking = true;

  void _onTick(Timer timer) {
    setState(() {
      seconds = (seconds + 1);
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), _onTick);
    setState(() {
      seconds = 0;
      isTicking = true;
    });
  }

  void stopTimer() {
    timer?.cancel();
    setState(() {
      isTicking = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    String secondsText() => seconds == 1 ? 'second' : 'seconds';

    @override
    void dispose() {
      timer?.cancel();
      super.dispose();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Stopwatch"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "$seconds ${secondsText()}",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blueAccent),
                      foregroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: isTicking ? null : startTimer,
                  child: const Text('Start')),
              const SizedBox(width: 30),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      foregroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: isTicking ? stopTimer : null,
                  child: const Text('Stop'))
            ],
          )
        ],
      ),
    );
  }
}
