// import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:appodeal_flutter/appodeal_flutter.dart';
import 'package:flutter/material.dart';
import 'package:my_virtual_number/screens/icon_content.dart';
import 'package:my_virtual_number/screens/reusable_card.dart';
import 'package:my_virtual_number/service/appodeal_service.dart';
// import 'package:my_virtual_number/service/fan_service.dart';
import 'package:my_virtual_number/service/file_handling_service.dart';
import 'package:my_virtual_number/views/number_list_view.dart';

class CountryListView extends StatefulWidget {
  @override
  _CountryListViewState createState() => _CountryListViewState();
}

class _CountryListViewState extends State<CountryListView> {
  FileHandlingService fileHandlingService = FileHandlingService();
  bool isAppodealInitialized = false;
  @override
  void initState() {
    super.initState();
    loadAppodealConfigs();
  }

  void loadAppodealConfigs() {
    AppodealService.initializeAppodeal();
    setState(() => this.isAppodealInitialized = true);
  }

  // Widget _currentAd = SizedBox(
  //   width: 0,
  //   height: 0,
  // );

  // void showBannerAd() {
  //   setState(
  //     () {
  //       try {
  //         _currentAd = FANService.showNativeBannerAd();
  //       } catch (e) {
  //         print('error occurred while loading banner ad');
  //       }
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Country List'),
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
                      iconPath: 'assets/usa.png',
                      text: 'USA',
                    ),
                    screen: 'COUNTRY_SCREEN',
                    countryId: '12',
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    cardChild: IconContent(
                      iconPath: 'assets/england.jpg',
                      text: 'England',
                    ),
                    screen: 'COUNTRY_SCREEN',
                    countryId: '16',
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
                      iconPath: 'assets/indonesia.png',
                      text: 'Indonesia',
                    ),
                    screen: 'COUNTRY_SCREEN',
                    countryId: '6',
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    cardChild: IconContent(
                      iconPath: 'assets/germany.png',
                      text: 'Germany',
                    ),
                    screen: 'COUNTRY_SCREEN',
                    countryId: '43',
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
                      iconPath: 'assets/philippines.png',
                      text: 'Philippines',
                    ),
                    screen: 'COUNTRY_SCREEN',
                    countryId: '4',
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    cardChild: IconContent(
                      iconPath: 'assets/malaysia.png',
                      text: 'Malaysia',
                    ),
                    screen: 'COUNTRY_SCREEN',
                    countryId: '7',
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
                      iconPath: 'assets/france.png',
                      text: 'France',
                    ),
                    screen: 'COUNTRY_SCREEN',
                    countryId: '78',
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    cardChild: IconContent(
                      iconPath: 'assets/canada.png',
                      text: 'Canada',
                    ),
                    screen: 'COUNTRY_SCREEN',
                    countryId: '36',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        child: AppodealBanner(),
      ),
      // bottomNavigationBar: Container(
      //   height: 50,
      //   child: _currentAd,
      // ),
    );
  }

  Widget listViewItem(String countryName, int countryId) {
    return Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      alignment: Alignment.center,
      child: Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NumberListView(countryId),
              ),
            );
          },
          child: Text(
            countryName,
            style: TextStyle(fontSize: 25.0),
          ),
        ),
      ),
    );
  }
}
