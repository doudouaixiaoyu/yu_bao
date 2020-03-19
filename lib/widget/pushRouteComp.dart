import 'package:flutter/cupertino.dart';

enum TransitionType {
  /// 从里像外，从点到面过渡
  Scale,

  /// 渐变过渡
  Fade,

  /// 大小过渡
  Size,

  /// 平滑过渡
  Slide,

  /// 默认过渡
  Nono,
}

class PushRouteComp<T> extends PageRoute<T> {
  PushRouteComp({
    RouteSettings settings,
    @required this.child,
    this.transitionType = TransitionType.Nono,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.opaque = true,
    this.barrierDismissible = false,
    this.barrierColor,
    this.barrierLabel,
    this.maintainState = true,
  })  : assert(barrierDismissible != null),
        assert(maintainState != null),
        assert(opaque != null),
        super(settings: settings);

  /// 要导航到的组件
  final Widget child;

  /// 导航过渡到组件的样式
  final TransitionType transitionType;

  @override
  final Duration transitionDuration;

  @override
  final bool opaque;

  @override
  final bool barrierDismissible;

  @override
  final Color barrierColor;

  @override
  final String barrierLabel;

  @override
  final bool maintainState;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return routeTransition(child);
  }

  Widget routeTransition(Widget child) {
    if (transitionType == TransitionType.Fade) {
      return FadeTransition(
        opacity: Tween(begin: 0.1, end: 1.0).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.linear,
          ),
        ),
        child: child,
      );
    }

    if (transitionType == TransitionType.Size) {
      return SizeTransition(
        sizeFactor: Tween(begin: 0.5, end: 0.6).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutSine,
          ),
        ),
        child: child,
      );
    }

    if (transitionType == TransitionType.Slide) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: Offset(1.0, 0.0),
          end: Offset(0.0, 0.0),
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutQuart,
          ),
        ),
        child: child,
      );
    }

    if (transitionType == TransitionType.Scale) {
      return ScaleTransition(
        scale: Tween(begin: 0.1, end: 1.0).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.linear,
          ),
        ),
        child: child,
      );
    }
    return child;
  }
}
