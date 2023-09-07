import 'dart:async';

import 'package:flutter/material.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({super.key});

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  late int seconds;
  Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    seconds = 0;
    timer = Timer.periodic(Duration(seconds: 1), _onTick);
  }

  void _onTick(Timer timer) {
    setState(() {
      ++seconds;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stopwatch"),
      ),
      body: Center(
        child: Text(
          "0 seconds",
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    );
  }
}
