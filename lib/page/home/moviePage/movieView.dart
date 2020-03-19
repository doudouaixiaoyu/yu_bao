/**
 * Author: GeHaoRan
 * Date: 2019/11/12 8:12
 * Doc: 视频瀑布流
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:yu_bao/config/urlConfig.dart';
import 'package:yu_bao/page/home/moviePage/seeMovie.dart';
import 'package:yu_bao/util/http.dart';

class MovieView extends StatefulWidget {
  @override
  _MovieViewState createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView>
    with AutomaticKeepAliveClientMixin {
  Future future;

  List<String> movieNameList = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  Future<void> getMovieNameList() async {
    List<dynamic> temp = await DioHttp().post("api/BaseMovies/MovieList");

    if (temp.length > 0) {
      temp.forEach((image) {
        if (!image.toString().contains(".mp4")) {
          movieNameList.add(image);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: future == null ? future = getMovieNameList() : future,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            print('服务未加载');
            return SizedBox();
          case ConnectionState.waiting:
            return Center(
              child: SpinKitRipple(
                color: Theme.of(context).primaryColor,
              ),
            );
          case ConnectionState.active:
            print('正在active');
            return SizedBox();
          default:
            if (snapshot.hasError) {
              print('请求错误');
              return SizedBox();
            }
            if (movieNameList.length == 0) {
              return Container();
            }
            return StaggeredGridView.countBuilder(
              padding: EdgeInsets.all(8.0),
              crossAxisCount: 4,
              itemCount: movieNameList.length,
              itemBuilder: (context, i) {
                String url = '$movieUrl/${movieNameList[i]}';
                return Material(
                  clipBehavior: Clip.antiAlias,
                  elevation: 8.0,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Hero(
                        tag: movieNameList[i],
                        child: FadeInImage(
                          image: NetworkImage(url),
                          fit: BoxFit.cover,
                          placeholder: AssetImage("images/loadImage.png"),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: IconButton(
                          icon: Icon(
                            Icons.play_circle_filled,
                          ),
                          color: Colors.amber,
                          iconSize: ScreenUtil().setHeight(120.0),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SeeMovie(
                                  movieName: movieNameList[i],
                                  movieNameList: movieNameList,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
              staggeredTileBuilder: (i) =>
                  StaggeredTile.count(2, i.isEven ? 2 : 3),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            );
        }
      },
    );
  }
}
