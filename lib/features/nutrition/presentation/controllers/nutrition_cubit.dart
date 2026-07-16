import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/meal.dart';
import '../../domain/usecases/get_smart_meals.dart';


// States
abstract class NutritionState extends Equatable {
  const NutritionState();
  @override
  List<Object> get props => [];
}

class NutritionInitial extends NutritionState {}

class NutritionLoading extends NutritionState {}

class NutritionLoaded extends NutritionState {
  final List<Meal> meals;
  const NutritionLoaded(this.meals);
  @override
  List<Object> get props => [meals];
}

class NutritionError extends NutritionState {
  final String message;
  const NutritionError(this.message);
}

// Cubit
class NutritionCubit extends Cubit<NutritionState> {
  final GetSmartMeals getSmartMealsUseCase;

  NutritionCubit({required this.getSmartMealsUseCase})
    : super(NutritionInitial());

  Future<void> loadSmartNutritionPlan() async {
    emit(NutritionLoading());
    try {
      final meals = await getSmartMealsUseCase();
      emit(NutritionLoaded(meals));
    } catch (e) {
      emit(const NutritionError("Failed to fetch custom nutrition data."));
    }
  }
}
