import 'package:flutter/material.dart';
import 'package:my_virtual_number/screens/icon_content.dart';
import 'package:my_virtual_number/screens/reusable_card.dart';
import 'package:my_virtual_number/service/fan_service.dart';

class ServicesListView extends StatefulWidget {
  ServicesListView({this.countryId});
  final String countryId;
  @override
  _ServicesListViewState createState() => _ServicesListViewState();
}

class _ServicesListViewState extends State<ServicesListView> {
  @override
  void initState() {
    showBannerAd();
    super.initState();
  }

  Widget _currentAd = SizedBox(
    width: 0,
    height: 0,
  );

  void showBannerAd() {
    setState(
      () {
        try {
          _currentAd = FANService.showNativeBannerAd();
        } catch (e) {
          print('error occurred while loading banner ad');
        }
      },
    );
  }

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
                      iconPath: 'assets/twittr.jpg',
                      text: 'Twitter',
                    ),
                    screen: 'SERVICES_SCREEN',
                    countryId: widget.countryId,
                    serviceCode: 'tw',
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
                      iconPath: 'assets/watsapp.png',
                      text: 'Whatsapp',
                    ),
                    screen: 'SERVICES_SCREEN',
                    countryId: widget.countryId,
                    serviceCode: 'wa',
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    cardChild: IconContent(
                      iconPath: 'assets/viber.png',
                      text: 'Viber',
                    ),
                    screen: 'SERVICES_SCREEN',
                    countryId: widget.countryId,
                    serviceCode: 'vi',
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
                      iconPath: 'assets/gmail.png',
                      text: 'Gmail',
                    ),
                    screen: 'SERVICES_SCREEN',
                    countryId: widget.countryId,
                    serviceCode: 'go',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 50,
        child: _currentAd,
      ),
    );
  }
}
