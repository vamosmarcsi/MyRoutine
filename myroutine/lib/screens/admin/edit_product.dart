import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:myroutine/services/constants.dart';
import 'package:path/path.dart';
import '../../services/auth.dart';
import '../../services/database.dart';
import 'package:myroutine/services/storage.dart';

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
  String product_pic = "";

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
    final storage = Storage();
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
                            product_pic = fName.toString();
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
                          initialValue: data['name'],
                          cursorColor: myPrimaryLightColor,
                          decoration: textInputDecoration.copyWith(
                            hintText: 'Termék neve',
                          ),
                          onChanged: (val) {
                            setState(() => _currentName.text = val);
                          }),
                      blank,
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
                      blank,
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
                      blank,
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
                      blank,
                      TextFormField(
                          cursorColor: myPrimaryLightColor,
                          initialValue: data['texture'],
                          decoration: textInputDecoration.copyWith(
                            hintText: 'Textúra',
                          ),
                          onChanged: (val) {
                            setState(() => _currentTexture.text = val);
                          }),
                      blank,
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
                        selectedColor: myPrimaryColor,
                        selectedItemsTextStyle: TextStyle(color: Colors.white),
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
                      blank,
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
                        selectedColor: myPrimaryColor,
                        selectedItemsTextStyle: TextStyle(color: Colors.white),
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
                      blank,
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
                        selectedColor: myPrimaryColor,
                        selectedItemsTextStyle: TextStyle(color: Colors.white),
                        initialValue: data['effect'].cast<String>(),
                        items:
                            effects.map((e) => MultiSelectItem(e, e)).toList(),
                        listType: MultiSelectListType.CHIP,
                        onConfirm: (values) {
                          selectedEffects = values;
                        },
                      ),
                      blank,
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
                        initialValue: data['ingredients'].cast<String>(),
                        items: ingredients
                            .map((e) => MultiSelectItem(e, e))
                            .toList(),
                        listType: MultiSelectListType.CHIP,
                        onConfirm: (values) {
                          selectedIngredients = values;
                        },
                      ),
                      blank,
                      MaterialButton(
                          minWidth: double.infinity,
                          height: 60,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          color: myPrimaryColor,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              print(product_pic);
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
                                      ? data['effect'].cast<String>()
                                      : selectedEffects,
                                  selectedIngredients,
                                  product_pic);
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
