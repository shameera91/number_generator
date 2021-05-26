import 'package:appodeal_flutter/appodeal_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:my_virtual_number/screens/icon_content.dart';
import 'package:my_virtual_number/screens/reusable_card.dart';
import 'package:my_virtual_number/service/admob_service.dart';
import 'package:my_virtual_number/service/api_services.dart';
import 'package:my_virtual_number/service/file_handling_service.dart';
import 'package:my_virtual_number/views/number_list_view.dart';

class CountryListView extends StatefulWidget {
  @override
  _CountryListViewState createState() => _CountryListViewState();
}

class _CountryListViewState extends State<CountryListView> {
  ApiServices apiService = ApiServices();
  BannerAd _bannerAd;
  FileHandlingService fileHandlingService = FileHandlingService();
  bool isAppodealInitialized = false;

  @override
  void initState() {
    super.initState();
    fileHandlingService.readFile();
    Appodeal.setAppKeys(
        androidAppKey: 'fed7fd969ad89e1f20ffb972e88dd3476352df86f25f2711');

    Appodeal.setBannerCallback(
        (event) => print('------- Banner ad triggered the event $event'));
    Appodeal.setInterstitialCallback(
        (event) => print('Interstitial ad triggered the event $event'));
    Appodeal.setRewardCallback(
        (event) => print('Reward ad triggered the event $event'));
    Appodeal.setNonSkippableCallback(
        (event) => print('Non-skippable ad triggered the event $event'));

    // Request authorization to track the user
    Appodeal.requestIOSTrackingAuthorization().then((_) async {
      // Set interstitial ads to be cached manually
      await Appodeal.setAutoCache(AdType.INTERSTITIAL, false);

      // Initialize Appodeal after the authorization was granted or not
      await Appodeal.initialize(
          hasConsent: true,
          adTypes: [
            AdType.BANNER,
            AdType.INTERSTITIAL,
            AdType.REWARD,
            AdType.NON_SKIPPABLE
          ],
          testMode: true);

      setState(() => this.isAppodealInitialized = true);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd?.dispose();
    _bannerAd = null;
  }

  @override
  Widget build(BuildContext context) {
    //_bannerAd = AdMobService.createBannerAd()..load();
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
          ElevatedButton(
            child: Text('Show Banner Ad'),
            onPressed: () async {
              await Appodeal.show(AdType.BANNER,
                  placementName: "placement-name");
            },
          ),
        ],
      ),
      // bottomNavigationBar: Container(
      //   height: 50.0,
      //   child: AdWidget(
      //     key: UniqueKey(),
      //     ad: _bannerAd,
      //   ),
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
