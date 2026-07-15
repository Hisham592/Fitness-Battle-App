import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voz_app/core/theme/app_colors.dart';
import 'package:voz_app/work%20out/data.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
class ExerciseDetailScreen extends StatefulWidget {
  const ExerciseDetailScreen({
    super.key,
    required this.exercise,
    this.onStartTimer,
  });

  final ExerciseData exercise;
  final VoidCallback? onStartTimer;
  
 
  @override
  State<ExerciseDetailScreen> createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(onBack: () => Navigator.of(context).maybePop()),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _VideoPreview(exercise: widget.exercise),
                    SizedBox(height: 20.h),
                    Text(
                      widget.exercise.name,
                      style:  TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 27.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                        fontFamily: "Rajdhani"
                      ),
                    ),
                     SizedBox(height: 15.h),
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
                        fontFamily: "Barlow"

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
                        const SizedBox(width: 12),
                        Expanded(
                          child: _MuscleCard(
                            label: 'SECONDARY',
                            muscle: widget.exercise.secondaryMuscle,
                            emoji: '🦾',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: _StartTimerButton(
                onPressed: widget.onStartTimer ?? () {},
                colors:  [Colors.pink, AppColors.primaryNeon],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.onBack});
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
           Expanded(
            child: Text(
              'EXERCISE',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
          ),
           SizedBox(width: 48.w), // balances the back button
        ],
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
      params:  YoutubePlayerParams(
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: YoutubePlayer(
          controller: _controller,
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
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.timerback.withOpacity(0.10),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Color(0xff4D0C56 ), width: 1.w)
      ),
      child: Text(
        label,
        style:  TextStyle(
          color: AppColors.primaryNeon,
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
          fontFamily: "Rajdhani"
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
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color:Color(0xff2C2C2C)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: TextStyle(
              color: AppColors.primaryNeon,
              fontSize: 9.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.26,
              
            ),
          ),
           SizedBox(height: 10.h),
          Row(
            children: [
              Text(emoji, style:  TextStyle(fontSize: 22.sp,fontFamily: "Barlow")),
               SizedBox(width: 8.w),
              Flexible(
                child: Text(
                  muscle,
                  style:  TextStyle(
                    color:AppColors.textPrimary,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Rajdhani"
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

class _StartTimerButton extends StatelessWidget {
  const _StartTimerButton({required this.onPressed, required this.colors});
  final VoidCallback onPressed;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
         color: AppColors.primaryNeon,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryNeon.withOpacity(0.6),
              blurRadius: 24,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onPressed,
            child:  Center(
              child: Text(
                'START TIMER  ',
                style: TextStyle(
                  color:Color(0xff000000),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                  fontFamily: "Rajdhani"
                ),
              ),
              
            ),
          ),
        ),
      ),
    );
  }
}
