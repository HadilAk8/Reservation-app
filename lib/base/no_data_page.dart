import 'package:flutter/material.dart';


class NoDataPage extends StatelessWidget {
  final String text;
  final String imgPath;

  const NoDataPage({Key? key , required this.text , this.imgPath = "assets/image/Empty_Cart.png"}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          imgPath,
          width: MediaQuery.of(context).size.width*0.22,
          height: MediaQuery.of(context).size.height*0.22,
        ),
        Text(
          text ,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height*0.0175,
            color: Theme.of(context).disabledColor
          ),
            textAlign: TextAlign.center,
          )
      ],
    );
  }
}