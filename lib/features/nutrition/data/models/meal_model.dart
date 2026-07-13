import '../../domain/entities/meal.dart';

class MealModel extends Meal {
  const MealModel({
    required super.id,
    required super.title,
    required super.graphic,
    required super.calories,
    required super.priceEgp,
    required super.proteinGrams,
    required super.carbsGrams,
    required super.fatsGrams,
    required super.prepTime,
    required super.instructions,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      graphic: json['graphic'] ?? '🍲',
      calories: json['calories'] ?? 0,
      priceEgp: (json['priceEgp'] as num?)?.toDouble() ?? 0.0,
      proteinGrams: json['proteinGrams'] ?? 0,
      carbsGrams: json['carbsGrams'] ?? 0,
      fatsGrams: json['fatsGrams'] ?? 0,
      prepTime: json['prepTime'] ?? '',
      instructions: (json['instructions'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'graphic': graphic,
      'calories': calories,
      'priceEgp': priceEgp,
      'proteinGrams': proteinGrams,
      'carbsGrams': carbsGrams,
      'fatsGrams': fatsGrams,
      'prepTime': prepTime,
      'instructions': instructions,
    };
  }
}
