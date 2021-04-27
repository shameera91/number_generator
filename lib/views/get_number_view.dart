import 'package:flutter/material.dart';
import 'package:my_virtual_number/constants.dart';

class GetNumberView extends StatefulWidget {
  GetNumberView({this.countryId, this.serviceCode});
  final String countryId;
  final String serviceCode;
  @override
  _GetNumberViewState createState() => _GetNumberViewState();
}

class _GetNumberViewState extends State<GetNumberView> {
  @override
  Widget build(BuildContext context) {
    String confirmMsgString = 'Get ' +
        countryNames[widget.countryId] +
        ' number for ' +
        servicesNames[widget.serviceCode];
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
                    'This number is valid for 10 minutes from the acivation ',
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
                ElevatedButton(
                  onPressed: () {
                    // get number api call
                  },
                  child: Text(
                    'Get Number',
                    style: TextStyle(fontSize: 22.0),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
