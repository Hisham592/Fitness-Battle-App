import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Meal extends Equatable {
  final String id;
  final String title;
  final String graphic;
  final int calories;
  final double priceEgp;
  final int proteinGrams;
  final int carbsGrams;
  final int fatsGrams;
  final String prepTime;
  final String instructions;

  final Color containerColor;

  const Meal({
    required this.id,
    required this.title,
    required this.graphic,
    required this.calories,
    required this.priceEgp,
    required this.proteinGrams,
    required this.carbsGrams,
    required this.fatsGrams,
    required this.prepTime,
    required this.instructions,
    this.containerColor = const Color(0xFF111A11),
  });

  @override
  List<Object?> get props => [id, title, calories, priceEgp];
}
