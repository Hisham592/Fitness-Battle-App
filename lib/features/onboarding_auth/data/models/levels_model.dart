class Level {
  final String title;
  final String description;
  final String imagePath;

  Level({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}

List<Level> levels = [
  Level(
    title: 'Beginner',
    description: '0 - 6 months experience',
    imagePath: 'assets/images/voltIcon.png',
  ),
  Level(
    title: 'Intermediate',
    description: '6 months - 1 year ',
    imagePath: 'assets/images/ireIcon.png',
  ),
  Level(
    title: 'Advanced',
    description: '1+ year serious training',
    imagePath: 'assets/images/skullIcon.png',
  ),
];
