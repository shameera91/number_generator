import 'package:flutter/material.dart';
import 'package:my_virtual_number/modal/country_list.dart';
import 'package:my_virtual_number/views/number_list_view.dart';

class CountryListView extends StatefulWidget {
  @override
  _CountryListViewState createState() => _CountryListViewState();
}

class _CountryListViewState extends State<CountryListView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Country List'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10.0),
        child: ListView.builder(
          itemCount: countryList.length,
          itemBuilder: (BuildContext context, int index) {
            return listViewItem(
                countryList[index].countryText, countryList[index].country);
          },
        ),
      ),
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
