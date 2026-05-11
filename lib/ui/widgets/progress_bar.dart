import 'package:flutter/material.dart';

class ScrollProgressBar extends StatefulWidget {
  final ScrollController controller;
  const ScrollProgressBar({super.key, required this.controller});

  @override
  State<ScrollProgressBar> createState() => _ScrollProgressBarState();
}

class _ScrollProgressBarState extends State<ScrollProgressBar> {
  double _progress = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onScroll);
  }

  @override
  void didUpdateWidget(ScrollProgressBar old) {
    if (old.controller != widget.controller) {
      old.controller.removeListener(_onScroll);
      widget.controller.addListener(_onScroll);
    }
    super.didUpdateWidget(old);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = widget.controller.position.maxScrollExtent;
    final currentScroll = widget.controller.position.pixels;
    final progress = maxScroll > 0 ? currentScroll / maxScroll : 0.0;
    if ((progress - _progress).abs() > 0.001) {
      setState(() => _progress = progress);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: 3,
      child: FractionallySizedBox(
        widthFactor: _progress,
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).colorScheme.secondary.withValues(alpha: 0.7),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.15),
                blurRadius: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
