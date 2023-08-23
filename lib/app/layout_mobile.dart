import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../exports.dart';

/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
///

class MobileLayout extends StatefulWidget {

  final String title;
  final List<Character> characters;

  const MobileLayout({super.key, required this.title, required this.characters});

  @override
  MobileLayoutState createState() => MobileLayoutState();

}

///
/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
///

class MobileLayoutState extends State<MobileLayout> {

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.all(4),
      child: CharacterList(
        tappedItemCallBack: itemSelectedCallback,
        availableCharacters: widget.characters,
        selectedCharacter: widget.characters.first,
      ),
    );

    ///
  }

  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  ///
  itemSelectedCallback(Character character) {
    Navigator.push(
        context,
        CharacterDetails(
          isInTabletLayout: false,
          item: character,
        ).route());

    ///
  }

  ///
}
