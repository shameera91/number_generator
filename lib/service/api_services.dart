import 'dart:convert';

import 'package:http/http.dart';
import 'package:my_virtual_number/modal/country.dart';

class ApiServices {
  final apiKey = '5d14d6034A25e21bdb1dfcd1AA435414';

  Future getAllCountries() async {
    List<Country> countries = [];
    var _params = {'api_key': apiKey, 'action': 'getCountries'};
    var getCountriesUrl =
        Uri.https('sms-activate.ru', '/stubs/handler_api.php', _params);
    var response = await get(getCountriesUrl);

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);

      // this is how get values from a map and iteraate and deserialize into object list
      countries = map.values.map((e) => Country.fromJson(e)).toList();
      return countries;
    }
  }
}
