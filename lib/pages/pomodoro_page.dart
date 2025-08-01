import 'dart:async';

import 'package:flutter/material.dart';
import 'package:serene/global/colors.dart';

class PomodoroPage extends StatefulWidget {
  const PomodoroPage({super.key});

  @override
  State<PomodoroPage> createState() => _PomodoroPageState();
}

class _PomodoroPageState extends State<PomodoroPage> {
  /// Set duration rest [restDuration], Set duration work [workDuration]
  static const int workDuration = 25 * 60;
  static const int restDuration = 5 * 60;

  late int remainingTime;
  bool isRunning = false;
  bool isWorkTime = true;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    remainingTime = workDuration;
  }

  // Timer countdown function
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        switchMode();
      }
    });
  }

  // Switch timer mode from work to rest, vice versa
  void switchMode() {
    timer?.cancel();
    setState(() {
      isWorkTime = !isWorkTime;
      remainingTime = isWorkTime ? workDuration : restDuration;
    });
    startTimer();
  }

  // Toggle resume/pause timer
  void toggleTimer() {
    if (isRunning) {
      timer?.cancel();
    } else {
      startTimer();
    }
    setState(() => isRunning = !isRunning);
  }

  // Format time to string
  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = (isWorkTime
            ? remainingTime / workDuration
            : remainingTime / restDuration)
        .clamp(0.0, 1.0);

    // Theme color progress bar
    final themeColor =
        isWorkTime ? const Color(0xFFCDCBC3) : AppColors.greenSub;
    // Background color
    final bgColor = isWorkTime ? AppColors.primary : AppColors.green;
    // Foreground color
    final textColor = isWorkTime ? Colors.black : AppColors.primary;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close, size: 30),
        ),
        foregroundColor: textColor,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  // TODO: sizing based on screen
                  width: 250,
                  height: 250,
                  child: CircularProgressIndicator(
                    value: 1 - progress,
                    strokeWidth: 20,
                    backgroundColor: themeColor,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        isWorkTime ? AppColors.green : AppColors.primary),
                  ),
                ),
                Text(
                  formatTime(remainingTime),
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 48,
            ),
            Icon(
              isWorkTime ? Icons.desktop_mac_outlined : Icons.park_outlined,
              size: 40,
              color: textColor,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              isWorkTime ? 'Work' : 'Rest',
              style: TextStyle(fontSize: 20, color: textColor),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: toggleTimer,
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(16),
                backgroundColor:
                    isWorkTime ? AppColors.green : AppColors.primary,
              ),
              child: Icon(
                isRunning ? Icons.pause : Icons.play_arrow,
                size: 40,
                color: isWorkTime ? AppColors.primary : AppColors.green,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              isRunning ? "Pause" : "Resume",
              style: TextStyle(color: textColor, fontSize: 24),
            )
          ],
        ),
      ),
    );
  }
}
