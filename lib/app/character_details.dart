import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'char_data.dart';

class CharacterDetails extends StatelessWidget {
  ///
  Route<dynamic> route() {
    return CupertinoPageRoute(
      builder: (BuildContext context) {
        return CharacterDetails(
          isInTabletLayout: false,
          item: item,
        );
      },
    );
  }

  const CharacterDetails({
    super.key,
    required this.isInTabletLayout,
    required this.item,
  });

  final bool isInTabletLayout;
  final Character item;

  ///
  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  ///

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var orientation = MediaQuery.of(context).orientation;
    var shortSide = MediaQuery.of(context).size.shortestSide;

    String name = item.getCharName();
    String desc = item.getDesc();
    String imgPath = item.getCharacterThumbnail();

    AppBar? appBar = isInTabletLayout == false ? AppBar(title: Text(name)) : null;
    Widget title = isInTabletLayout == true ? titleText(title: name) : const Offstage();

    Color bg = Colors.white;

    var imageHeight = width * 0.57;

    if (orientation == Orientation.landscape) {
      imageHeight = shortSide * 0.5;
    }

    return Scaffold(
        appBar: appBar,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              // decoration: globals.boxDecoration,
              // height: height,
              color: bg,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title,

                  ///
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 18),
                    color: bg,
                    child: Center(
                      child: SizedBox(
                        height: imageHeight,
                        child: FadeInImage.assetNetwork(
                          placeholder: 'lib/place_holder.png',
                          image: imgPath,
                        ),
                      ),
                    ),
                  ),

                  ///
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
                    color: bg,
                    width: double.infinity,
                    child: Text(desc),
                  )

                  ///
                ],
              ),
            ),
          ),
        ));

    ///
  }

  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  ///
  Widget titleText({required String title}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 4, 0, 0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  ///
}
