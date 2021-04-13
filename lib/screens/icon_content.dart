import 'package:flutter/cupertino.dart';

class IconContent extends StatelessWidget {
  IconContent({this.icon, this.text});
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 80,
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(text)
      ],
    );
  }
}
