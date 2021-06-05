import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:my_virtual_number/constants.dart';
import 'package:my_virtual_number/modal/number_response_dto.dart';
import 'package:my_virtual_number/service/api_services.dart';
import 'package:my_virtual_number/service/fan_service.dart';
import 'package:my_virtual_number/service/file_handling_service.dart';

const int maxFailedLoadAttempts = 3;

class GetNumberView extends StatefulWidget {
  GetNumberView({this.countryId, this.serviceCode});
  final String countryId;
  final String serviceCode;
  @override
  _GetNumberViewState createState() => _GetNumberViewState();
}

//Timer _timerForInter;

class _GetNumberViewState extends State<GetNumberView> {
  FileHandlingService fileHandlingService = FileHandlingService();
  ApiServices apiServices = ApiServices();
  NumberResponse numberResponse;
  String smsText;
  bool getNumberButtonPressed;
  bool smsReceived = false;
  bool showSpinner = false;
  bool shouldPop = true;
  bool _isInterstitialAdLoaded = false;
  @override
  void initState() {
    super.initState();
    getNumberButtonPressed = false;
    loadAd();
    loadInterstitialAd();
  }

  Widget _currentAd = SizedBox(
    width: 0,
    height: 0,
  );

  void loadAd() {
    setState(
      () {
        try {
          _currentAd = FANService.showNativeMediumRectngleAd();
        } catch (e) {
          print('error occurred while loading banner ad');
        }
      },
    );
  }

  void loadInterstitialAd() {
    FacebookInterstitialAd.loadInterstitialAd(
      placementId: Constants.interstitialPlacementId,
      listener: (result, value) {
        print(">> FAN > Interstitial Ad: $result --> $value");
        if (result == InterstitialAdResult.LOADED)
          FacebookInterstitialAd.showInterstitialAd(delay: 30000);
        _isInterstitialAdLoaded = true;

        if (result == InterstitialAdResult.DISMISSED &&
            value["invalidated"] == true) {
          _isInterstitialAdLoaded = false;
          loadInterstitialAd();
        }
      },
    );
  }

  // _showInterstitialAd() {
  //   if (_isInterstitialAdLoaded == true)
  //     FacebookInterstitialAd.showInterstitialAd();
  //   else
  //     print("Interstial Ad not yet loaded!");
  // }

  void updateUserCredits() {
    Constants.userPoints = Constants.userPoints - 7;
  }

  bool checkUserPointEligibility() {
    if (Constants.userPoints >= 10) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String confirmMsgString = Constants.countryNames[widget.countryId] +
        ' number for ' +
        Constants.servicesNames[widget.serviceCode];

    return WillPopScope(
      onWillPop: () async {
        print('back button pressed');
        //_showInterstitialAd();
        return shouldPop;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Get Number'),
        ),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Container(
            padding: EdgeInsets.only(top: 11.0, right: 10.0, left: 15.0),
            child: Column(
              children: [
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  children: [
                    Text(
                      confirmMsgString,
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 13.0),
                      ),
                      onPressed: (!(getNumberButtonPressed))
                          ? () async {
                              setState(() {
                                showSpinner = true;
                              });
                              apiServices
                                  .orderNumber(
                                      widget.serviceCode, widget.countryId)
                                  .then(
                                    (value) => setState(
                                      () {
                                        showSpinner = false;
                                        if (value != null) {
                                          numberResponse = value;
                                          getNumberButtonPressed = true;
                                        } else {
                                          Container(
                                            child: Flushbar(
                                              title: 'Error',
                                              message:
                                                  'No numbers available. Please try again later',
                                              duration: Duration(seconds: 3),
                                            )..show(context),
                                          );
                                        }
                                      },
                                    ),
                                  );
                            }
                          : null,
                      child: Text(
                        'Get Number',
                        style: TextStyle(fontSize: 22.0),
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
                    SelectableText(
                      numberResponse != null ? numberResponse.number : '',
                      style: TextStyle(fontSize: 18.0),
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
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 13.0),
                      ),
                      onPressed: getNumberButtonPressed
                          ? () async {
                              setState(() {
                                showSpinner = true;
                              });
                              smsText =
                                  await apiServices.getSms(numberResponse.id);
                              setState(
                                () {
                                  // get sms detail api call
                                  if (smsText != null &&
                                      smsText != "No SMS Received") {
                                    smsReceived = true;
                                    showSpinner = false;
                                  }
                                  // implement another button for change status and get another sms
                                  // apiServices.getSms('437259483');
                                },
                              );
                            }
                          : null,
                      child: Text(
                        'Show SMS',
                        style: TextStyle(fontSize: 22.0),
                      ),
                    ),
                    SizedBox(
                      width: 25.0,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 13.0),
                      ),
                      onPressed: smsReceived
                          ? () async {
                              setState(() {
                                showSpinner = true;
                              });
                              print('Complted the activation');
                              String resultMsg = await apiServices.changeStatus(
                                  '6', numberResponse.id);
                              setState(() {
                                showSpinner = false;
                              });
                              if (resultMsg == "ACCESS_ACTIVATION") {
                                Container(
                                  child: Flushbar(
                                    title: 'Success',
                                    message: 'Activation Success',
                                    duration: Duration(seconds: 3),
                                  )..show(context),
                                );
                              }
                            }
                          : null,
                      child: Text(
                        'Complete',
                        style: TextStyle(fontSize: 22.0),
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
                    Expanded(
                      child: SelectableText(
                        smsText != null ? smsText : '',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: _currentAd,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
