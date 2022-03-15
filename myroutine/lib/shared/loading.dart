import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:myroutine/shared/constants.dart';

class Loading extends StatelessWidget {
  const Loading({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: myPrimaryLightColor,
        child: Center(child: SpinKitWave(
            color: Colors.white,
            size: 50.0
        ),)
    );
  }
}