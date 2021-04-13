import 'package:flutter/material.dart';
import 'package:my_virtual_number/screens/icon_content.dart';
import 'package:my_virtual_number/screens/reusable_card.dart';

class ServicesListView extends StatefulWidget {
  @override
  _ServicesListViewState createState() => _ServicesListViewState();
}

class _ServicesListViewState extends State<ServicesListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Services List'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ReusableCard(
                    cardChild: IconContent(
                      icon: Icons.access_alarm_outlined,
                      text: 'Telegram',
                    ),
                    screen: 'SERVICES_SCREEN',
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    cardChild: IconContent(
                      icon: Icons.access_alarm_outlined,
                      text: 'Facebook',
                    ),
                    screen: 'SERVICES_SCREEN',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ReusableCard(
                    cardChild: IconContent(
                      icon: Icons.access_alarm_outlined,
                      text: 'Paypal',
                    ),
                    screen: 'SERVICES_SCREEN',
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    cardChild: IconContent(
                      icon: Icons.access_alarm_outlined,
                      text: 'Instagram',
                    ),
                    screen: 'SERVICES_SCREEN',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ReusableCard(
                    cardChild: IconContent(
                      icon: Icons.access_alarm_outlined,
                      text: 'Tinder',
                    ),
                    screen: 'SERVICES_SCREEN',
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    cardChild: IconContent(
                      icon: Icons.design_services_outlined,
                      text: 'Netflix',
                    ),
                    screen: 'SERVICES_SCREEN',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ReusableCard(
                    cardChild: IconContent(
                      icon: Icons.accessibility_new_outlined,
                      text: 'Discord',
                    ),
                    screen: 'SERVICES_SCREEN',
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    cardChild: IconContent(
                      icon: Icons.ac_unit,
                      text: 'Ebay',
                    ),
                    screen: 'SERVICES_SCREEN',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
