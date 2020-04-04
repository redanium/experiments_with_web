import 'package:experiments_with_web/app_level/assets/assets.dart';
import 'package:experiments_with_web/app_level/utilities/screen_size.dart';
import 'package:experiments_with_web/app_level/widgets/desktop/custom_scaffold.dart';
import 'package:experiments_with_web/parallax/widgets/info_row.dart';

import 'package:flutter/material.dart';

class ParallaxScreen extends StatefulWidget {
  const ParallaxScreen({Key key}) : super(key: key);

  static final _screenQueries = ScreenQueries.instance;

  @override
  _ParallaxScreenState createState() => _ParallaxScreenState();
}

class _ParallaxScreenState extends State<ParallaxScreen> {
  ScrollController _scrollController;

  double get _imgHeight => ParallaxScreen._screenQueries.height(context);
  double get _imageWidth => ParallaxScreen._screenQueries.width(context);

  double _currOffset = 0.0;

  void get _refresh => setState(() {});

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
    // _scrollController = ScrollController()..addListener(_scrollEventListener);
  }

  @override
  Widget build(BuildContext context) {
    //

    return CustomScaffold(
      showAppBar: false,
      child: NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -0.25 * _currOffset, // -ve as we want to scroll upwards
              child: Image.asset(
                WebAssets.socialDistance.assetName,
                fit: BoxFit.fitWidth,
                width: _imageWidth,
                height: _imgHeight,
              ),
            ),
            // Positioned(
            //   top: _imgHeight * 0.8 - 1 * _currOffset,
            //   left: 0,
            //   right: 0,
            //   height: _imgHeight * 0.2,
            //   child: Container(
            //     width: double.infinity,
            //     decoration: BoxDecoration(
            //       gradient: LinearGradient(
            //         begin: Alignment.topCenter,
            //         end: Alignment.bottomCenter,
            //         stops: [0, 1],
            //         colors: [Colors.black.withOpacity(0), Colors.black],
            //       ),
            //     ),
            //   ),
            // ),
            ListView(
              cacheExtent: 100.0,
              addAutomaticKeepAlives: false,
              controller: _scrollController,
              children: <Widget>[
                SizedBox(height: _imgHeight), // IMP STEP 1..
                InfoRow(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  // void _scrollEventListener() {
  //   setState(() {
  //     if (_scrollController.hasClients) {
  //       _currOffset = _scrollController.offset;
  //     }
  //   });
  //   print('CURR OFFSET >>>> $_currOffset');
  //   // print('${_scrollController.hasClients}');
  //   // print('${_scrollController.position.maxScrollExtent}');
  //   // print('${_scrollController.position.outOfRange}');
  // }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      // print('>>>>>Scroll ${notification.scrollDelta}');
      _currOffset = notification.metrics.pixels;
    }

    _refresh;
    return false;
  }
}
