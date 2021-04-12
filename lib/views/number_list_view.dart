import 'package:flutter/material.dart';
import 'package:my_virtual_number/modal/number_modal.dart';
import 'package:my_virtual_number/service/number_service.dart';
import 'package:my_virtual_number/views/messages_list_view.dart';

class NumberListView extends StatefulWidget {
  NumberListView(this.countryId);
  final int countryId;

  @override
  _NumberListViewState createState() => _NumberListViewState();
}

class _NumberListViewState extends State<NumberListView> {
  NumberService numberService = NumberService();
  List<NumberModal> numberlistByCountry = [];
  bool loaded = false;
  @override
  void initState() {
    loadNumberList(widget.countryId);
    super.initState();
  }

  void loadNumberList(int countryId) async {
    numberlistByCountry =
        await numberService.getNumberlistByCountry(countryId.toString());
    setState(() {
      loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number View'),
      ),
      body: Container(
        child: loaded
            ? ListView.builder(
                itemCount: numberlistByCountry.length,
                itemBuilder: (BuildContext context, int index) {
                  if (numberlistByCountry.isNotEmpty) {
                    return listViewItem(numberlistByCountry[index].phoneNumber);
                  } else {
                    return Center(
                      child: Text('No Numbers Available'),
                    );
                  }
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  Widget listViewItem(String number) {
    return Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      alignment: Alignment.center,
      child: Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () async {
            // List<NumberModal> numberlistByCountry = await numberService
            //     .getNumberlistByCountry(countryId.toString());
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MessageListView(number),
              ),
            );
          },
          child: Text(
            number,
            style: TextStyle(fontSize: 25.0),
          ),
        ),
      ),
    );
  }
}
