import 'package:flutter/material.dart';
import 'package:my_virtual_number/service/number_service.dart';

class MessageListView extends StatefulWidget {
  MessageListView(this.number);
  final String number;
  @override
  _MessageListViewState createState() => _MessageListViewState();
}

class _MessageListViewState extends State<MessageListView> {
  NumberService numberService = NumberService();
  @override
  void initState() {
    super.initState();
    numberService.getMessageListByNumber(widget.number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Message View'),
      ),
    );
  }
}
