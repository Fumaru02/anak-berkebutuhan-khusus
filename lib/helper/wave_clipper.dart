import 'package:flutter/material.dart';

class WaveClipper extends CustomClipper<Path> {
  final double animValue;
  final double waveHeight;
  final int waveCount;

  const WaveClipper({
    required this.animValue,
    this.waveHeight = 40,
    this.waveCount = 3,
  });

  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - waveHeight);

    final waveWidth = size.width / waveCount;
    final shift = animValue * size.width;

    for (double x = -size.width; x < size.width * 2; x += waveWidth) {
      path.cubicTo(
        x + shift + waveWidth * 0.25,
        size.height - waveHeight * 2,
        x + shift + waveWidth * 0.75,
        size.height,
        x + shift + waveWidth,
        size.height - waveHeight,
      );
    }

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(WaveClipper old) => old.animValue != animValue;
}
