import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:my_virtual_number/constants.dart';
import 'package:my_virtual_number/modal/number_response_dto.dart';
import 'package:my_virtual_number/service/api_services.dart';
import 'package:my_virtual_number/service/file_handling_service.dart';

const int maxFailedLoadAttempts = 3;

class GetNumberView extends StatefulWidget {
  GetNumberView({this.countryId, this.serviceCode});
  final String countryId;
  final String serviceCode;
  @override
  _GetNumberViewState createState() => _GetNumberViewState();
}

class _GetNumberViewState extends State<GetNumberView> {
  FileHandlingService fileHandlingService = FileHandlingService();
  ApiServices apiServices = ApiServices();
  NumberResponse numberResponse;
  String smsText;
  bool getNumberButtonPressed = false;
  bool smsReceived = false;
  bool showSpinner = false;

  RewardedAd _rewardedAd;
  int _numRewardLoadAttempts = 0;

  @override
  void initState() {
    super.initState();
    _createRewardAd();
  }

  void _createRewardAd() {
    RewardedAd.load(
        adUnitId: 'ca-app-pub-3246132399617809/2453541167',
        request: AdRequest(nonPersonalizedAds: true),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded');
            _rewardedAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
            _rewardedAd = null;
            _numRewardLoadAttempts += 1;
            if (_numRewardLoadAttempts <= maxFailedLoadAttempts) {
              _createRewardAd();
            }
          },
        ));
  }

  void _showRewardAd() {
    if (_rewardedAd == null) {
      print('Warning: attempt to show rewarded before loaded.');
      return;
    }
    _rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) {
        print('ad onAdShowedFullScreenContent.');
      },
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardAd();
      },
    );
    _rewardedAd.show(onUserEarnedReward: (RewardedAd ad, RewardItem reward) {
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type}');
      setState(() {
        Constants.userPoints = (Constants.userPoints + reward.amount);
      });
    });
    _rewardedAd = null;
  }

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
    _rewardedAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String viewAdInfoMessage =
        'You need atleast 10 points to order another number.View few ads to earn points';
    String confirmMsgString = 'Get ' +
        Constants.countryNames[widget.countryId] +
        ' number for ' +
        Constants.servicesNames[widget.serviceCode];
    String userPointsMessage =
        'Account Balance ' + Constants.userPoints.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Number'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          padding: EdgeInsets.only(top: 11.0, right: 10.0, left: 15.0),
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
                      style: TextStyle(fontSize: 17.0),
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
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 13.0),
                    ),
                    onPressed: (checkUserPointEligibility() &&
                            !(getNumberButtonPressed))
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
                                        updateUserCredits();
                                        fileHandlingService
                                            .writeToFile(Constants.userPoints);
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
                height: 20.0,
              ),
              Row(
                children: [
                  !checkUserPointEligibility()
                      ? Expanded(
                          child: Text(
                            viewAdInfoMessage,
                            style: TextStyle(fontSize: 17.0),
                          ),
                        )
                      : Container(),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  !checkUserPointEligibility()
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 13.0),
                          ),
                          onPressed: () {
                            _showRewardAd();
                            fileHandlingService
                                .writeToFile(Constants.userPoints);
                            // setState(() {

                            // });
                          },
                          child: Text(
                            'Show Ad',
                            style: TextStyle(fontSize: 22.0),
                          ),
                        )
                      : Container(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
