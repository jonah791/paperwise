import 'package:flutter/material.dart';

class SlideInTransitionBuilder extends PageTransitionsBuilder {
  const SlideInTransitionBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curve = const Cubic(0.77, 0.0, 0.18, 1.0);
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: curve,
      reverseCurve: curve,
    );

    final Offset begin;
    final Offset end;
    if (route is PageRoute && route.reverse) {
      begin = Offset.zero;
      end = const Offset(-1.0, 0.0);
    } else {
      begin = const Offset(1.0, 0.0);
      end = Offset.zero;
    }

    return SlideTransition(
      position: Tween<Offset>(begin: begin, end: end).animate(curvedAnimation),
      child: child,
    );
  }
}
