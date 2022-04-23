import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:myroutine/shared/constants.dart';
import '../../services/auth.dart';
import '../../services/database.dart';

class EditProduct extends StatefulWidget {
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
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
    final data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final AuthService _auth = AuthService();
    final dbService = DatabaseService(uid: _auth.getUid());
    List<SkinProblem> selected = [];
    List<SkinProblem> currentSP = [];
    List<String> currentSPstring = [];
    skinProbs.forEach((e) {
      if (data['skinProblem'].contains(e.name)) {
        currentSP.add(e);
        currentSPstring.add(e.toString());
      }
    });
    List<String> selectedSkinProblems = [];
    List<String> selectedSkinTypes = [];
    List<String> selectedEffects = [];
    List<String> selectedIngredients = [];
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
                    'Termék módosítása',
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
                      TextFormField(
                          initialValue: data['name'],
                          cursorColor: myPrimaryLightColor,
                          decoration: textInputDecoration.copyWith(
                            hintText: 'Termék neve',
                          ),
                          onChanged: (val) {
                            setState(() => _currentName.text = val);
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField(
                        decoration: textInputDecoration,
                        hint: Text("Márka"),
                        value: data['brand'],
                        items: brands.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() => _currentBrand.text = val.toString());
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField(
                        decoration: textInputDecoration,
                        hint: Text("Terület, ahol kifejti a hatást"),
                        value: data["area"],
                        items: areas.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() => _currentArea.text = val.toString());
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField<String>(
                        decoration: textInputDecoration,
                        hint: Text("Kategória"),
                        value: data["category"],
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
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          cursorColor: myPrimaryLightColor,
                          initialValue: data['texture'],
                          decoration: textInputDecoration.copyWith(
                            hintText: 'Textúra',
                          ),
                          onChanged: (val) {
                            setState(() => _currentTexture.text = val);
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
                        initialValue: currentSP,
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
                        initialValue: data['skinType'].cast<String>(),
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
                        buttonIcon: Icon(Icons.add_circle),
                        initialValue: data['effects'].cast<String>(),
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
                        initialValue: data['ingredients'].cast<String>(),
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
                              dbService.updateProductData(
                                  data['id'],
                                  _currentName.text.isEmpty
                                      ? data['name']
                                      : _currentName.text,
                                  _currentBrand.text.isEmpty
                                      ? data['brand']
                                      : _currentBrand.text,
                                  selectedSkinTypes.isEmpty
                                      ? data['skinType'].cast<String>()
                                      : selectedSkinTypes,
                                  selectedSkinProblems.isEmpty
                                      ? currentSPstring
                                      : selectedSkinProblems,
                                  _currentCategory.text.isEmpty
                                      ? data['category']
                                      : _currentCategory.text,
                                  _currentTexture.text.isEmpty
                                      ? data['texture']
                                      : _currentTexture.text,
                                  _currentArea.text.isEmpty
                                      ? data['area']
                                      : _currentArea.text,
                                  [], //TODO beállítani
                                  selectedEffects.isEmpty
                                      ? data['effects'].cast<String>()
                                      : selectedEffects,
                                  selectedIngredients);
                              Navigator.popAndPushNamed(context, '/admin');
                            }
                          },
                          child: Text('frissítés'.toUpperCase(),
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
