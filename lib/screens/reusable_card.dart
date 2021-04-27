import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_virtual_number/views/get_number_view.dart';
import '../views/services_list_view.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard(
      {@required this.cardChild,
      this.screen,
      this.countryId,
      this.serviceCode});
  final Widget cardChild;
  final String screen;
  final String countryId;
  final String serviceCode;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (screen == 'COUNTRY_SCREEN') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ServicesListView(
                countryId: countryId,
              ),
            ),
          );
        } else if (screen == 'SERVICES_SCREEN') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GetNumberView(
                countryId: countryId,
                serviceCode: serviceCode,
              ),
            ),
          );
        }
      },
      child: Container(
        child: cardChild,
        margin: EdgeInsets.all(15.0),
      ),
    );
  }
}
