// import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:appodeal_flutter/appodeal_flutter.dart';
import 'package:flutter/material.dart';
//import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:my_virtual_number/views/country_list_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //MobileAds.instance.initialize();
  // FacebookAudienceNetwork.init();

  // Set the Appodeal app keys
  Appodeal.setAppKeys(
    androidAppKey: 'a8264482445cc35523ea8df744333fc7dcb719161f5254ee',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CountryListView(),
    );
  }
}
