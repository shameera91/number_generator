import 'package:appodeal_flutter/appodeal_flutter.dart';

class AppodealService {
  static void initializeAppodeal() async {
    // Defining the callbacks
    Appodeal.setBannerCallback(
        (event) => print('Banner ad triggered the event $event'));
    Appodeal.setInterstitialCallback(
        (event) => print('Interstitial ad triggered the event $event'));
    Appodeal.setRewardCallback(
        (event) => print('Reward ad triggered the event $event'));
    Appodeal.setNonSkippableCallback(
        (event) => print('Non-skippable ad triggered the event $event'));

    //Appodeal.requestIOSTrackingAuthorization().then((_) async {
    // Set interstitial ads to be cached manually

    //await Appodeal.setAutoCache(AdType.INTERSTITIAL, false);

    // Initialize Appodeal after the authorization was granted or not
    await Appodeal.initialize(
        hasConsent: true,
        adTypes: [
          AdType.BANNER,
          AdType.INTERSTITIAL,
          AdType.REWARD,
          AdType.NON_SKIPPABLE
        ],
        testMode: false);
    //});
  }
}
