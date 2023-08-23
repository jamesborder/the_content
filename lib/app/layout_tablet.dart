import 'package:flutter/material.dart';
import '../exports.dart';

class TabletLayout extends StatefulWidget {
  ///
  final String title;
  final List<Character> characters;

  const TabletLayout({super.key, required this.title, required this.characters});

  @override
  TabletLayoutState createState() => TabletLayoutState();

  ///
}

///
/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
///

class TabletLayoutState extends State<TabletLayout> {
  Character? _selectedCharacter;

  @override
  initState() {
    super.initState();

    if (widget.characters.isNotEmpty) {
      _selectedCharacter = widget.characters.first;
    }
  }

  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  ///
  @override
  Widget build(BuildContext context) {
    ///
    if (widget.characters.isEmpty) {
      return const Center(child: Text('We are loading the characters'));
    }

    Character character;

    if (_selectedCharacter == null) {
      character = widget.characters.first;
    } else {
      character = _selectedCharacter!;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ///
        /// Character List
        Flexible(
          flex: 3,
          child: Container(
            margin: const EdgeInsets.all(4),
            padding: const EdgeInsets.all(2),
            // decoration: boxDecoration,
            child: CharacterList(
              tappedItemCallBack: tapCharacter,
              availableCharacters: widget.characters,
              selectedCharacter: widget.characters.first,
            ),
          ),
          // ),
        ),

        ///
        /// Character Detail
        Flexible(
          flex: 4,
          child: Container(
            margin: const EdgeInsets.all(4),
            padding: const EdgeInsets.all(2),
            color: Colors.white,
            // decoration: boxDecoration,
            child: CharacterDetails(
              isInTabletLayout: true,
              item: character,
            ),
          ),
        ),

        ///
      ],
    );

    ///
  }

  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  ///
  tapCharacter(Character? character) {
    if (character == null) {
      return;
    }

    setState(() {
      _selectedCharacter = character;
    });
  }

  ///
}
