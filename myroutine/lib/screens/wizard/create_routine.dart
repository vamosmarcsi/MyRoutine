import 'package:flutter/material.dart';
import '../../services/constants.dart';

class CreateRoutine extends StatefulWidget {
  const CreateRoutine({Key? key}) : super(key: key);

  @override
  State<CreateRoutine> createState() => _CreateRoutineState();
}

class _CreateRoutineState extends State<CreateRoutine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: myPrimaryLightColor,
      appBar: AppBar(
        backgroundColor: myPrimaryLightColor,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.white)),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column( children: [

          ],)),
    );
  }
}
