import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/features/current_weather/provider/current_weather_provider.dart';

class BackgroundImageContainer extends StatelessWidget {
  const BackgroundImageContainer({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CurrentWeatherProvider>().state;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(state.backgroundImage),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.white.withOpacity(0.8),
            BlendMode.dstATop,
          ),
        ),
      ),
      child: child,
    );
  }
}
