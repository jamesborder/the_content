import 'dart:convert';
import 'package:char_viewer_content/char_viewer_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'globals.dart' as globals;

/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
///

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  globals.config = jsonDecode(await rootBundle.loadString('lib/config.json'));
  runApp(const MyApp());
}

///
/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
///

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    String identifier = 'com.sample.simpsonsviewer';

    var globalsConfig = globals.config;

    CharViewerContent charViewerContent = CharViewerContent(
      key: UniqueKey(),
      config: globalsConfig,
      identifier: identifier,
    );

    return MaterialApp(
      title: identifier,
      home: charViewerContent,
    );

    ///
  }

///
}
