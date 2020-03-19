import 'package:flutter/cupertino.dart';
/**
 * 葛浩然 -2019-05-05
 * 对话框
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 自定义弹出通知(Material 风格)
Future<void> demoAlertComp(
    BuildContext context, String title, List<Widget> content,
    {bool isCloseButton = true, List<Widget> action}) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(40.0)),
              child: Text(
                title,
                style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: ScreenUtil().setSp(35.0)),
              ),
            ),
            Positioned(
              right: 5.0,
              child: isCloseButton
                  ? IconButton(
                      alignment: Alignment.topRight,
                      padding:
                          EdgeInsets.only(top: ScreenUtil().setHeight(10.0)),
                      icon: Icon(Icons.remove_circle,
                          color: Theme.of(context).primaryColorDark),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  : SizedBox(),
            ),
          ],
        ),
        titlePadding: EdgeInsets.symmetric(horizontal: 0.0),
        content: SingleChildScrollView(
          child: ListBody(
            children: content,
          ),
        ),
        actions: action,
        contentPadding: EdgeInsets.only(
            bottom: ScreenUtil().setHeight(30.0),
            top: ScreenUtil().setHeight(20.0)),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(
                color: Color(0xFFFFFFFF), style: BorderStyle.solid, width: 2)),
      );
    },
  );
}

/// 自定义弹出通知(ios 风格)
Future<void> iosAlertComp(
    BuildContext context, String title, List<Widget> content,
    {bool isCloseButton = true, List<Widget> action}) async {
  return showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(40.0)),
              child: Text(
                title,
                style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: ScreenUtil().setSp(35.0)),
              ),
            ),
            Positioned(
              right: 5.0,
              child: isCloseButton
                  ? IconButton(
                      alignment: Alignment.topRight,
                      padding:
                          EdgeInsets.only(top: ScreenUtil().setHeight(10.0)),
                      icon: Icon(Icons.remove_circle,
                          color: Theme.of(context).primaryColorDark),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  : SizedBox(),
            ),
          ],
        ),
        titlePadding: EdgeInsets.symmetric(horizontal: 0.0),
        content: SingleChildScrollView(
          child: ListBody(
            children: content,
          ),
        ),
        actions: action,
        contentPadding: EdgeInsets.only(
            bottom: ScreenUtil().setHeight(30.0),
            top: ScreenUtil().setHeight(20.0)),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(
                color: Color(0xFFFFFFFF), style: BorderStyle.solid, width: 2)),
      );
    },
  );
}

/// 弹出等待窗口
Future<void> loadingAlertComp(
    BuildContext context, String loadingText, Color loadingColor,
    {double fontSize = 22.0,
    double width = 230.0,
    double height = 230.0}) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Material(
        type: MaterialType.transparency,
        child: Center(
          child: Container(
            width: ScreenUtil().setHeight(width),
            height: ScreenUtil().setHeight(height),
            decoration: ShapeDecoration(
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                  strokeWidth: 1.8,
                  backgroundColor: loadingColor,
                ),
                Text(
                  loadingText,
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(fontSize),
                    color: Theme.of(context).primaryTextTheme.title.color,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

/// 弹出错误信息窗口
Future<void> errorAlertComp(BuildContext context, String errorMessage,
    {bool isCloseButton = true}) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(40.0)),
              child: Text(
                '抱歉',
                style: TextStyle(color: Theme.of(context).primaryColorDark),
              ),
            ),
            Positioned(
              right: 5.0,
              child: isCloseButton
                  ? IconButton(
                      alignment: Alignment.topRight,
                      padding:
                          EdgeInsets.only(top: ScreenUtil().setHeight(10.0)),
                      icon: Icon(Icons.remove_circle,
                          color: Theme.of(context).primaryColorDark),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  : SizedBox(),
            ),
          ],
        ),
        titlePadding: EdgeInsets.symmetric(horizontal: 0.0),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                child: Text(errorMessage),
              ),
            ],
          ),
        ),
        contentPadding: EdgeInsets.only(
            bottom: ScreenUtil().setHeight(30.0),
            top: ScreenUtil().setHeight(20.0)),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(
                color: Color(0xFFFFFFFF), style: BorderStyle.solid, width: 2)),
      );
    },
  );
}

/// 底部弹出提示
Future<void> showSnackBarComp(
    GlobalKey<ScaffoldState> key,
    BuildContext context,
    String text,
    Color textColor,
    TextAlign textAlign,
    int seconds) async {
  if (key.currentState != null) {
    key.currentState.showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).primaryColor,
        duration: Duration(seconds: seconds),
        content: Text(
          text,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(30.0),
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
          textAlign: textAlign,
        ),
      ),
    );
  }
}
