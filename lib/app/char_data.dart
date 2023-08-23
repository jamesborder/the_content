class CharGenerate {
  ///
  CharGenerate({
    required this.heading,
    required this.characters,
  });

  late final List<Character> characters;
  late final String heading;

  CharGenerate.fromJson(Map<String, dynamic> json) {
    heading = json['Heading'];
    characters = List.from(json['RelatedTopics']).map((e) => Character.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['RelatedTopics'] = characters.map((e) => e.toJson()).toList();
    data['Heading'] = heading;
    return data;
  }

  ///
}

///
/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
///

class Character {
  Character({
    required this.FirstURL,
    required this.icon,
    required this.Result,
    required this.Text,
  });

  late final String FirstURL;
  late final CharIcon icon;
  late final String Result;
  late final String Text;
  late final String name;

  Character.fromJson(Map<String, dynamic> json) {
    FirstURL = json['FirstURL'];
    icon = CharIcon.fromJson(json['Icon']);
    Result = json['Result'];
    Text = json['Text'];
    name = getCharName();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['FirstURL'] = FirstURL;
    data['Icon'] = icon.toJson();
    data['Result'] = Result;
    data['Text'] = Text;
    return data;
  }

  bool nameContains(String input) {

      if (name.toLowerCase().contains(input.toLowerCase())) {
        return true;
      }

      return false;

  }

  String getCharacterThumbnail() {

    if (icon.url.isEmpty) {
      return 'https://icon-library.com/images/image-missing-icon/image-missing-icon-19.jpg';
    }

    return 'http://duckduckgo.com/${icon.url}';

  }

  String getCharName() {
    var parts = Text.split('-');
    return parts.first.trim();
  }

  String getDesc() {
    return Text;
  }
}

///
/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
///

class CharIcon {
  CharIcon({
    required this.height,
    required this.url,
    required this.width,
  });

  late final String height;
  late final String url;
  late final String width;

  CharIcon.fromJson(Map<String, dynamic> json) {
    height = json['Height'];
    url = json['URL'];
    width = json['Width'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Height'] = height;
    data['URL'] = url;
    data['Width'] = width;
    return data;
  }
}
