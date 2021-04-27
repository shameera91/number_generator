import 'package:flutter/cupertino.dart';

class IconContent extends StatelessWidget {
  IconContent({this.icon, this.text, this.iconPath});
  final IconData icon;
  final String text;
  final String iconPath;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          iconPath,
          width: 90.0,
          height: 50.0,
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 18.0),
        )
      ],
    );
  }
}
