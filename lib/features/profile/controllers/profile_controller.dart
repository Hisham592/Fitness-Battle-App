import 'package:flutter/foundation.dart';

import '../models/avatar_model.dart';
import '../models/user_profile_model.dart';

enum PurchaseResult { selected, purchased, insufficientFunds }

/// Single source of truth for the Profile / Avatar Store / Settings screens.
///
/// In a real app this would likely be backed by a repository (API, local DB)
/// rather than in-memory seed data, but the purchasing + selection logic
/// (deducting PTS, unlocking, and setting the active avatar) is fully
/// implemented here exactly as the spec describes.
class ProfileController extends ChangeNotifier {
  late UserProfileModel profile;
  late List<AvatarModel> avatars;

  bool pushNotificationsEnabled = true;
  String appTheme = 'Dark Mode';
  final String appVersion = 'v1.0.0 (Build 42)';

  ProfileController() {
    profile = UserProfileModel(
      name: 'Ahmed Mohsen',
      levelLabel: 'Level 1 Beginner',
      memberSinceYear: 2024,
      streakDays: 12,
      totalPoints: 2450,
      workoutsDone: 11,
      levelTier: 'BEGINNER',
      activeAvatarId: 'lion',
    );

    avatars = [
      AvatarModel(id: 'lion', name: 'LION', emoji: '🦁', cost: 0, unlocked: true),
      AvatarModel(id: 'wolf', name: 'WOLF', emoji: '🐺', cost: 800),
      AvatarModel(id: 'eagle', name: 'EAGLE', emoji: '🦅', cost: 600),
      AvatarModel(id: 'dragon', name: 'DRAGON', emoji: '🐉', cost: 1200),
      AvatarModel(id: 'fox', name: 'FOX', emoji: '🦊', cost: 400),
      AvatarModel(id: 'tiger', name: 'TIGER', emoji: '🐯', cost: 1000),
    ];
  }

  AvatarModel get activeAvatar => avatars.firstWhere(
        (a) => a.id == profile.activeAvatarId,
        orElse: () => avatars.first,
      );

  /// If [avatar] is already unlocked -> just sets it as the active avatar.
  /// If it's locked and the user can afford it -> deducts the cost from
  /// the global PTS balance, unlocks it, and makes it active.
  /// If it's locked and unaffordable -> returns insufficientFunds, no change.
  PurchaseResult purchaseOrSelectAvatar(AvatarModel avatar) {
    if (avatar.unlocked) {
      profile.activeAvatarId = avatar.id;
      notifyListeners();
      return PurchaseResult.selected;
    }

    if (profile.totalPoints < avatar.cost) {
      return PurchaseResult.insufficientFunds;
    }

    profile.totalPoints -= avatar.cost;
    avatar.unlocked = true;
    profile.activeAvatarId = avatar.id;
    notifyListeners();
    return PurchaseResult.purchased;
  }

  void togglePushNotifications(bool value) {
    pushNotificationsEnabled = value;
    notifyListeners();
  }

  void setAppTheme(String theme) {
    appTheme = theme;
    notifyListeners();
  }
}
