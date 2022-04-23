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


//TODO a címet megcsinálni const textstyle

const List<String> brands = ["Geek & Gorgeous 101",
  "L'oreal Paris",
  "Vichy",
  "La Roche Posay"];

const List<String> categories = [
  "nappali", "éjszakai", "szérum", "maszk", "tisztító", "hámlasztó"
];

const List<String> effects = [
  "akné ellen", "anti-aging", "anti-stressz", "pirosság ellen", "feszesítő", "hámlasztó", "hidratáló",
  "mitesszerek ellen", "nyugtató", "pigmentfoltok ellen", "regeneráló", "revitalizáló",
  "sötét karikák ellen", "tápláló", "tisztító", "fényvédelem"
];

const List<String> ingredients = ["DISODIUM_TETRAMETHYLHEXADECENYLCYSTEINE_FORMYLPROLINATE"]; //TODO kiegészíteni

const List<String> areas = [
  "szemkörnyék", "száj", "arc, a szemek és száj kivételével"
];