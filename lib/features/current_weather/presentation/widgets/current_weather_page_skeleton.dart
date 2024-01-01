import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class CurrentWeatherPageSkeleton extends StatelessWidget {
  const CurrentWeatherPageSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 144),
        SkeletonAvatar(
          style: SkeletonAvatarStyle(
            width: 250,
            height: 29,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 16),
        SkeletonAvatar(
          style: SkeletonAvatarStyle(
            width: 100,
            height: 39,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 16),
        SkeletonAvatar(
          style: SkeletonAvatarStyle(
            width: 150,
            height: 16,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 41),
        SkeletonAvatar(
          style: SkeletonAvatarStyle(
            width: 300,
            height: 300,
            borderRadius: BorderRadius.circular(300),
          ),
        ),
        const SizedBox(height: 52),
        SkeletonAvatar(
          style: SkeletonAvatarStyle(
            width: 175,
            height: 18,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
