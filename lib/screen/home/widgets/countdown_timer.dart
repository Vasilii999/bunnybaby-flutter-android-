import 'dart:async';

import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../../theme/text_style.dart';

class CountdownTimer extends StatefulWidget {
  final int hours;

  const CountdownTimer({super.key, required this.hours});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Duration _remaining;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _remaining = Duration(hours: widget.hours);
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remaining.inSeconds <= 0) {
        timer.cancel();
      } else {
        setState(() {
          _remaining -= const Duration(seconds: 1);
        });
      }
    });
  }

  String _twoDigits(int n) => n.toString().padLeft(2, '0');

  Widget _timerBox(String value) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          value,
          style: f16w700.copyWith(
            color: dark,
            fontFamily: 'Poppins',
            letterSpacing: 0.5,
            height: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _colon() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        ':',
        style: f16w700.copyWith(
          color: white,
          fontFamily: 'Poppins',
          letterSpacing: 0.5,
          height: 1.5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hours = _twoDigits(_remaining.inHours);
    final minutes = _twoDigits(_remaining.inMinutes.remainder(60));
    final seconds = _twoDigits(_remaining.inSeconds.remainder(60));

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _timerBox(hours),
        _colon(),
        _timerBox(minutes),
        _colon(),
        _timerBox(seconds),
      ],
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}