import 'dart:async';

import 'package:flutter/material.dart';
import 'package:serene/global/colors.dart';

class BreatheExercise extends StatefulWidget {
  const BreatheExercise({super.key});

  @override
  State<BreatheExercise> createState() => _BreatheExerciseState();
}

class _BreatheExerciseState extends State<BreatheExercise> {
  // Phases of the breathing exercise
  // Each phase has a title, color, and duration in seconds
  final List<_BreathePhase> phases = [
    _BreathePhase(title: "Breathe In...", color: AppColors.blue, duration: 4),
    _BreathePhase(title: "Hold...", color: AppColors.orange, duration: 7),
    _BreathePhase(title: "Exhale...", color: AppColors.green, duration: 8),
  ];

  int phaseIndex = 0;
  int remainingSeconds = 0;
  bool started = false;
  Timer? timer;

  // Function to start the exercise
  void startExercise() {
    setState(() {
      started = true;
      phaseIndex = 0;
      remainingSeconds = phases[0].duration;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (remainingSeconds > 1) {
          remainingSeconds--;
        } else {
          phaseIndex = (phaseIndex + 1) % phases.length;
          remainingSeconds = phases[phaseIndex].duration;
        }
      });
    });
  }

  // Function to stop the exercise
  void stopExercise() {
    timer?.cancel();
    setState(() {
      started = false;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentPhase = phases[phaseIndex];

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(seconds: 1),
        color: currentPhase.color,
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    size: 30,
                    color: AppColors.primary,
                  ),
                  onPressed: () {
                    stopExercise();
                    Navigator.pop(context);
                  },
                ),
              ),
              Center(
                child: started
                    ? Stack(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                currentPhase.title,
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 50,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 20,
                            child: Center(
                              child: Text(
                                "${remainingSeconds}s",
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 40,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.spa_outlined,
                              size: 150, color: AppColors.primary),
                          const Padding(
                            padding: EdgeInsets.all(24),
                            child: Column(
                              children: [
                                Text(
                                  "Breathe in peace, breathe out stress",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.primary,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Let's begin a simple 4-7-8 breathing technique to slow down your thoughts and guide you into a calm, focused state.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(24),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: startExercise,
                                style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  backgroundColor: AppColors.primary,
                                  foregroundColor:
                                      AppColors.blue, // primary blue
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  "Start",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Class to represent each breathing phase
class _BreathePhase {
  final String title;
  final Color color;
  final int duration;

  _BreathePhase(
      {required this.title, required this.color, required this.duration});
}
