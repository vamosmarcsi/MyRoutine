import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myroutine/services/auth.dart';
import 'package:myroutine/services/storage.dart';
import '../../services/constants.dart';
import '../../services/database.dart';

class CurrentProduct extends StatefulWidget {
  @override
  State<CurrentProduct> createState() => _CurrentProductState();
}

class _CurrentProductState extends State<CurrentProduct> {
  final _formKey = GlobalKey<FormState>();
  final _currentBrand = TextEditingController();
  final _currentName = TextEditingController();
  final _currentArea = TextEditingController();
  final _currentCategory = TextEditingController();
  final _currentTexture = TextEditingController();
  final _currentSkinProblem = TextEditingController();
  final _currentReview = TextEditingController();
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
      backgroundColor: myPrimaryLightColor,
      appBar: AppBar(
        backgroundColor: myPrimaryLightColor,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              data["name"],
              style: GoogleFonts.comforter(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FutureBuilder(
                        future: storage.downloadProfilePicURL(data["picture"]),
                        builder: (context, AsyncSnapshot<String> snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.hasData) {
                            return CircleAvatar(
                              radius: 100.0,
                              backgroundColor: myPrimaryColor,
                              child: ClipRect(
                                child: Image.network(
                                  snapshot.data!,
                                ),
                              ),
                            );
                          }
                          return const CircleAvatar(
                            radius: 30.0,
                            backgroundColor: myPrimaryColor,
                            child: Icon(
                              Icons.add_a_photo,
                              color: Colors.white70,
                            ),
                          );
                        }),
                    blank,
                    TextFormField(
                      enabled: false,
                      initialValue: "Név: " + data['name'],
                      cursorColor: myPrimaryLightColor,
                      decoration: textInputDecoration,
                    ),
                    blank,
                    TextFormField(
                      enabled: false,
                      initialValue: "Márka: " + data['brand'],
                      cursorColor: myPrimaryLightColor,
                      decoration: textInputDecoration,
                    ),
                    blank,
                    TextFormField(
                      enabled: false,
                      initialValue: "Terület: " + data['area'],
                      cursorColor: myPrimaryLightColor,
                      decoration: textInputDecoration,
                    ),
                    blank,
                    TextFormField(
                      enabled: false,
                      initialValue: "Kategória: " + data['category'],
                      cursorColor: myPrimaryLightColor,
                      decoration: textInputDecoration,
                    ),
                    blank,
                    TextFormField(
                      cursorColor: myPrimaryLightColor,
                      initialValue: "Textúra: " + data['texture'],
                      decoration: textInputDecoration,
                    ),
                    blank,
                    const Text("Bőrproblémák:"),
                    Flexible(
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: data["skinProblem"].map<Widget>((prob) {
                          return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Card(
                                margin: const EdgeInsets.fromLTRB(
                                    20.0, 6.0, 20.0, 0.0),
                                child: ListTile(title: Text(prob)),
                              ));
                        }).toList(),
                      ),
                    ),
                    blank,
                    const Text("Bőrtípus(ok): "),
                    Flexible(
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children:
                            data['skinType'].cast<String>().map<Widget>((prob) {
                          return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Card(
                                margin: const EdgeInsets.fromLTRB(
                                    20.0, 6.0, 20.0, 0.0),
                                child: ListTile(title: Text(prob)),
                              ));
                        }).toList(),
                      ),
                    ),
                    blank,
                    const Text("Hatás(ok): "),
                    Flexible(
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children:
                            data['effect'].cast<String>().map<Widget>((prob) {
                          return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Card(
                                margin: const EdgeInsets.fromLTRB(
                                    20.0, 6.0, 20.0, 0.0),
                                child: ListTile(title: Text(prob)),
                              ));
                        }).toList(),
                      ),
                    ),
                    blank,
                    const Text("Összetevők: "),
                    Flexible(
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: data['ingredients']
                            .cast<String>()
                            .map<Widget>((prob) {
                          return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Card(
                                margin: const EdgeInsets.fromLTRB(
                                    20.0, 6.0, 20.0, 0.0),
                                child: ListTile(title: Text(prob)),
                              ));
                        }).toList(),
                      ),
                    ),
                    blank,
                    if (data["reviews"] != null) const Text("Vélemények: "),
                    if (data["reviews"] != null)
                      Flexible(
                        child: ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: data['reviews']
                              .cast<String>()
                              .map<Widget>((prob) {
                            return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Card(
                                  margin: const EdgeInsets.fromLTRB(
                                      20.0, 6.0, 20.0, 0.0),
                                  child: ListTile(title: Text(prob)),
                                ));
                          }).toList(),
                        ),
                      ),
                    blank,
                    TextFormField(
                      maxLines: 8,
                      controller: _currentReview,
                      decoration: textInputDecoration.copyWith(
                          hintText: "Vélemény hozzáadása"),
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
                          data["reviews"]
                              .cast<String>()
                              .add(_currentReview.text);
                          dbService.updateReviews(
                              data["id"], data["reviews"].cast<String>());
                          setState(() {
                            _currentReview.text = "";
                          });
                        },
                        child: Text('Vélemény hozzáadása'.toUpperCase(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Colors.white)))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
