import 'package:flutter/material.dart';
import 'package:serene/global/colors.dart';
import 'package:serene/pages/breathe_page.dart';
import 'package:serene/pages/pomodoro_page.dart';
import 'package:serene/pages/survey_page.dart';
import 'package:serene/widgets/home_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Grouping widgets for better readability (title hero group)
    Widget titleHero = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          "assets/images/fill-logo.png",
          width: 50,
        ),
        const SizedBox(height: 32),
        const Text(
          "Stay\npresent.\nStay Serene.",
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );

    // Grouping widgets for better readability (card group)
    Widget cards = Column(
      children: [
        HomeCard(
          color: AppColors.green,
          title: "Pomodoro Timer",
          subtitle: "Stay focused with 25-minute work and 5-minute breaks.",
          icon: Icons.hourglass_empty_rounded,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PomodoroPage()),
            );
          },
        ),
        HomeCard(
          color: AppColors.blue,
          title: "Breathing Exercise",
          subtitle: "Relax and refocus with guided breathing sessions.",
          icon: Icons.filter_vintage_outlined,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BreatheExercise()),
            );
          },
        ),
        HomeCard(
          color: AppColors.orange,
          title: "Mood Survey",
          subtitle: "Check your mood with a quick, simple survey.",
          icon: Icons.sentiment_very_satisfied_outlined,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MoodSurveyPage()),
            );
          },
        ),
      ],
    );

    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(
                "assets/images/ripple-bg.png",
                height: 340,
              ),
            ),
            const Positioned(
              bottom: 12,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Designed & Built by Hapis',
                  style: TextStyle(color: Color.fromRGBO(0, 0, 0, .5)),
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth < 900) {
                      return Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            titleHero,
                            const SizedBox(height: 24),
                            cards,
                          ],
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(140),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: titleHero),
                            const SizedBox(width: 32),
                            Expanded(child: cards),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
