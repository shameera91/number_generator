import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:my_virtual_number/constants.dart';
import 'package:my_virtual_number/modal/number_response_dto.dart';
import 'package:my_virtual_number/service/admob_service.dart';
import 'package:my_virtual_number/service/api_services.dart';
import 'package:path_provider/path_provider.dart';

class GetNumberView extends StatefulWidget {
  GetNumberView({this.countryId, this.serviceCode});
  final String countryId;
  final String serviceCode;
  @override
  _GetNumberViewState createState() => _GetNumberViewState();
}

class _GetNumberViewState extends State<GetNumberView> {
  ApiServices apiServices = ApiServices();
  NumberResponse numberResponse;
  String smsText;
  bool getNumberButtonPressed = false;
  bool smsReceived = false;
  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;
  @override
  void initState() {
    super.initState();
    print('inital user score' + Constants.userPoints.toString());

    //assume order number success and update credits
    updateUserCredits();
    writeToFile(Constants.userPoints);
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd?.dispose();
    _bannerAd = null;
  }

  Future<int> getValueFormFileOrUseDefault() async {
    return await readFile();
  }

  //check this logic agaiin
  void updateUserCredits() {
    //userScore = userScore - 6;
    Constants.userPoints = Constants.userPoints - 3;
  }

  void writeToFile(int userScore) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/test_file.txt');
    await file.writeAsString('$userScore');
  }

  Future<int> readFile() async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/test_file.txt');
      String text = await file.readAsString();
      print('text file availbe text  ---------' + text);
      Constants.userPoints = int.parse(text);
      return int.parse(text);
    } catch (e) {
      print('Couldn\'t read file');
      return Constants.userPoints;
    }
  }

  bool checkUserPointEligibility() {
    if (Constants.userPoints >= 10) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    _bannerAd = AdMobService.createBannerAd()..load();
    _interstitialAd = AdMobService.createInterstitialAd()..load();

    String viewAdInfoMessage =
        'You need atleast 10 points to order another number.View few ads and earn points';
    String confirmMsgString = 'Get ' +
        Constants.countryNames[widget.countryId] +
        ' number for ' +
        Constants.servicesNames[widget.serviceCode];
    String userPointsMessage =
        'Currently Available Points ' + Constants.userPoints.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Number'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20.0, right: 10.0, left: 15.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  userPointsMessage,
                  style: TextStyle(fontSize: 17.0),
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              children: [
                Text(
                  confirmMsgString,
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'This number is valid only for 20 minutes from the acivation ',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                  ),
                  onPressed: (checkUserPointEligibility() &&
                          !(getNumberButtonPressed))
                      ? () async {
                          apiServices
                              .orderNumber(widget.serviceCode, widget.countryId)
                              .then((value) => setState(() {
                                    numberResponse = value;
                                    getNumberButtonPressed = true;
                                    updateUserCredits();
                                  }));
                        }
                      : null,
                  child: Text(
                    'Get Number',
                    style: TextStyle(fontSize: 25.0),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  numberResponse != null ? numberResponse.number : '',
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
            SizedBox(
              height: 25.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // create a method for this boolen  'getNumberButtonPressed', add userPoint logic there
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                  ),
                  onPressed: getNumberButtonPressed
                      ? () async {
                          smsText = await apiServices.getSms(numberResponse.id);
                          setState(() {
                            // get sms detail api call
                            if (smsText != null &&
                                smsText != 'No SMS Received') {
                              //smsReceived = true;
                            }
                            // implement another button for change status and get another sms
                            //apiServices.getSms('437259483');
                          });
                        }
                      : null,
                  child: Text(
                    'Show SMS',
                    style: TextStyle(fontSize: 25.0),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  smsText != null ? smsText : '',
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    viewAdInfoMessage,
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                !checkUserPointEligibility()
                    ? ElevatedButton(
                        onPressed: () {
                          _interstitialAd.show();
                          setState(() {
                            //Constants.userPoints = Constants.userPoints + 2;
                            writeToFile(Constants.userPoints);
                          });
                        },
                        child: !checkUserPointEligibility()
                            ? Text(
                                'Show Ad',
                                style: TextStyle(fontSize: 25.0),
                              )
                            : null,
                      )
                    : Container(),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50.0,
        child: AdWidget(
          key: UniqueKey(),
          ad: _bannerAd,
        ),
      ),
    );
  }
}
