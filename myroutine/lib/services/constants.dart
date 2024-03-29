import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.brown, width: 1.0)),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: myPrimaryColor, width: 2.5)),
);

const myPrimaryColor = Colors.brown;
//lila:Color(0xFF7E57C2);
const myPrimaryLightColor = Color(0xFFA1887F);
//világoslila: Color(0xFFD1C4E9);

class SkinProblem {
  final int id;
  final String name;

  SkinProblem({
    required this.id,
    required this.name,
  });

  @override
  String toString() {
    return name;
  }
}

List<SkinProblem> skinProbs = [
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
List<String> skinTypes = [
  "normál",
  "száraz",
  "zsíros",
  "vízhiányos",
  "érzékeny"
];

const List<String> brands = ["Geek & Gorgeous 101",
  "L'oreal Paris",
  "Vichy",
  "La Roche Posay",
  "The Ordinary"
];

const List<String> categories = [
  "lemosó",  "tisztító", "hámlasztó", "toner", "szérum", "maszk", "hidratáló", "fényvédő",
];

const List<String> effects = [
  "akné ellen", "anti-aging", "anti-stressz", "pirosság ellen", "feszesítő", "hámlasztó", "hidratáló",
  "mitesszerek ellen", "nyugtató", "pigmentfoltok ellen", "regeneráló", "revitalizáló",
  "sötét karikák ellen", "tápláló", "tisztító", "fényvédelem"
];

const List<String> ingredients = ["Water", "PEG-6 Caprylic/Capric Glycerides", "Propanediol", "Methyl Gluceth-20", "DISODIUM_TETRAMETHYLHEXADECENYLCYSTEINE_FORMYLPROLINATE", "Poloxamer 184",
  "Caprylic/Capric Triglyceride", "Hydroxyethyl Acrylate/Sodium Acryloyldimethyl Taurate Copolymer", "Ammonium Acryloyldimethyltaurate/VP Copolymer", "Panthenol", "Allantoin", "Xylitylglucoside",
  "Anhydroxylitol", "Xylitol", "Citric Acid", "Phenoxyethanol", "Ethylhexylglycerin", "Niacinamide", "Butylene Glycol", "Glycereth-26", "Zinc PCA", "Sarcosine",
  "Propanediol", " Pentylene Glycol", "Xanthan Gum"
];

const List<String> areas = [
  "szemkörnyék", "száj", "arc, a szemek és száj kivételével"
];

const blank = SizedBox(
height: 10,
);