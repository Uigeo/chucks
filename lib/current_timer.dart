


import 'dart:async';

import 'package:flutter/material.dart';

class CurrentTimer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CurrentTimerState();
}

class _CurrentTimerState extends State<CurrentTimer> {
  Timer _timer;
  DateTime _currentTime;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _timer = Timer.periodic(Duration(seconds: 1), _onTimeChange);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _onTimeChange(Timer timer) {
    setState(() {
      _currentTime = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {

    final hours = _currentTime.hour;
    final minutes = _currentTime.minute;


    final formattedRemaining = '$hours : $minutes';

    return Text(
      formattedRemaining,
      style: TextStyle(color: Colors.white, fontSize: 50.0, fontFamily: 'SairaM',),
    );
  }
}
