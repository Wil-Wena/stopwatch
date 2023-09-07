import 'dart:async';

import 'package:flutter/material.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({super.key});

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  int milliseconds = 0;
  Timer? timer;
  final laps = [];
  bool isTicking = true;

  void _onTick(Timer timer) {
    setState(() {
      milliseconds = (milliseconds + 100);
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 100), _onTick);
    setState(() {
      milliseconds = 0;
      isTicking = true;
      laps.clear();
    });
  }

  String secondsText(int milliseconds) {
    final seconds = milliseconds / 100;
    return "$seconds seconds";
  }

  void stopTimer() {
    timer?.cancel();
    setState(() {
      isTicking = false;
    });
  }

  //Lap method
  void lap() {
    setState(() {
      laps.add(milliseconds);
      milliseconds = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget buildLapDisplay() {
      return ListView(
        physics: BouncingScrollPhysics(),
        children: [
          for (int milliseconds in laps)
            ListTile(
              title: Text(secondsText(milliseconds)),
            )
        ],
      );
    }

    @override
    void dispose() {
      timer?.cancel();
      super.dispose();
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text("Stopwatch")),
      ),
      body: Column(
        children: [
          Expanded(child: buildCounter(context)),
          Expanded(child: buildLapDisplay())
        ],
      ),
    );
  }

  Container buildCounter(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Lap ${laps.length + 1}",
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: Colors.white),
          ),
          Center(
            child: Text(
              secondsText(milliseconds),
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          _buildControls()
        ],
      ),
    );
  }

  Row _buildControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                foregroundColor: MaterialStateProperty.all(Colors.white)),
            onPressed: isTicking ? null : startTimer,
            child: const Text('Start')),
        const SizedBox(width: 30),
        ElevatedButton(
          onPressed: isTicking ? lap : null,
          child: Text('Lap'),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.yellow)),
        ),
        SizedBox(
          width: 20,
        ),
        TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
                foregroundColor: MaterialStateProperty.all(Colors.white)),
            onPressed: isTicking ? stopTimer : null,
            child: const Text('Stop'))
      ],
    );
  }
}
