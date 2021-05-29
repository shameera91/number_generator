import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:my_virtual_number/screens/icon_content.dart';
import 'package:my_virtual_number/screens/reusable_card.dart';

class ServicesListView extends StatefulWidget {
  ServicesListView({this.countryId});
  final String countryId;
  @override
  _ServicesListViewState createState() => _ServicesListViewState();
}

class _ServicesListViewState extends State<ServicesListView> {
  BannerAd _anchoredBanner;
  bool _loadingAnchoredBanner = false;

  @override
  void initState() {
    super.initState();
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
  Widget build(BuildContext context) {
    if (!_loadingAnchoredBanner) {
      _loadingAnchoredBanner = true;
      _createdAnchoredBanner(context);
    }
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
}
