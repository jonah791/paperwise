import 'package:flutter/material.dart';

class CardSpinner extends StatefulWidget {
  final double size;
  const CardSpinner({super.key, this.size = 80});

  @override
  State<CardSpinner> createState() => _CardSpinnerState();
}

class _CardSpinnerState extends State<CardSpinner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gold = Theme.of(context).colorScheme.secondary;
    final suits = ['\u2660', '\u2665', '\u2666', '\u2663'];

    return SizedBox(
      width: widget.size * 2.5,
      height: widget.size * 0.7,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children: List.generate(8, (i) {
              final delay = i * 0.125;
              final phase = (_controller.value + delay) % 1.0;

              double opacity, translateY, scale;
              if (phase < 0.15) {
                opacity = phase / 0.15;
                translateY = 12 * (1 - phase / 0.15);
                scale = 0.4 + 0.6 * (phase / 0.15);
              } else if (phase < 0.5) {
                opacity = 1.0;
                translateY = 0;
                scale = 1.0;
              } else if (phase < 0.85) {
                opacity = 1.0 - (phase - 0.5) / 0.35;
                translateY = -12 * ((phase - 0.5) / 0.35);
                scale = 1.0 - 0.6 * ((phase - 0.5) / 0.35);
              } else {
                opacity = 0;
                translateY = -12;
                scale = 0.4;
              }

              return Positioned(
                left: i * (widget.size * 0.28),
                top: widget.size * 0.25 + translateY,
                child: Opacity(
                  opacity: opacity.clamp(0.0, 1.0),
                  child: Transform.scale(
                    scale: scale.clamp(0.4, 1.0),
                    child: Text(
                      suits[i % 4],
                      style: TextStyle(
                        fontSize: widget.size * 0.25,
                        color: gold,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
