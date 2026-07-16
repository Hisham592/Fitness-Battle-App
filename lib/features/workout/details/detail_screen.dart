import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voz_app/core/theme/app_colors.dart';
import 'package:voz_app/core/widgets/appbar_title_widget.dart';
import 'package:voz_app/features/workout/data.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class ExerciseDetailScreen extends StatefulWidget {
  const ExerciseDetailScreen({
    super.key,
    required this.exercise,
  });

  final ExerciseData exercise;

  @override
  State<ExerciseDetailScreen> createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const AppBarTitleWidget(title: "EXERCISE DETAILS"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.h),
          child: Container(
            height: 1.h,
            color: Colors.grey.withValues(alpha: 0.3),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _VideoPreview(exercise: widget.exercise),
              SizedBox(height: 20.h),
              Text(
                widget.exercise.name,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                ),
              ),
              SizedBox(height: 14.h),
              Row(
                children: [
                  _Tag('${widget.exercise.sets} SETS'),
                  SizedBox(width: 8.w),
                  _Tag('${widget.exercise.reps} REPS'),
                  SizedBox(width: 8.w),
                  _Tag(widget.exercise.tag),
                ],
              ),
              SizedBox(height: 16.h),
              Text(
                widget.exercise.description,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 22.h),
              Row(
                children: [
                  Expanded(
                    child: _MuscleCard(
                      label: 'PRIMARY MUSCLE',
                      muscle: widget.exercise.primaryMuscle,
                      emoji: '💪',
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _MuscleCard(
                      label: 'SECONDARY',
                      muscle: widget.exercise.secondaryMuscle,
                      emoji: '🦾',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _VideoPreview extends StatefulWidget {
  const _VideoPreview({required this.exercise});

  final ExerciseData exercise;

  @override
  State<_VideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<_VideoPreview> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    final videoId =
        YoutubePlayerController.convertUrlToId(widget.exercise.videoUrl);

    if (videoId == null) {
      throw Exception(
        "Invalid YouTube URL: ${widget.exercise.videoUrl}",
      );
    }

    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        strictRelatedVideos: true,
        enableJavaScript: true,
      ),
    );

    _controller.cueVideoById(videoId: videoId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: YoutubePlayer(controller: _controller),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}

class _Tag extends StatelessWidget {
  const _Tag(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: primaryColor.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(
          color: primaryColor.withValues(alpha: 0.35),
          width: 1.w,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: primaryColor,
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _MuscleCard extends StatelessWidget {
  const _MuscleCard({
    required this.label,
    required this.muscle,
    required this.emoji,
  });

  final String label;
  final String muscle;
  final String emoji;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.border, width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: TextStyle(
              color: primaryColor,
              fontSize: 10.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Text(emoji, style: TextStyle(fontSize: 22.sp)),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  muscle,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}