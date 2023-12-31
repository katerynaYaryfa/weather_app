import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonThemeProvider extends StatelessWidget {
  const SkeletonThemeProvider({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final gradient = LinearGradient(
      colors: [
        Colors.blue.shade300,
        Colors.grey.shade300,
        Colors.blue.shade300,
      ],
      stops: const [
        0.1,
        0.7,
        0.9,
      ],
    );

    return SkeletonTheme(
      shimmerGradient: gradient,
      darkShimmerGradient: gradient,
      child: child,
    );
  }
}
