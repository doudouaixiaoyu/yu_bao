/**
 * Author: GeHaoRan
 * Date: 2019/11/12 8:13
 * Doc:
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yu_bao/config/loginUserConfig.dart';
import 'package:yu_bao/widget/alertComp.dart';
import 'package:yu_bao/widget/pushRouteComp.dart';
import 'package:yu_bao/page/home/home.dart';

class UserLogin extends StatefulWidget {
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  TextEditingController relationText = TextEditingController();

  @override
  void initState() {
    super.initState();
    relationText.text = '妈妈';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(246, 237, 64, 1.0),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(50.0),
            vertical: ScreenUtil().setHeight(50.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: ScreenUtil().setHeight(260.0)),
              Align(
                alignment: Alignment.centerLeft.add(Alignment(0.5, 0)),
                child: Text(
                  '你/您与',
                  style: TextStyle(fontSize: ScreenUtil().setSp(50.0)),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(20.0)),
              Container(
                width: ScreenUtil().setWidth(350.0),
                child: Image.asset("images/Logo.png"),
              ),
              SizedBox(height: ScreenUtil().setHeight(20.0)),
              Align(
                alignment: Alignment.centerRight.add(Alignment(-0.5, 0)),
                child: Text(
                  '的关系',
                  style: TextStyle(fontSize: ScreenUtil().setSp(50.0)),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(100.0)),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(200.0)),
                child: TextField(
                  controller: relationText,
                  decoration: InputDecoration(
                      helperText: "爸爸、妈妈、...",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(10)),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(200.0)),
              Container(
                width: ScreenUtil().setWidth(350.0),
                child: RaisedButton(
                  color: Colors.amberAccent,
                  elevation: 10.0,
                  onPressed: () {
                    if (relationText.text == '') {
                      demoAlertComp(context, '宝宝提示', [
                        Container(
                          width: ScreenUtil().setWidth(500.0),
                          height: ScreenUtil().setHeight(500.0),
                          child: Image.asset(
                            'images/alertImage.jpg',
                          ),
                        ),
                        Container(
                          child: Text(
                            '你/您还没有输入和我的关系呢',
                            style: TextStyle(color: Colors.amber),
                          ),
                          padding: EdgeInsets.only(
                              top: ScreenUtil().setHeight(20.0)),
                          alignment: Alignment.center,
                        ),
                      ]);
                      return;
                    }
                    if (!relationList.contains(relationText.text)) {
                      demoAlertComp(context, '宝宝警告', [
                        Container(
                          width: ScreenUtil().setWidth(500.0),
                          height: ScreenUtil().setHeight(500.0),
                          child: Image.asset(
                            'images/warnImage.jpg',
                          ),
                        ),
                        Container(
                          child: Text(
                            '我们的关系不正确——哼!',
                            style: TextStyle(color: Colors.amber),
                          ),
                          padding: EdgeInsets.only(
                              top: ScreenUtil().setHeight(20.0)),
                          alignment: Alignment.center,
                        ),
                      ]);
                      return;
                    }
                    Navigator.push(
                        context,
                        PushRouteComp(
                            child: Home(),
                            transitionType: TransitionType.Slide));
                  },
                  child: Text('开始'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    relationText.dispose();
    super.dispose();
  }
}
