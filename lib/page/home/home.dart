/**
 * Author: GeHaoRan
 * Date: 2019/11/18 15:57
 * Doc:
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yu_bao/widget/appBarComp.dart';
import 'package:yu_bao/page/home/imagePage/imagesView.dart';
import 'package:yu_bao/page/home/moviePage/movieView.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController tabController;
  List<Tab> tabs = <Tab>[];

  @override
  void initState() {
    super.initState();
    tabs = [
      Tab(
        text: '照片',
        icon: Icon(Icons.photo),
      ),
      Tab(
        text: '视频',
        icon: Icon(Icons.movie),
      ),
    ];
    tabController =
        TabController(initialIndex: 0, length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComp(
        title: '雨·宝',
        textStyle: TextStyle(
          fontSize: ScreenUtil().setSp(39.0),
          letterSpacing: 8.0,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        bottom: TabBar(
          tabs: tabs,
          controller: tabController,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: 2.0,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          ImagesView(),
          MovieView(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
