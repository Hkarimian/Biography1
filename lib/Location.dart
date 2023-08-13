import 'package:flutter/material.dart';
class Location extends StatelessWidget {
  const Location({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Image.asset('assets/images/img4.jpg'),
      fit: BoxFit.fill,
    );
  }
}
