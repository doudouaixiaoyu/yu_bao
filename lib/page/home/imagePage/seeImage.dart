/**
 * Author: GeHaoRan
 * Date: 2019/11/13 17:00
 * Doc: 照片预览页,左右划切换图片
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yu_bao/config/urlConfig.dart';

class SeeImage extends StatefulWidget {
  SeeImage({Key key, this.urlIndex, this.imageNameList}) : super(key: key);

  final int urlIndex;
  final List<String> imageNameList;

  @override
  _SeeImageState createState() => _SeeImageState();
}

class _SeeImageState extends State<SeeImage> {
  final LinearGradient backgroundGradient = LinearGradient(
      colors: [Colors.yellowAccent, Colors.amber],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);

  int index = 0;

  PageController pageController;

  @override
  void initState() {
    super.initState();
    index = widget.urlIndex;
    pageController = PageController(initialPage: index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(gradient: backgroundGradient),
          child: Stack(
            children: <Widget>[
              PageView.builder(
                controller: pageController,
                itemCount: widget.imageNameList.length,
                itemBuilder: (BuildContext context, int) {
                  return Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Hero(
                      tag: widget.urlIndex,
                      child: Image.network(
                        '$imageUrl/${widget.imageNameList[int]}',
                      ),
                    ),
                  );
                },
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    AppBar(
                      elevation: 0.0,
                      backgroundColor: Colors.transparent,
                      leading: IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
