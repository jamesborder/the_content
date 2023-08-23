import 'package:flutter/material.dart';
import '/globals.dart' as globals;
import 'char_data.dart';

class CharacterList extends StatefulWidget {
  const CharacterList({
    super.key,
    required this.tappedItemCallBack,
    required this.availableCharacters,
    required this.selectedCharacter,
  });

  final Function tappedItemCallBack;
  final List<Character> availableCharacters;
  final Character selectedCharacter;

  @override
  CharacterListState createState() => CharacterListState();
}

///
/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
///

class CharacterListState extends State<CharacterList> {
  final _textEditingControllerUserInput = TextEditingController();
  late final Function tappedItemCallBack;
  late final List<Character> availableCharacters;
  late Character selectedCharacter;

  List<Character> filteredCharacters = [];

  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  ///
  @override
  initState() {
    ///
    super.initState();

    tappedItemCallBack = widget.tappedItemCallBack;
    availableCharacters = widget.availableCharacters;
    filteredCharacters = availableCharacters;
    selectedCharacter = widget.selectedCharacter;

    ///
  }

  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  ///
  @override
  Widget build(BuildContext context) {
    ///
    List<Character> results = filteredCharacters;
    Widget content = const Offstage();
    Widget characterMeta = const Offstage();
    String searchText = _textEditingControllerUserInput.text.trim();

    if (searchText.isNotEmpty) {
      results = findCharactersWith(_textEditingControllerUserInput.text.trim());
      characterMeta = charactersFound(characterCount: results.length);
      content = characters(results: results);
    } else {
      if (results.isNotEmpty) {
        content = SizedBox(width: double.infinity, child: characters(results: results));
      }
    }

    ///
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///

        screenHeader(),

        Expanded(
          child: content,
        ),

        characterMeta,

        userInput(),

      ],
    );

    ///
  }

  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  ///
  Widget screenHeader() {

    String headerText = 'Characters';

    var orientation = MediaQuery.of(context).orientation;

    if (orientation == Orientation.landscape) {
      return const Offstage();
    }

    return Text(
      headerText,
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  ///
  Widget characters({required List<Character> results}) {
    return ListView(
      children: results.map((character) {
        return ListTile(
          title: Text(character.getCharName()),
          onTap: () => _tappedItemCallBack(character),
          selected: selectedCharacter == character,
          selectedTileColor: Colors.grey[200],
          selectedColor: Colors.black,
        );
      }).toList(),
    );
  }

  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  ///
  Widget charactersFound({required int characterCount}) {
    Color bgColor = characterCount == 0 ? Colors.yellow.shade100 : Colors.white;

    return Container(
      color: bgColor,
      padding: const EdgeInsets.fromLTRB(8, 4, 0, 2),
      margin: const EdgeInsets.fromLTRB(0, 4, 0, 4),
      width: double.infinity,
      child: Text('Characters found : $characterCount'),
    );
  }

  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  ///
  Widget userInput() {
    String hintText = 'Find your favorite character!';
    Widget clear = const Icon(Icons.clear);

    return Container(
      child: TextField(
        controller: _textEditingControllerUserInput,
        onChanged: (value) => {
          onInputChanged(value),
        },
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: IconButton(
            onPressed: clearInput,
            icon: clear,
          ),
        ),
      ),
    );
  }

  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  ///
  clearInput() {
    _textEditingControllerUserInput.clear();
    setState(() {
      filteredCharacters = availableCharacters;
    });
  }

  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  ///
  List<Character> findCharactersWith(String wanted) {
    String iWant = wanted;
    List<Character> results = availableCharacters.where((character) => character.nameContains(iWant)).toList();
    return results;
  }

  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  ///
  onInputChanged(String input) {
    String iWant = input.trim();

    var shortestSide = MediaQuery.of(context).size.shortestSide;

    if (iWant.isNotEmpty) {
      var found = findCharactersWith(iWant);
      int foundCount = found.length;

      if (foundCount == 0) {
        setState(() {
          filteredCharacters = [];
        });

        return;
      }

      setState(() {
        filteredCharacters = found;
      });

      if (shortestSide > globals.kShortSideThreshold) {
        selectedCharacter = filteredCharacters.first;
        tappedItemCallBack(selectedCharacter);
      }
    } else {
      setState(() {
        filteredCharacters = availableCharacters;
      });

      if (shortestSide > globals.kShortSideThreshold) {
        selectedCharacter = filteredCharacters.first;
        tappedItemCallBack(selectedCharacter);
      }
    }

    ///
  }

  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  ///
  _tappedItemCallBack(Character character) {
    selectedCharacter = character;
    tappedItemCallBack(character);
  }

  ///
}
