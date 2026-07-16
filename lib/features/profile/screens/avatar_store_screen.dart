import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../controllers/profile_controller.dart';
import '../models/avatar_model.dart';
import '../widgets/avatar_tile.dart';

class AvatarStoreScreen extends StatefulWidget {
  final ProfileController controller;

  const AvatarStoreScreen({super.key, required this.controller});

  @override
  State<AvatarStoreScreen> createState() => _AvatarStoreScreenState();
}

class _AvatarStoreScreenState extends State<AvatarStoreScreen> {
  void _handleTap(AvatarModel avatar) {
    final result = widget.controller.purchaseOrSelectAvatar(avatar);
    final messenger = ScaffoldMessenger.of(context);
    messenger.clearSnackBars();

    switch (result) {
      case PurchaseResult.purchased:
        messenger.showSnackBar(SnackBar(content: Text('${avatar.name} unlocked!')));
        break;
      case PurchaseResult.insufficientFunds:
        messenger.showSnackBar(
          const SnackBar(content: Text('Not enough points for this avatar.')),
        );
        break;
      case PurchaseResult.selected:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        final points = widget.controller.profile.totalPoints;
        final avatars = widget.controller.avatars;
        final activeId = widget.controller.profile.activeAvatarId;

        return Scaffold(
          appBar: AppBar(title: const Text('AVATAR STORE')),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.bolt, color: AppColors.accent, size: 18),
                          const SizedBox(width: 6),
                          Text(
                            '$points PTS AVAILABLE',
                            style: const TextStyle(
                              color: AppColors.accent,
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      itemCount: avatars.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 14,
                        crossAxisSpacing: 14,
                        childAspectRatio: 0.95,
                      ),
                      itemBuilder: (context, index) {
                        final avatar = avatars[index];
                        return AvatarTile(
                          avatar: avatar,
                          isActive: avatar.id == activeId,
                          onTap: () => _handleTap(avatar),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
