import 'package:flutter/material.dart';
import 'package:my_virtual_number/screens/icon_content.dart';
import 'package:my_virtual_number/screens/reusable_card.dart';
import 'package:my_virtual_number/service/api_services.dart';
import 'package:my_virtual_number/views/number_list_view.dart';

class CountryListView extends StatefulWidget {
  @override
  _CountryListViewState createState() => _CountryListViewState();
}

class _CountryListViewState extends State<CountryListView> {
  ApiServices apiService = ApiServices();
  @override
  void initState() {
    super.initState();
    //apiService.getAllCountries();
  }

  @override
  Widget build(BuildContext context) {
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
                      icon: Icons.ac_unit,
                      text: 'USA',
                    ),
                    screen: 'COUNTRY_SCREEN',
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    cardChild: IconContent(
                      icon: Icons.ac_unit,
                      text: 'UK',
                    ),
                    screen: 'COUNTRY_SCREEN',
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
                      icon: Icons.ac_unit,
                      text: 'Indonesia',
                    ),
                    screen: 'COUNTRY_SCREEN',
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    cardChild: IconContent(
                      icon: Icons.ac_unit,
                      text: 'Germany',
                    ),
                    screen: 'COUNTRY_SCREEN',
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
                      icon: Icons.mail_outline,
                      text: 'Philippines',
                    ),
                    screen: 'COUNTRY_SCREEN',
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    cardChild: IconContent(
                      icon: Icons.accessible_forward_outlined,
                      text: 'Malayasia',
                    ),
                    screen: 'COUNTRY_SCREEN',
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
                      icon: Icons.accessibility_new_outlined,
                      text: 'France',
                    ),
                    screen: 'COUNTRY_SCREEN',
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    cardChild: IconContent(
                      icon: Icons.ac_unit,
                      text: 'Canada',
                    ),
                    screen: 'COUNTRY_SCREEN',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

// children: [

//                 ReusableCard(
//                   cardChild: IconContent(
//                     icon: Icons.ac_unit,
//                     text: 'AAAAA',
//                   ),
//                 ),
//               ],

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

// FutureBuilder(
//           future: numberService.getFreeCountryList(),
//           builder: (BuildContext context, AsyncSnapshot snapshot) {
//             if (snapshot.hasData) {
//               return ListView.builder(
//                 itemCount: countryList.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return listViewItem(snapshot.data[index].countryText);
//                 },
//               );
//             } else {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//           },
//         ),
