/**
 * Author: GeHaoRan
 * Date: 2019/11/12 8:12
 * Doc: 照片瀑布流
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:yu_bao/config/urlConfig.dart';
import 'package:yu_bao/page/home/imagePage/seeImage.dart';
import 'package:yu_bao/util/http.dart';

class ImagesView extends StatefulWidget {
  @override
  _ImagesViewState createState() => _ImagesViewState();
}

class _ImagesViewState extends State<ImagesView>
    with AutomaticKeepAliveClientMixin {
  List<String> imageNameList = [];

  Future future;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  Future<void> getImageNameList() async {
    List<dynamic> temp = await DioHttp().post("api/BaseImages/ImageList");
    if (temp.length > 0) {
      temp.forEach((image) {
        if (!image.toString().contains('-v.')) {
          imageNameList.add(image);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: future == null ? future = getImageNameList() : future,
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
            if (imageNameList.length == 0) {
              return Container();
            }
            return StaggeredGridView.countBuilder(
              padding: EdgeInsets.all(8.0),
              crossAxisCount: 4,
              itemCount: imageNameList.length,
              itemBuilder: (context, i) {
                String url = '$imageUrl/${imageNameList[i]}';
                return Material(
                  clipBehavior: Clip.antiAlias,
                  elevation: 8.0,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SeeImage(
                            urlIndex: i,
                            imageNameList: imageNameList,
                          ),
                        ),
                      );
                    },
                    child: Hero(
                      tag: i,
                      child: FadeInImage(
                        image: NetworkImage(url),
                        fit: BoxFit.cover,
                        placeholder: AssetImage("images/loadImage.png"),
                      ),
                    ),
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
