import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:myroutine/services/constants.dart';
import '../../services/auth.dart';
import '../../services/database.dart';
import 'package:myroutine/services/storage.dart';

class NewProduct extends StatefulWidget {

  @override
  _NewProductState createState() => _NewProductState();
}

class _NewProductState extends State<NewProduct> {
  final _formKey = GlobalKey<FormState>();
  final _currentBrand = TextEditingController();
  final _currentName = TextEditingController();
  final _currentArea = TextEditingController();
  final _currentCategory = TextEditingController();
  final _currentTexture = TextEditingController();
  final _currentSkinProblem = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _currentBrand.dispose();
    _currentName.dispose();
    _currentArea.dispose();
    _currentCategory.dispose();
    _currentTexture.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final brandsFromFB = ModalRoute.of(context)!.settings.arguments;
    print(brandsFromFB.toString());
    final AuthService _auth = AuthService();
    final dbService = DatabaseService(uid: _auth.getUid());
    final storage = Storage();
    List<SkinProblem> selected = [];
    List<String> selectedSkinProblems = [];
    List<String> selectedSkinTypes = [];
    List<String> selectedEffects = [];
    List<String> selectedIngredients = [];
    late String product_pic = "";
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
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Column(
                children: <Widget>[
                  Text(
                    "Új termék hozzáadása",
                    style: GoogleFonts.comforter(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: myPrimaryColor),
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          final pic = await FilePicker.platform.pickFiles(
                              allowMultiple: false,
                              type: FileType.custom,
                              allowedExtensions: ['png', 'jpg']);
                          if (pic == null) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Nincs kiválasztva fájl!'),
                            ));
                            return null;
                          }
                          final path = pic.files.single.path!;
                          final fName = "products/" + pic.files.single.name;
                          setState(() {
                            product_pic = fName;
                          });
                          storage.uploadProfilePic(path, fName).then(
                              (value) => print('Uploaded product picture!'));
                        },
                        icon: Icon(Icons.add_a_photo),
                        label: Text("Kép a termékről"),
                        style: ElevatedButton.styleFrom(
                          primary: myPrimaryColor,
                        ),
                      ),
                      blank,
                      TextFormField(
                        cursorColor: myPrimaryLightColor,
                        decoration: textInputDecoration.copyWith(
                          hintText: 'Termék neve',
                        ),
                        onChanged: (val) {
                          setState(() => _currentName.text = val);
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Kitöltendő mező!';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField<String>(
                          decoration: textInputDecoration,
                          hint: Text("Márka"),
                          items: brands.map((item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() => _currentBrand.text = val.toString());
                          },
                          validator: (val) {
                            if (val == null) {
                              return 'Kérlek, válassz!';
                            } else {
                              return null;
                            }
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField<String>(
                          decoration: textInputDecoration,
                          hint: Text("Terület, ahol kifejti a hatást"),
                          items: areas.map((item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() => _currentArea.text = val.toString());
                          },
                          validator: (val) {
                            if (val == null) {
                              return 'Kérlek, válassz!';
                            } else {
                              return null;
                            }
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField<String>(
                          decoration: textInputDecoration,
                          hint: Text("Kategória"),
                          items: categories.map((item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(
                                () => _currentCategory.text = val.toString());
                          },
                          validator: (val) {
                            if (val == null) {
                              return 'Kérlek, válassz!';
                            } else {
                              return null;
                            }
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          cursorColor: myPrimaryLightColor,
                          decoration: textInputDecoration.copyWith(
                            hintText: 'Textúra',
                          ),
                          onChanged: (val) {
                            setState(() => _currentTexture.text = val);
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Kitöltendő mező!';
                            } else {
                              return null;
                            }
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      MultiSelectDialogField<SkinProblem>(
                        decoration: BoxDecoration(
                          color: myPrimaryColor,
                          border: Border.all(color: myPrimaryColor, width: 1.0),
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
                        selectedColor: myPrimaryColor,
                        selectedItemsTextStyle: TextStyle(color: Colors.white),
                        listType: MultiSelectListType.CHIP,
                        onConfirm: (values) {
                          selected = values;
                          selected.forEach((e) {
                            selectedSkinProblems.add(e.name);
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MultiSelectDialogField<String>(
                        decoration: BoxDecoration(
                          color: myPrimaryColor,
                          border: Border.all(color: myPrimaryColor, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        buttonText: Text(
                          'Bőrtípus(ok) kiválasztása',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                        buttonIcon: Icon(Icons.add_circle),
                        selectedColor: myPrimaryColor,
                        selectedItemsTextStyle: TextStyle(color: Colors.white),
                        items: skinTypes
                            .map((e) => MultiSelectItem(e, e))
                            .toList(),
                        listType: MultiSelectListType.CHIP,
                        onConfirm: (values) {
                          selectedSkinTypes = values;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MultiSelectDialogField<String>(
                        decoration: BoxDecoration(
                          color: myPrimaryColor,
                          border: Border.all(color: myPrimaryColor, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        buttonText: Text(
                          'Hatások',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                        selectedColor: myPrimaryColor,
                        selectedItemsTextStyle: TextStyle(color: Colors.white),
                        buttonIcon: Icon(Icons.add_circle),
                        items:
                            effects.map((e) => MultiSelectItem(e, e)).toList(),
                        listType: MultiSelectListType.CHIP,
                        onConfirm: (values) {
                          selectedEffects = values;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MultiSelectDialogField<String>(
                        decoration: BoxDecoration(
                          color: myPrimaryColor,
                          border: Border.all(color: myPrimaryColor, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        buttonText: Text(
                          'Összetevők',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                        buttonIcon: Icon(Icons.add_circle),
                        selectedColor: myPrimaryColor,
                        selectedItemsTextStyle: TextStyle(color: Colors.white),
                        items: ingredients
                            .map((e) => MultiSelectItem(e, e))
                            .toList(),
                        listType: MultiSelectListType.CHIP,
                        onConfirm: (values) {
                          selectedIngredients = values;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MaterialButton(
                          minWidth: double.infinity,
                          height: 60,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          color: myPrimaryColor,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              dbService.addProduct(
                                  _currentName.text,
                                  _currentBrand.text,
                                  selectedSkinTypes,
                                  selectedSkinProblems,
                                  _currentCategory.text,
                                  _currentTexture.text,
                                  _currentArea.text,
                                  [],
                                  selectedEffects,
                                  selectedIngredients,
                                  product_pic);
                              Navigator.popAndPushNamed(context, '/admin');
                            }
                          },
                          child: Text('Létrehoz'.toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Colors.white))),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
