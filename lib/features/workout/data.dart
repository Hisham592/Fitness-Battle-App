class ExerciseData {
  const ExerciseData({
    required this.name,
    required this.sets,
    required this.reps,
    required this.tag,
    required this.description,
    required this.primaryMuscle,
    required this.secondaryMuscle,
    required this.iconPath,
    required this.videoUrl
  });

  final String name;
  final int sets;
  final int reps;
  final String tag;
  final String description;
  final String primaryMuscle;
  final String secondaryMuscle;
  final String iconPath;
  final String videoUrl;
}