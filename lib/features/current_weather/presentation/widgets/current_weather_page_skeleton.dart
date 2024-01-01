import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';
import 'package:weather_app/features/current_weather/provider/current_weather_provider.dart';

class CurrentWeatherPageSkeleton extends StatelessWidget {
  const CurrentWeatherPageSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 50),
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
            width: 200,
            height: 200,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        const SizedBox(height: 41),
        SkeletonAvatar(
          style: SkeletonAvatarStyle(
            width: 175,
            height: 18,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () async {
            context.read<CurrentWeatherProvider>().getCurrentLocation();
          },
          child: Text(
            'Try again',
            style: TextStyle(fontSize: 18, color: Colors.blue.shade50),
          ),
        ),
      ],
    );
  }
}
