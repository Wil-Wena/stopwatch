import 'dart:async';

import 'package:flutter/material.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({super.key});

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  int? seconds;
  Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    seconds = 0;
    timer = Timer.periodic(const Duration(seconds: 1), _onTick);
  }

  void _onTick(Timer timer) {
    setState(() {
      seconds = (seconds! + 1);
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
      body: Center(
        child: Text(
          "$seconds ${secondsText()}",
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    );
  }
}
