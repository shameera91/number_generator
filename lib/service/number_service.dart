import 'dart:convert';

import 'package:http/http.dart';
import 'package:my_virtual_number/modal/country_modal.dart';
import 'package:my_virtual_number/modal/number_modal.dart';

class NumberService {
  var freeCountriesUrl = Uri.https('onlinesim.io', '/api/getFreeCountryList');

  Future getNumberlistByCountry(String countryId) async {
    List<NumberModal> numberListModal;
    var _params = {"country": countryId};
    var phoneListByCountry =
        Uri.https('onlinesim.io', '/api/getFreePhoneList', _params);

    var response = await get(phoneListByCountry);
    if (response.statusCode == 200) {
      numberListModal = (json.decode(response.body)['numbers'] as List)
          .map((c) => NumberModal.fromJson(c))
          .toList();
      return numberListModal;
    }
  }

  Future getMessageListByNumber(String phoneNumber) async {
    var _params = {"cpage": "1", "phone": phoneNumber};
    var messageListByCountry =
        Uri.https('onlinesim.io', '/api/getFreeMessageList', _params);
    var response = await get(messageListByCountry);
    print(response.body);
  }

  Future getFreeCountryList() async {
    List<CountryModal> countryListModal;
    var response = await get(freeCountriesUrl);
    print(response.body);
    if (response.statusCode == 200) {
      countryListModal = (json.decode(response.body)['countries'] as List)
          .map((c) => CountryModal.fromJson(c))
          .toList();
      return countryListModal;
    }
  }
}
