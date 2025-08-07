import 'package:flutter/material.dart';
import 'package:serene/global/colors.dart';
import 'package:serene/widgets/mood_card.dart';
import 'mood_result_page.dart';

class MoodSurveyPage extends StatefulWidget {
  const MoodSurveyPage({super.key});

  @override
  State<MoodSurveyPage> createState() => _MoodSurveyPageState();
}

class _MoodSurveyPageState extends State<MoodSurveyPage> {
  final List<String> questions = [
    "How do you feel right now?",
    "How was your sleep tonight?",
    "How's your energy level today?",
  ];

  final List<String> description = [
    "Select the emoji that matches your current mood",
    "Tap how well you slept last night",
    "Choose the option that fits your energy level",
  ];

  /// Default [answers] for each question as null
  /// This will be updated when the user selects an option @[_setAnswer]
  List<int?> answers = [null, null, null];

  void _setAnswer(int questionIndex, int score) {
    setState(() {
      answers[questionIndex] = score;
    });
  }

  // Calculate the total score based on the selected answers
  int get totalScore {
    int sum = 0;
    for (var ans in answers) {
      if (ans != null) sum += ans;
    }
    return sum;
  }

  // Check if all questions have been answered, used to enable/disable the [calculate button]
  bool get allAnswered => !answers.contains(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.orange,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close, size: 30),
        ),
        foregroundColor: AppColors.primary,
        backgroundColor: Colors.transparent,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;

          return SingleChildScrollView(
            child: Padding(
              padding: isMobile
                  ? const EdgeInsets.all(24)
                  : const EdgeInsets.symmetric(horizontal: 120),
              child: Column(
                children: [
                  ...List.generate(questions.length, (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          questions[index],
                          style: TextStyle(
                              fontSize: isMobile ? 24 : 32,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primary),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          description[index],
                          style: TextStyle(
                              fontSize: isMobile ? 14 : 20,
                              color: AppColors.primary),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            MoodCard(
                              label: "Bad",
                              emoji: "😞",
                              scoreValue: 1,
                              selected: answers[index] == 1,
                              onTap: () => _setAnswer(index, 1),
                            ),
                            const SizedBox(width: 8),
                            MoodCard(
                              label: "Okay",
                              emoji: "😐",
                              scoreValue: 2,
                              selected: answers[index] == 2,
                              onTap: () => _setAnswer(index, 2),
                            ),
                            const SizedBox(width: 8),
                            MoodCard(
                              label: "Good",
                              emoji: "🤩",
                              scoreValue: 3,
                              selected: answers[index] == 3,
                              onTap: () => _setAnswer(index, 3),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                      ],
                    );
                  }),
                  const SizedBox(height: 24),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: allAnswered
                            ? () {
                                // Navigate to the result page with the total score
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MoodResultPage(
                                      totalScore: totalScore,
                                    ),
                                  ),
                                );
                              }
                            : null,
                        child: Text("Calulate",
                            style: TextStyle(
                              fontSize: isMobile ? 20 : 24,
                              color: Colors.black,
                            )),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
