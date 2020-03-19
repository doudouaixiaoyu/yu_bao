/**
 * Author: GeHaoRan
 * Date: 2019-09-03 16:45
 * Doc: app 判断页面
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yu_bao/page/userAuth/userLogin.dart';

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 1080.0, height: 2160.0);
    return UserLogin();
  }
}
