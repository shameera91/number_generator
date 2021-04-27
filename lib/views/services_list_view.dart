import 'package:flutter/material.dart';
import 'package:my_virtual_number/screens/icon_content.dart';
import 'package:my_virtual_number/screens/reusable_card.dart';

class ServicesListView extends StatefulWidget {
  ServicesListView({this.countryId});
  final String countryId;
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
                      iconPath: 'assets/telegram.png',
                      text: 'Telegram',
                    ),
                    screen: 'SERVICES_SCREEN',
                    countryId: widget.countryId,
                    serviceCode: 'tg',
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    cardChild: IconContent(
                      iconPath: 'assets/facebook.png',
                      text: 'Facebook',
                    ),
                    screen: 'SERVICES_SCREEN',
                    countryId: widget.countryId,
                    serviceCode: 'fb',
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
                      iconPath: 'assets/paypal.png',
                      text: 'Paypal',
                    ),
                    screen: 'SERVICES_SCREEN',
                    countryId: widget.countryId,
                    serviceCode: 'ts',
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    cardChild: IconContent(
                      iconPath: 'assets/instagram.png',
                      text: 'Instagram',
                    ),
                    screen: 'SERVICES_SCREEN',
                    countryId: widget.countryId,
                    serviceCode: 'ig',
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
                      iconPath: 'assets/tinder.png',
                      text: 'Tinder',
                    ),
                    screen: 'SERVICES_SCREEN',
                    countryId: widget.countryId,
                    serviceCode: 'oi',
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    cardChild: IconContent(
                      iconPath: 'assets/netflix.png',
                      text: 'Netflix',
                    ),
                    screen: 'SERVICES_SCREEN',
                    countryId: widget.countryId,
                    serviceCode: 'nf',
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
                      iconPath: 'assets/discord.png',
                      text: 'Discord',
                    ),
                    screen: 'SERVICES_SCREEN',
                    countryId: widget.countryId,
                    serviceCode: 'ds',
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    cardChild: IconContent(
                      iconPath: 'assets/ebay.png',
                      text: 'Ebay',
                    ),
                    screen: 'SERVICES_SCREEN',
                    countryId: widget.countryId,
                    serviceCode: 'dh',
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
