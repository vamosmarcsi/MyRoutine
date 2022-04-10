import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myroutine/services/auth.dart';
import 'package:myroutine/shared/constants.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:intl/intl.dart';

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

  @override
  String toString() {
    return 'SkinProblem{name: $name}';
  }
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  List<GlobalKey<FormState>> _formkeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];
  bool loading = false;
  String email = '';
  String pw = '';
  String pw2 = "";
  String err = '';
  String name = "";
  DateTime dob = DateTime.now();
  TextEditingController dateinput = TextEditingController();
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
  static List<String> skinTypes = [
    "normál",
    "száraz",
    "zsíros",
    "vízhiányos",
    "érzékeny"
  ];
  List<SkinProblem> selected = [];
  List<String> selectedSkinProblems = [];
  String selectedSkinType = "";
  bool isAdmin = false;
  bool isComplete = false;

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
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  padding: EdgeInsets.symmetric(horizontal: 20),
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
                                    steps: getSteps(),
                                    currentStep: currentStep,
                                    onStepContinue: () {
                                      final isLastStep =
                                          currentStep == getSteps().length - 1;
                                      if (isLastStep) {
                                        setState(() {
                                          isComplete = true;
                                        });
                                        setState(() {
                                          if (_formkeys[currentStep]
                                              .currentState!
                                              .validate()) {
                                            currentStep += 1;
                                          }
                                        });
                                        Navigator.pushNamed(context, '/wizard');
                                      } else {
                                        setState(() {
                                          if (_formkeys[currentStep]
                                              .currentState!
                                              .validate()) {
                                            currentStep += 1;
                                          }
                                        });
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
                                        child: Row(children: [
                                          if (currentStep == 2)
                                            Expanded(
                                                child: MaterialButton(
                                                    minWidth: double.infinity,
                                                    height: 60,
                                                    color: myPrimaryColor,
                                                    onPressed: () async {
                                                      if (_formkeys[2]
                                                          .currentState!
                                                          .validate()) {
                                                        print(isAdmin);
                                                        dynamic res = await _auth
                                                            .regWithEmailAndPw(
                                                                email,
                                                                pw,
                                                                name,
                                                                dob.toString(),
                                                                selectedSkinType,
                                                                selectedSkinProblems,
                                                          isAdmin
                                                        );
                                                        if (res == null) {
                                                          print(
                                                              "reg does not work, user is null");
                                                          setState(() => err =
                                                              'Érvényes email címet adj meg!');
                                                        } else {
                                                          print(
                                                              "USER LÉTREJÖTT");
                                                          Navigator
                                                              .popAndPushNamed(
                                                                  context,
                                                                  '/home');
                                                        }
                                                      }
                                                    },
                                                    child: Text(
                                                        'Mehet!'.toUpperCase(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16,
                                                            color: Colors
                                                                .white)))),
                                          if (currentStep != 2)
                                            Expanded(
                                                child: MaterialButton(
                                                    minWidth: double.infinity,
                                                    height: 60,
                                                    color: myPrimaryColor,
                                                    onPressed:
                                                        details.onStepContinue,
                                                    child: Text(
                                                        'Tovább'.toUpperCase(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16,
                                                            color: Colors
                                                                .white)))),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          if (currentStep != 0)
                                            Expanded(
                                              child: MaterialButton(
                                                minWidth: double.infinity,
                                                height: 60,
                                                onPressed: details.onStepCancel,
                                                color: Colors.white70,
                                                child: Text(
                                                    'Vissza'.toUpperCase(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 16,
                                                        color: myPrimaryColor)),
                                              ),
                                            ),
                                        ]),
                                      );
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
                key: _formkeys[0],
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Email cím',
                          prefixIcon: Icon(Icons.email, color: myPrimaryColor)),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Kérlek, add meg az email címed!';
                        } else {
                          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(val)) {
                            return 'Kérlek, adj meg egy érvényes email címet!';
                          } else {
                            return null;
                          }
                        }
                      },
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
                            hintText: 'Jelszó megerősítése',
                            prefixIcon:
                                Icon(Icons.lock, color: myPrimaryColor)),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'A jelszó nem lehet üres.';
                          } else {
                            if (val != pw.toString()) {
                              return 'A jelszavak nem egyeznek meg!';
                            } else {
                              return null;
                            }
                          }
                        },
                        obscureText: true,
                        onChanged: (val) {
                          setState(() => pw = val);
                        }),
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
            state: currentStep > 1 ? StepState.complete : StepState.disabled,
            isActive: currentStep >= 1,
            title: Text(''),
            content: Container(
              child: Form(
                key: _formkeys[1],
                child: Column(
                  children: [
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Név',
                          prefixIcon:
                              Icon(Icons.account_box, color: myPrimaryColor)),
                      validator: (val) =>
                          val!.isEmpty ? 'Kérlek, add meg a neved!' : null,
                      onChanged: (val) {
                        setState(() => name = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: dateinput,
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Születési dátum',
                          prefixIcon: Icon(Icons.cake, color: myPrimaryColor)),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: dob,
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now());
                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          setState(() {
                            dateinput.text =
                                formattedDate; //set output date to TextField value.
                          });
                        }
                      },
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Checkbox(
                          value: isAdmin,
                          onChanged: (value) {
                            setState(() {
                              isAdmin = value!;
                            });
                          },
                        ),
                        Text('Adminisztrátori jogosultság'),
                      ],
                    ),
                  ],
                ),
              ),
            )),
        //third step
        Step(
            state: currentStep > 2 ? StepState.complete : StepState.disabled,
            isActive: currentStep >= 2,
            title: Text(''),
            content: Container(
                child: Form(
                    key: _formkeys[2],
                    child: Column(
                      children: [
                        DropdownButtonFormField(
                          decoration: textInputDecoration,
                          items: _skinTypeList(),
                          hint: Text("Bőrtípus kiválasztása"),
                          value: selectedValue,
                          onChanged: (String? value) => setState(() {
                            selectedValue = value ?? "";
                            selectedSkinType = selectedValue ?? "";
                          }),
                        ),
                        SizedBox(height: 20),
                        MultiSelectDialogField<SkinProblem>(
                          decoration: BoxDecoration(
                            color: myPrimaryColor,
                            border:
                                Border.all(color: myPrimaryColor, width: 1.0),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          buttonText: Text(
                            'Bőrproblémák kiválasztása',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                          buttonIcon: Icon(Icons.add_circle),
                          items: skinProbs
                              .map((e) => MultiSelectItem(e, e.name))
                              .toList(),
                          listType: MultiSelectListType.CHIP,
                          onConfirm: (values) {
                            selected = values;
                            selected.forEach((e) {
                              selectedSkinProblems.add(e.name);
                            });
                          },
                        ),
                        SizedBox(height: 10)
                      ],
                    )))),
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
