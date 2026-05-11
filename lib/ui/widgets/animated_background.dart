import 'dart:math' as math;

import 'package:flutter/material.dart';

class AnimatedBackground extends StatefulWidget {
  final Widget child;
  const AnimatedBackground({super.key, required this.child});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final secondary = theme.colorScheme.secondary;

    return Stack(
      children: [
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              return CustomPaint(
                painter: _GradientPainter(
                  value: _controller.value,
                  primary: primary,
                  secondary: secondary,
                ),
              );
            },
          ),
        ),
        Positioned.fill(
          child: CustomPaint(
            painter: _SuitPatternPainter(textColor: secondary),
          ),
        ),
        widget.child,
      ],
    );
  }
}

class _GradientPainter extends CustomPainter {
  final double value;
  final Color primary;
  final Color secondary;

  _GradientPainter({
    required this.value,
    required this.primary,
    required this.secondary,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final colors = [
      primary.withValues(alpha: 0.06),
      secondary.withValues(alpha: 0.04),
    ];

    for (int i = 0; i < 3; i++) {
      final phase = i * 2.094;
      final cx = size.width *
          (0.5 + 0.3 * math.sin(value * 2 * math.pi * 0.3 + phase));
      final cy = size.height *
          (0.5 + 0.3 * math.cos(value * 2 * math.pi * 0.2 + phase));
      final radius = size.width * 0.6;

      final shader = RadialGradient(
        colors: [
          colors[i % 2],
          colors[i % 2].withValues(alpha: 0),
        ],
      ).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: radius));

      canvas.drawRect(Offset.zero & size, Paint()..shader = shader);
    }
  }

  @override
  bool shouldRepaint(_GradientPainter oldDelegate) {
    return oldDelegate.value != value;
  }
}

class _SuitPatternPainter extends CustomPainter {
  final Color textColor;

  const _SuitPatternPainter({required this.textColor});

  @override
  void paint(Canvas canvas, Size size) {
    const suits = ['\u2660', '\u2665', '\u2666', '\u2663'];
    const spacing = 80.0;
    final textStyle = TextStyle(
      color: textColor.withValues(alpha: 0.02),
      fontSize: 24,
    );

    for (double y = 0; y < size.height; y += spacing) {
      for (double x = 0; x < size.width; x += spacing) {
        final suit = suits[
            ((x / spacing).floor() + (y / spacing).floor()) % suits.length];
        final tp = TextPainter(
          text: TextSpan(text: suit, style: textStyle),
          textDirection: TextDirection.ltr,
        )..layout();
        tp.paint(canvas, Offset(x, y));
      }
    }
  }

  @override
  bool shouldRepaint(_SuitPatternPainter oldDelegate) => false;
}
