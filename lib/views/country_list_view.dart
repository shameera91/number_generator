import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:my_virtual_number/screens/icon_content.dart';
import 'package:my_virtual_number/screens/reusable_card.dart';
import 'package:my_virtual_number/service/api_services.dart';
import 'package:my_virtual_number/service/file_handling_service.dart';
import 'package:my_virtual_number/views/number_list_view.dart';

class CountryListView extends StatefulWidget {
  @override
  _CountryListViewState createState() => _CountryListViewState();
}

class _CountryListViewState extends State<CountryListView> {
  ApiServices apiService = ApiServices();
  BannerAd _anchoredBanner;
  bool _loadingAnchoredBanner = false;
  FileHandlingService fileHandlingService = FileHandlingService();

  @override
  void initState() {
    super.initState();
    fileHandlingService.readFile();
  }

  Future<void> _createdAnchoredBanner(BuildContext context) async {
    final AnchoredAdaptiveBannerAdSize size =
        await AdSize.getAnchoredAdaptiveBannerAdSize(
      Orientation.portrait,
      MediaQuery.of(context).size.width.truncate(),
    );

    if (size == null) {
      print('Unable to get height of anchored banner.');
      return;
    }

    final BannerAd banner = BannerAd(
      size: size,
      adUnitId: 'ca-app-pub-3246132399617809/1200353023',
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$BannerAd loaded.');
          setState(() {
            _anchoredBanner = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$BannerAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
      ),
    );
    return banner.load();
  }

  @override
  void dispose() {
    super.dispose();
    //_bannerAd?.dispose();
    //_bannerAd = null;
  }

  @override
  Widget build(BuildContext context) {
    //_bannerAd = AdMobService.createBannerAd()..load();
    if (!_loadingAnchoredBanner) {
      _loadingAnchoredBanner = true;
      _createdAnchoredBanner(context);
    }
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
      bottomNavigationBar: (_anchoredBanner != null)
          ? Container(
              width: _anchoredBanner.size.width.toDouble(),
              height: _anchoredBanner.size.height.toDouble(),
              child: AdWidget(
                ad: _anchoredBanner,
              ),
            )
          : Container(),
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
