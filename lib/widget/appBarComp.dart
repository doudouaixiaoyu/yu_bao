import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarComp extends StatelessWidget implements PreferredSizeWidget {
  AppBarComp({
    Key key,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.title,
    this.textStyle,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.elevation = 0.0,
    this.shape,
    this.backgroundColor,
    this.brightness,
    this.iconTheme,
    this.actionsIconTheme,
    this.textTheme,
    this.primary = true,
    this.centerTitle,
    this.titleSpacing = NavigationToolbar.kMiddleSpacing,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
  })  : preferredSize = Size.fromHeight(ScreenUtil().setHeight(120.0) +
            (bottom?.preferredSize?.height ?? 0.0)),
        super(key: key);

  final Widget leading;

  final bool automaticallyImplyLeading;

  final String title;

  final TextStyle textStyle;

  final List<Widget> actions;

  final Widget flexibleSpace;

  final PreferredSizeWidget bottom;

  final double elevation;

  final ShapeBorder shape;

  final Color backgroundColor;

  final Brightness brightness;

  final IconThemeData iconTheme;

  final IconThemeData actionsIconTheme;

  final TextTheme textTheme;

  final bool primary;

  final bool centerTitle;

  final double titleSpacing;

  final double toolbarOpacity;

  final double bottomOpacity;

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    final ModalRoute<dynamic> parentRoute = ModalRoute.of(context);
    final bool canPop = parentRoute?.canPop ?? false;
    final bool useCloseButton =
        parentRoute is PageRoute<dynamic> && parentRoute.fullscreenDialog;
    Widget leftIconButton = leading;
    if (leftIconButton == null && automaticallyImplyLeading) {
      if (canPop) {
        if (!useCloseButton) {
          leftIconButton = IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: ScreenUtil().setHeight(43.0),
            ),
          );
        }
      }
    }
    return AppBar(
      leading: leftIconButton,
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: Text(title,
          style: textStyle == null
              ? TextStyle(fontSize: ScreenUtil().setSp(39.0))
              : textStyle),
      actions: actions,
      flexibleSpace: flexibleSpace,
      bottom: bottom,
      elevation: elevation,
      shape: shape,
      backgroundColor: backgroundColor,
      brightness: brightness,
      iconTheme: iconTheme,
      actionsIconTheme: actionsIconTheme,
      textTheme: textTheme,
      primary: primary,
      centerTitle: centerTitle,
      titleSpacing: titleSpacing,
      toolbarOpacity: toolbarOpacity,
      bottomOpacity: bottomOpacity,
    );
  }
}
