import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../models/avatar_model.dart';

/// A single tile in the Avatar Store grid.
///
/// - Locked avatars are dimmed with a lock icon + PTS cost.
/// - Unlocked avatars show an "OWNED" pill.
/// - The currently active/equipped avatar gets the neon glow border.
class AvatarTile extends StatelessWidget {
  final AvatarModel avatar;
  final bool isActive;
  final VoidCallback onTap;

  const AvatarTile({
    super.key,
    required this.avatar,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final highlighted = isActive;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: highlighted ? AppColors.accent : AppColors.surfaceBorder,
            width: highlighted ? 1.5 : 1,
          ),
          boxShadow: highlighted
              ? [
                  BoxShadow(
                    color: AppColors.accent.withOpacity(0.45),
                    blurRadius: 20,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Opacity(
              opacity: avatar.unlocked ? 1 : 0.35,
              child: Text(avatar.emoji, style: const TextStyle(fontSize: 34)),
            ),
            const SizedBox(height: 10),
            Text(
              avatar.name,
              style: TextStyle(
                color: avatar.unlocked
                    ? (highlighted ? AppColors.accent : AppColors.textPrimary)
                    : AppColors.lockedGrey,
                fontWeight: FontWeight.w700,
                fontSize: 13,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 8),
            if (avatar.unlocked)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'OWNED',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              )
            else ...[
              const Icon(Icons.lock, size: 16, color: AppColors.lockedGrey),
              const SizedBox(height: 6),
              Text(
                '${avatar.cost} PTS',
                style: const TextStyle(
                  color: AppColors.lockedGrey,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
