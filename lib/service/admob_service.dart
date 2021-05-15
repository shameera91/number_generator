import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:my_virtual_number/constants.dart';

class AdMobService {
  static initialize() {
    if (MobileAds.instance == null) {
      MobileAds.instance.initialize();
    }
  }

  static AdListener _listener = AdListener(
    onAdLoaded: (Ad ad) => print('Ad Loaded'),
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      print('ERRor AD loading');
      ad.dispose();
    },
    onAdOpened: (Ad ad) => {
      Constants.userPoints = (Constants.userPoints + 1),
      print('Ad Opened'),
    },
    onAdClosed: (Ad ad) => print('Ad Closed'),
  );
  //test banner ad
  static BannerAd createBannerAd() {
    final BannerAd ad = BannerAd(
      size: AdSize.smartBanner,
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      request: AdRequest(),
      listener: _listener,
    );
    return ad;
  }

  static InterstitialAd createInterstitialAd() {
    final InterstitialAd ad = InterstitialAd(
      adUnitId:
          'ca-app-pub-3940256099942544/8691691433', // ca-app-pub-3940256099942544/8691691433
      listener: _listener,
      request: AdRequest(),
    );
    return ad;
  }

  // static BannerAd createBannerAd() {
  //   final BannerAd ad = BannerAd(
  //     size: AdSize.smartBanner,
  //     adUnitId: 'ca-app-pub-3940256099942544/6300978111',
  //     request: AdRequest(),
  //     listener: AdListener(
  //       onAdLoaded: (Ad ad) => print('Ad Loaded'),
  //       onAdFailedToLoad: (Ad ad, LoadAdError error) {
  //         print('ERRor AD loading');
  //         ad.dispose();
  //       },
  //       onAdOpened: (Ad ad) => print('Ad Opened'),
  //       onAdClosed: (Ad ad) => print('Ad Closed'),
  //     ),
  //   );
  //   return ad;
  // }

}
