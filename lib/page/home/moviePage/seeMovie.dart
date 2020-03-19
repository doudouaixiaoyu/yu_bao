/**
 * Author: GeHaoRan
 * Date: 2019/12/25 16:23
 * Doc: 查看视频
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:yu_bao/config/urlConfig.dart';
import 'package:yu_bao/widget/videoPlayerWidget.dart';

class SeeMovie extends StatefulWidget {
  SeeMovie({Key key, this.movieName, this.movieNameList}) : super(key: key);

  final String movieName;
  final List<String> movieNameList;

  @override
  _SeeMovieState createState() => _SeeMovieState();
}

class _SeeMovieState extends State<SeeMovie> {
  int index = 0;
  PageController pageController;

  @override
  void initState() {
    super.initState();
    index = widget.movieNameList.indexOf(widget.movieName);
    pageController = PageController(initialPage: index);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          child: Stack(
            children: <Widget>[
              PageView.builder(
                scrollDirection: Axis.vertical,
                controller: pageController,
                itemCount: widget.movieNameList.length,
                itemBuilder: (BuildContext context, int) {
                  String url =
                      "$movieUrl/${widget.movieNameList[int].replaceAll(".jpeg", ".mp4")}";
                  String image = "$movieUrl/${widget.movieNameList[int]}";
                  return Container(
                    alignment: Alignment.center,
                    child: Hero(
                      tag: widget.movieName,
                      child: NetworkPlayerLifeCycle(
                        url,
                        (BuildContext context,
                                VideoPlayerController controller) =>
                            FullScreenVideo(controller, image),
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
                        iconSize: ScreenUtil().setHeight(100.0),
                        icon: Icon(
                          Icons.chevron_left,
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
}
