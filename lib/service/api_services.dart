import 'dart:convert';

import 'package:http/http.dart';
import 'package:my_virtual_number/modal/country.dart';
import 'package:my_virtual_number/modal/number_response_dto.dart';

//new api to try   https://www.smsapproval.com/api/   check if sacm or not

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

  Future<NumberResponse> orderNumber(
      String serviceCode, String countryCode) async {
    var _params = {
      'api_key': apiKey,
      'service': serviceCode,
      'action': 'getNumber',
      'country': countryCode
    };
    var orderNumberUrl =
        Uri.https('sms-activate.ru', '/stubs/handler_api.php', _params);

    var response = await get(orderNumberUrl);
    if (response.statusCode == 200) {
      print(response.body);

      var resulString = response.body;
      List<String> splittedRespose = resulString.split(':');
      NumberResponse numberResponse =
          NumberResponse(id: splittedRespose[1], number: splittedRespose[2]);
      return numberResponse;
    } else {
      return null;
    }
  }

  Future<String> getSms(String activationId) async {
    var _params = {
      'api_key': apiKey,
      'action': 'getStatus',
      'id': activationId,
    };
    var getSmsUrl =
        Uri.https('sms-activate.ru', '/stubs/handler_api.php', _params);

    var response = await get(getSmsUrl);
    if (response.statusCode == 200) {
      print(response.body);
      String smsResponse = response.body;
      if (smsResponse == 'STATUS_WAIT_CODE') {
        return "Waiting For SMS";
      } else if (smsResponse == 'STATUS_CANCEL') {
        return "Activation Cancelled";
      } else {
        List<String> resultStringList = smsResponse.split(":");
        String status = resultStringList[0];
        if (status == 'STATUS_OK') {
          if (resultStringList[1].isNotEmpty) {
            return resultStringList[1];
          } else {
            return "No SMS Received";
          }
        } else {
          return "No SMS Received";
        }
      }
    }
    return "No SMS Received";
  }
}
