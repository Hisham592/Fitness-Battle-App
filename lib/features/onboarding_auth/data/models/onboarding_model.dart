class OnboardingModel {
  final String subTitle;
  final String title;
  final String description;
  final String imagePath;

  const OnboardingModel({
    required this.subTitle,
    required this.title,
    required this.description,
    required this.imagePath,
  });
}

final List<OnboardingModel> onboardingPages = [
  const OnboardingModel(
    subTitle: 'WELCOME TO VOZ',
    title: 'BUILD YOUR\nBODY.',
    description:
        'Level-up your physique with structured progressive workouts built for real results.',
    imagePath: 'assets/images/onboarding1.png',
  ),
  const OnboardingModel(
    subTitle: 'GAMIFIED TRAINING',
    title: 'EARN XP &\nPROTECT YOUR\nSTREAK.',
    description:
        'Keep the fire alive and reach your ultimate fitness potential.',
    imagePath: 'assets/images/onboarding2.png',
  ),
  const OnboardingModel(
    subTitle: 'FUEL YOUR GAINS',
    title: 'TRACK YOUR\nMEALS &\nBUDGET.',
    description: 'Real local meals, real nutrition.',
    imagePath: 'assets/images/onboarding3.png',
  ),
];
