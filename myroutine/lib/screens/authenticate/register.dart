import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myroutine/enums/skin_types.dart';
import 'package:myroutine/services/auth.dart';
import 'package:myroutine/shared/constants.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class SkinProblem {
  final int id;
  final String name;

  SkinProblem({
    required this.id,
    required this.name,
  });
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  bool loading = false;
  String email = '';
  String pw = '';
  String err = '';
  int currentStep = 0;
  String? selectedValue;
  static List<SkinProblem> skinProbs = [
    SkinProblem(id: 1, name: 'pattanások'),
    SkinProblem(id: 2, name: 'mitesszerek'),
    SkinProblem(id: 3, name: 'száraz bőr'),
    SkinProblem(id: 4, name: "ekcéma"),
    SkinProblem(id: 5, name: "ráncok"),
    SkinProblem(id: 6, name: "tág pórusok"),
    SkinProblem(id: 7, name: "pigmentfoltok"),
    SkinProblem(id: 8, name: "rosacea"),
    SkinProblem(id: 9, name: "akné"),
  ];
  final _items =
      skinProbs.map((s) => MultiSelectItem<SkinProblem>(s, s.name)).toList();
  static List<String> skinTypes = [
    "normál",
    "száraz",
    "zsíros",
    "vízhiányos",
    "érzékeny"
  ];
  List<SkinProblem> selected = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[100],
          elevation: 0.0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black)),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "Regisztráció",
                      style: GoogleFonts.comforter(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: myPrimaryColor),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Column(children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 1.3,
                            child: Column(children: [
                              Expanded(
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                      colorScheme: ColorScheme.light(
                                          primary: myPrimaryColor)),
                                  child: Stepper(
                                    type: StepperType.horizontal,
                                    steps: getSteps(),
                                    currentStep: currentStep,
                                    onStepContinue: () {
                                      final isLastStep =
                                          currentStep == getSteps().length - 1;
                                      if (isLastStep) {
                                        Navigator.pushNamed(context, '/wizard');
                                      } else {
                                        setState(() => currentStep += 1);
                                      }
                                    },
                                    onStepCancel: () {
                                      currentStep == 0
                                          ? null
                                          : setState(() => currentStep -= 1);
                                    },
                                    controlsBuilder: (
                                      context,
                                      ControlsDetails details,
                                    ) {
                                      return Container(
                                          margin: EdgeInsets.only(top: 50),
                                          child: Row(children: [
                                            Expanded(
                                                child: MaterialButton(
                                                    minWidth: double.infinity,
                                                    height: 60,
                                                    color: myPrimaryColor,
                                                    onPressed:
                                                        details.onStepContinue,
                                                    /*onPressed: () async {
                                                    if (_formKey.currentState!.validate()) {
                                                      dynamic res =
                                                      await _auth.regWithEmailAndPw(email, pw);
                                                      details.onStepContinue;
                                                      if (res == null) {
                                                        setState(
                                                                () => err = 'Érvényes email címet adj meg!');
                                                      } else {
                                                        details.onStepContinue;
                                                        print("DEBUG");
                                                        print(res);
                                                        //TODO kijavítani, mert ide nem lép be
                                                      }
                                                    }
                                                  },*/
                                                    child: Text(
                                                        'Tovább'.toUpperCase(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16,
                                                            color: Colors
                                                                .white)))),
                                            if (currentStep != 0)
                                              Expanded(
                                                child: MaterialButton(
                                                  minWidth: double.infinity,
                                                  height: 60,
                                                  onPressed:
                                                      details.onStepCancel,
                                                  child: Text(
                                                      'Vissza'.toUpperCase(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16,
                                                          color:
                                                              myPrimaryColor)),
                                                ),
                                              ),
                                          ]));
                                    },
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
                /*Flexible(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('assets/images/roka-pitypang.png'),
                      fit: BoxFit.cover,
                    )),
                  ),
                ),*/
              ]),
        ));
  }

  List<Step> getSteps() => [
        Step(
            state: currentStep > 0 ? StepState.complete : StepState.disabled,
            isActive: currentStep >= 0,
            title: Text(''),
            content: Container(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Email cím',
                          prefixIcon: Icon(Icons.email, color: myPrimaryColor)),
                      validator: (val) => val!.isEmpty
                          ? 'Kérlek, add meg az email címed!'
                          : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Jelszó',
                            prefixIcon: Icon(Icons.key, color: myPrimaryColor)),
                        validator: (val) => val!.length < 6
                            ? 'A jelszó legalább 6 karakterból állhat.'
                            : null,
                        obscureText: true,
                        onChanged: (val) {
                          setState(() => pw = val);
                        }),
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Jelszó újra',
                            prefixIcon: Icon(Icons.key, color: myPrimaryColor)),
                        validator: (val) => val!.length < 6
                            ? 'A jelszó legalább 6 karakterból állhat.'
                            : null,
                        obscureText: true,
                        onChanged: (val) {
                          setState(() => pw = val);
                        }),
                    /*MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        color: myPrimaryColor,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            dynamic res =
                                await _auth.regWithEmailAndPw(email, pw);
                            if (res == null) {
                              setState(
                                  () => err = 'Érvényes email címet adj meg!');
                            } else {
                              Navigator.pushNamed(context, '/wizard');
                            }
                          }
                        },
                        child: Text('Regisztrálok'.toUpperCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Colors.white))),*/
                    SizedBox(height: 5.0),
                    Text(
                      err,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                  ],
                ),
              ),
            )),
        //Second step:
        Step(
            isActive: currentStep >= 1,
            title: Text(''),
            content: Container(
              child: Form(
                key: _formKey2,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Név',
                          prefixIcon:
                              Icon(Icons.account_box, color: myPrimaryColor)),
                      /*validator: (val) => val!.isEmpty
                          ? 'Kérlek, add meg az email címed!'
                          : null,*/
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Születési dátum',
                            prefixIcon:
                                Icon(Icons.cake, color: myPrimaryColor)),
                        /*validator: (val) => val!.length < 6
                            ? 'A jelszó legalább 6 karakterból állhat.'
                            : null,*/
                        obscureText: true,
                        onChanged: (val) {
                          setState(() => pw = val);
                        }),
                    SizedBox(height: 20.0),
                    DropdownButtonFormField(
                      decoration: textInputDecoration,
                      items: _skinTypeList(),
                      hint: Text("Bőrtípus kiválasztása"),
                      value: selectedValue,
                      onChanged: (String? value) => setState(() {
                        selectedValue = value ?? "";
                      }),
                    ),
                    SizedBox(height: 20),
                    MultiSelectDialogField<SkinProblem>(
                      decoration: BoxDecoration(
                        border: Border.all(color: myPrimaryColor, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      items: skinProbs
                          .map((e) => MultiSelectItem(e, e.name))
                          .toList(),
                      listType: MultiSelectListType.CHIP,
                      onConfirm: (values) {
                        selected = values;
                      },
                    ),
                  ],
                ),
              ),
            )),
        Step(isActive: currentStep >= 2, title: Text(''), content: Container()),
      ];

  List<DropdownMenuItem<String>> _skinTypeList() {
    return skinTypes
        .map<DropdownMenuItem<String>>(
          (e) => DropdownMenuItem(
            value: e,
            child: Text(e),
          ),
        )
        .toList();
  }
}
