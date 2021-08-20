import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:recipe_app/plugins/responsive.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Image(
            alignment: Alignment.center,
            image: AssetImage('assets/images/home_img.jpg'),
          ),
          Text('data'),
        ],
      ),
    );
  }
}
