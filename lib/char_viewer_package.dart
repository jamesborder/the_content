library char_viewer_content;

import 'dart:convert';
import 'package:flutter/material.dart';
import 'app/char_data.dart';
import 'app/char_query_command.dart';
import 'app/layout_mobile.dart';
import 'app/layout_tablet.dart';
import 'globals.dart' as globals;

class CharViewerContent extends StatefulWidget {

  const CharViewerContent({
    super.key,
    required this.config,
    required this.identifier,
  });

  final Map config;
  final String identifier;

  @override
  CharViewerContentState createState() => CharViewerContentState();

}

///
/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
///

class CharViewerContentState extends State<CharViewerContent> {

  // static const int shortSideThreshold = 550;

  late Map _config;
  late String _title = '...';
  late String _dataUrl;
  List<Character> _characters = [];

  bool _isLoading = true;

  @override
  void initState() {

    super.initState();

    final String targetData = widget.identifier;
    var globalsConfig = widget.config;
    _config = globalsConfig[targetData];
    _dataUrl = _config['Data_API'];

    requestCharacters(dataUrl: _dataUrl);

  }

  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  ///
  requestCharacters({required String dataUrl}) async {
    CharacterQueryCommand().get(dataUrl: dataUrl).then(
          (response) => {
            processResponse(response),
          },
        );
  }

  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  ///
  @override
  Widget build(BuildContext context) {

    if (_isLoading == true) {
      return _isLoadingWidget();
    }

    if (_characters.isEmpty) {
      return _isEmptyWidget();
    }

    Widget body = Text(_title);

    var shortestSide = MediaQuery.of(context).size.shortestSide;

    if (shortestSide < globals.kShortSideThreshold) {
      body = MobileLayout(
        title: _title,
        characters: _characters,
      );
    } else {
      body = TabletLayout(
        title: _title,
        characters: _characters,
      );
    }

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child:
         Container(
            width: width - 8,
            height: height - 8,
            color: Colors.white,
            child: body,
          ),
        ),
      ),
    );

    ///
  }

  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  ///
  Widget _isLoadingWidget() {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  ///
  Widget _isEmptyWidget() {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () => tapTryAgain(),
          child: const Text('Try again!'),
          // ),
        ),
      ),
    );
  }

  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  ///
  tapTryAgain() {

    setState(() {
      _isLoading = true;
      _title = '...';
    });

    requestCharacters(dataUrl: _dataUrl);

  }

  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  ///
  processResponse(dynamic response) {
    /// If response is empty, then we have no data to display.
    if (response.isEmpty) {
      setState(() {
        _isLoading = false;
        _title = 'Ooops!';
      });
      return;
    }

    final jsonResponse = json.decode(response);
    CharGenerate charGenerated = CharGenerate.fromJson(jsonResponse);
    setState(() {
      _isLoading = false;
      _characters = charGenerated.characters;
      _title = charGenerated.heading;
    });

    ///
  }

  ///
}