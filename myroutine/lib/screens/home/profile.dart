import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:myroutine/screens/home/edit_profile.dart';
import 'package:myroutine/services/storage.dart';
import '../../services/auth.dart';
import '../../services/constants.dart';
import '../../services/database.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    dateInput.dispose();
  }

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
            icon: const Icon(Icons.arrow_back_ios,
                size: 20, color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Profil",
              style: GoogleFonts.comforter(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.white),
            ),
            FutureBuilder<DocumentSnapshot>(
                future: DatabaseService(uid: AuthService().getUid())
                    .currentUserData(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Something went wrong");
                  }
                  if (snapshot.hasData && !snapshot.data!.exists) {
                    return const Text("Document does not exist");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      !snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;
                    skinProbs.forEach((e) {
                      if (data['skinProblem'].contains(e.name)) {
                        currentSP.add(e);
                        currentSPstring.add(e.toString());
                      }
                    });
                    String formattedDateFromData = DateFormat('yyyy-MM-dd')
                        .format(DateTime.parse(data["DOB"]));
                    dateInput.text = formattedDateFromData;
                    _currentName.text = data["name"];
                    return Column(
                      children: [
                        if (data["profile_pic"] != null)
                          FutureBuilder(
                            future: storage
                                .downloadProfilePicURL(data["profile_pic"]),
                            builder: (context, AsyncSnapshot<String> snapshot) {
                              if (snapshot.connectionState ==
                                      ConnectionState.done &&
                                  snapshot.data != null &&
                                  !data["profile_pic"].isEmpty) {
                                return CircleAvatar(
                                  radius: 100.0,
                                  backgroundColor: myPrimaryLightColor,
                                  backgroundImage:
                                      Image.network(snapshot.data!).image,
                                  child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: uploadPic()),
                                );
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }
                              return SizedBox(
                                height: 80,
                                width: 80,
                                child: Stack(
                                  fit: StackFit.expand,
                                  clipBehavior: Clip.none,
                                  children: [
                                    const CircleAvatar(
                                      radius: 30.0,
                                      backgroundColor: myPrimaryColor,
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white70,
                                      ),
                                    ),
                                    Positioned(
                                      right: -12,
                                      bottom: 0,
                                      child: SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: uploadPic(),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  enabled: false,
                                  controller: _currentName,
                                  validator: (val) => val!.isEmpty
                                      ? 'Kérlek, add meg a neved!'
                                      : null,
                                  onChanged: (val) {
                                    setState(() => _currentName.text = val);
                                  },
                                  decoration: textInputDecoration.copyWith(
                                      hintText: 'Név',
                                      prefixIcon: const Icon(Icons.person,
                                          color: myPrimaryColor)),
                                ),
                                blank,
                                TextFormField(
                                  enabled: false,
                                  controller: dateInput,
                                  decoration: textInputDecoration.copyWith(
                                      hintText: 'Születési dátum',
                                      prefixIcon: const Icon(Icons.cake,
                                          color: myPrimaryColor)),
                                  readOnly: true,
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate:
                                            DateTime.parse(data["DOB"]),
                                        locale: const Locale("hu", "HU"),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime.now());
                                    if (pickedDate != null) {
                                      String formattedDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(pickedDate);
                                      setState(() {
                                        dateInput.text = formattedDate;
                                      });
                                    }
                                  },
                                ),
                                blank,
                                const Text("Bőrproblémák:"),
                                SizedBox(
                                  height: data["skinProblem"].length * 70.0,
                                  child: ListView(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    children:
                                        data["skinProblem"].map<Widget>((prob) {
                                      return Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Card(
                                            margin: const EdgeInsets.fromLTRB(
                                                20.0, 6.0, 20.0, 0.0),
                                            child: ListTile(title: Text(prob)),
                                          ));
                                    }).toList(),
                                  ),
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
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const EditProfile(),
                                            settings:
                                                RouteSettings(arguments: data)),
                                      );
                                    },
                                    child: Text(
                                        'adatok szerkesztése'.toUpperCase(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            color: Colors.white)))
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  }
                  return const CircularProgressIndicator();
                }),
          ],
        ),
      ),
    );
  }

  Widget uploadPic() {
    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        backgroundColor: Colors.white70,
        padding: EdgeInsets.zero,
      ),
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
