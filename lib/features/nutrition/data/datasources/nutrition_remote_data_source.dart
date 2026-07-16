import '../models/meal_model.dart';

abstract class NutritionRemoteDataSource {
  Future<List<MealModel>> fetchSmartMeals();
  Future<void> sendMealLoggedStatus(String mealId);
}

class NutritionRemoteDataSourceImpl implements NutritionRemoteDataSource {
  // In production, inject your network client (Dio/Http) here
  NutritionRemoteDataSourceImpl();

  @override
  Future<List<MealModel>> fetchSmartMeals() async {
    // Simulating API latency
    await Future.delayed(const Duration(milliseconds: 800));

    // Returns Mock API Data matching your requirement
    return [
      const MealModel(
        id: '1',
        title: 'Authentic Koshari Bowl',
        graphic: '🍲',
        calories: 580,
        priceEgp: 75.00,
        proteinGrams: 18,
        carbsGrams: 95,
        fatsGrams: 8,
        prepTime: '25 min',
        instructions:
            'Boil lentils, mix with macaroni, and finish with a generous drizzle of spicy sauce for a rich and satisfying bowl.',
      ),
    ];
  }

  @override
  Future<void> sendMealLoggedStatus(String mealId) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
