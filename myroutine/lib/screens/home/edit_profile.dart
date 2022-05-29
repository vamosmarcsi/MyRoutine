import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:myroutine/services/storage.dart';
import '../../services/auth.dart';
import '../../services/constants.dart';
import '../../services/database.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  String name = "";
  DateTime dob = DateTime.now();
  String profilePic = "";
  TextEditingController dateInput = TextEditingController();
  TextEditingController _currentName = TextEditingController();
  List<SkinProblem> selected = [];
  List<String> selectedSkinProblems = [];
  List<SkinProblem> currentSP = [];
  List<String> currentSPstring = [];
  final storage = Storage();
  String changedName = "";
  String changedDOB = "";
  @override
  void dispose() {
    super.dispose();
    dateInput.dispose();
    _currentName.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _currentName.text = data["name"];
    skinProbs.forEach((e) {
      if (data['skinProblem'].contains(e.name)) {
        currentSP.add(e);
        currentSPstring.add(e.toString());
      }
    });
    String formattedDateFromData = DateFormat('yyyy-MM-dd').format(DateTime.parse(data["DOB"]));
    dateInput.text = dateInput.text.isNotEmpty ? dateInput.text : formattedDateFromData;
    return Scaffold(
        backgroundColor: myPrimaryLightColor,
        appBar: AppBar(
          backgroundColor: myPrimaryLightColor,
          elevation: 0.0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios,
                  size: 20, color: Colors.white)),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              children: [
                Text(
                  "Profil szerkesztése",
                  style: GoogleFonts.comforter(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.white),
                ),
                /*FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(AuthService().getUid())
                      .get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text("Something went wrong");
                    }
                    if (snapshot.hasData && !snapshot.data!.exists) {
                      return const Text("Document does not exist");
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;
                      String picName = data['profile_pic'].toString();
                      if (data["profile_pic"] != null) {
                        return FutureBuilder(
                          future: storage.downloadProfilePicURL(picName),
                          builder: (context, AsyncSnapshot<String> snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                !data["profile_pic"].isEmpty && snapshot.hasData) {
                              return CircleAvatar(
                                radius: 100.0,
                                backgroundImage:
                                    Image.network(snapshot.data!).image,
                                child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: uploadPic()),
                              );
                            }
                            if (snapshot.connectionState ==
                                    ConnectionState.waiting ||
                                !snapshot.hasData) {
                              return const CircularProgressIndicator();
                            }
                            return CircleAvatar(
                                radius: 30.0,
                                backgroundColor: myPrimaryColor,
                                child: uploadPic());
                          },
                        );
                      }
                    }
                    return CircleAvatar(
                      radius: 30.0,
                      backgroundColor: myPrimaryColor,
                      child: uploadPic(),
                    );
                  },
                ),*/
                blank,
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: data["name"],
                          validator: (val) =>
                              val!.isEmpty ? 'Kérlek, add meg a neved!' : null,
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Név',
                              prefixIcon: const Icon(Icons.person,
                                  color: myPrimaryColor)),
                          onChanged: (val) {
                            setState(() => _currentName.text = val);
                            setState(() => changedName = val);
                          },
                        ),
                        blank,
                        TextFormField(
                          //initialValue: changedDOB.isNotEmpty ? changedDOB : formattedDateFromData,
                          controller: dateInput,
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Születési dátum',
                              prefixIcon: const Icon(Icons.cake,
                                  color: myPrimaryColor)),
                          onTap: () async {
                            FocusScope.of(context).requestFocus(new FocusNode());
                            DateTime? pickedDate = await showDatePicker(
                              //fieldLabelText: changedDOB.isNotEmpty ? changedDOB : formattedDateFromData,
                                locale: const Locale("hu", "HU"),
                                context: context,
                                initialDate: DateTime.parse(data["DOB"]),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now());
                            if (pickedDate != null) {
                              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                              //dateInput.text = formattedDate;
                              setState(() {
                                dateInput.text = formattedDate;
                                //changedDOB = formattedDate;
                              });
                            }
                          },
                        ),
                        blank,
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
                          selectedColor: myPrimaryColor,
                          selectedItemsTextStyle:
                              TextStyle(color: Colors.white),
                          initialValue: currentSP,
                          items: skinProbs
                              .map((e) => MultiSelectItem(e, e.name))
                              .toList(),
                          listType: MultiSelectListType.CHIP,
                          onConfirm: (values) {
                            selected = values;
                            selectedSkinProblems = [];
                            selected.forEach((e) {
                              selectedSkinProblems.add(e.name);

                            });
                            //print(selectedSkinProblems);
                          },
                        ),
                        MaterialButton(
                            minWidth: double.infinity,
                            height: 60,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            color: myPrimaryColor,
                            onPressed: () {
                              print(selectedSkinProblems);
                              if (_formKey.currentState!.validate()) {
                                DatabaseService(uid: AuthService().getUid())
                                    .updateUserData(
                                        changedName.isEmpty
                                            ? data['name']
                                            : changedName,
                                        dateInput.text.isEmpty
                                            ? data["dob"]
                                            : dateInput.text,
                                        selectedSkinProblems.isEmpty
                                            ? currentSPstring
                                            : selectedSkinProblems);
                                Navigator.popAndPushNamed(context, '/home');
                              }
                            },
                            child: Text('frissítés'.toUpperCase(),
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
        ));
  }

  Widget uploadPic() {
    return TextButton(
      onPressed: () async {
        final pic = await FilePicker.platform.pickFiles(
            allowMultiple: false,
            type: FileType.custom,
            allowedExtensions: [
              'png',
              'jpg',
            ]);
        if (pic == null) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Nincs kiválasztva fájl!'),
          ));
          return null;
        }
        final path = pic.files.single.path!;
        final fName = "profile_pic/" + pic.files.single.name;
        setState(() {
          profilePic = fName;
        });
        storage
            .uploadProfilePic(path, fName)
            .then((value) => print('Uploaded profile picture!'));
        DatabaseService(uid: AuthService().getUid())
            .updateProfilePic(profilePic);
      },
      child: const Icon(
        Icons.add_a_photo,
        color: Colors.black,
      ),
    );
  }
}
