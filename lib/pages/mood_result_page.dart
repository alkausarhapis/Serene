import 'package:flutter/material.dart';
import 'package:serene/global/colors.dart';

class MoodResultPage extends StatelessWidget {
  final int totalScore;
  const MoodResultPage({super.key, required this.totalScore});

  String get resultMessage {
    if (totalScore <= 4) {
      return "Take a deep breath, write your feelings, then rest well 🤗";
    } else if (totalScore <= 6) {
      return "Start with one small task, then slowly build momentum 🎯";
    } else {
      return " Mood's on fire! Close this app and do something productive🔥";
    }
  }

  @override
  Widget build(BuildContext context) {
    // Store the screen width to adjust size based on device
    double screenWidth = MediaQuery.of(context).size.width;

    final themeColor = totalScore <= 4
        ? AppColors.red
        : totalScore <= 6
            ? AppColors.blue
            : AppColors.green;
    return Scaffold(
      backgroundColor: themeColor,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Mood Score",
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary),
            ),
            const SizedBox(height: 40),
            Center(
              child: Container(
                width: 240,
                height: 240,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      totalScore <= 4
                          ? "Bad"
                          : totalScore <= 6
                              ? "Okay"
                              : "Good",
                      style: TextStyle(
                        fontSize: 75,
                        fontWeight: FontWeight.w500,
                        color: themeColor,
                      ),
                    ),
                    Text(
                      "$totalScore/9",
                      style: TextStyle(
                        fontSize: 28,
                        color: themeColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            Text(
              resultMessage,
              style: const TextStyle(fontSize: 22, color: AppColors.primary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: screenWidth < 600 ? double.infinity : 500,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: screenWidth < 600
                      ? const EdgeInsets.symmetric(vertical: 12)
                      : const EdgeInsets.symmetric(vertical: 20),
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Home",
                  style: TextStyle(
                      fontSize: 20,
                      color: themeColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
