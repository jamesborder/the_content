import 'package:http/http.dart' as http;

class CharacterQueryCommand {

  CharacterQueryCommand();

  Future<dynamic> get({required String dataUrl}) async {

    try {

      var response = await http.get(Uri.parse(dataUrl));

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return '';
      }

    } catch (e) {
      return '';
    }

  }

}