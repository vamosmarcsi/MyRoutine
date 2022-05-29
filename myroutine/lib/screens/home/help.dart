import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myroutine/screens/home/side_menu.dart';
import 'package:myroutine/services/constants.dart';

class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: myPrimaryLightColor,
      drawer: const SideMenu(),
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
          width: double.infinity,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: Column(
              children: [
                Text(
                  "Kalauz",
                  style: GoogleFonts.comforter(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.white),
                ),
                blank,
                Text("Mit tehetsz általánosságban a szép bőrért?",
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                blank,
                Text(
                    "Ne dohányozz!\nKerüld az alkoholfogyasztást!\nNe szoláriumozz!\nAludj eleget!\nNe csak az arcod ápold! Ne felejtsd el a nyakat és a dekoltázst sem!\nTáplálkozz egészségesen!\nIgyál megfelelő mennyiségű vizet!\nNe stresszelj sokat!",
                    style: TextStyle(color: Colors.white)),
                blank,
                Text(
                    "A tudatos bőrápolás azt jelenti, hogy tudatosan használod a termékeket, pontosan tudod, hogy mit tartalmaz és mit, mikor, miért használsz. Ismered a bőrödet, a bőrtípusodat, a bőrproblémá(i)dat. Ebből kifolyólag a tudatos bőrápolás nem a vásárlással kezdődik, hanem a tájékozódással. Ehhez szeretnénk most segítséget nyújtani neked.\n",
                    style: TextStyle(color: Colors.white)),
                Text("BŐRTÍPUS MEGÁLLAPÍTÁSA\n", style: TextStyle(color: Colors.white)),
                Text(
                    "A megfelelő termékek kiválasztásához elengedhetetlen a bőrtípusod megismerése. Ha még nem tudod, milyen a bőrtípusod, így állapíthatod meg:\n"
                    "1. Tisztítsd meg a bőrödet!\n"
                    "2. Várj kb 2 órát, ezalatt ne használj semmit az arcodon!\n"
                    "3. Vizsgáld meg, tapogasd meg a bőrödet. Mit érzel?\n"
                    "- NORMÁL: se nem száraz, se nem zsíros. A pórusok mérete normális, a bőr felszín kellemes tapintású. \n"
                    "- ZSÍROS: bőröd csillog, zsíros érzetű, a pórusok tágak. Jellemző a pattanás, mitesszer megjelenése. Az átlagosnál több faggyú termelődik. \n"
                    "- SZÁRAZ: bőröd feszül, húzódik, esetleg érdes tapintású. Az átlagosnál kevesebb faggyú termelődik. Hajlamosít az érzékenységre, mert a bőr barrierje gyenge. \n"
                    "- KOMBINÁLT: a bőröd a T-vonalban zsírosabb, az arc többi részén viszont normál, esetleg száraz.\n",
                    style: TextStyle(color: Colors.white)),
                Text("TISZTÍTÁS\n", style: TextStyle(color: Colors.white)),
                Text(
                    "A tudatos bőrápolás egyik alappillére a tisztítás. Itt kezdődik minden. Kivétel nélkül minden este mosd le az arcod. Hogy miért nem elég vízzel lemosni az arcot? Azért, mert az nem fogja eltávolítani sem a szennyeződéseket, sem a sminket, sem pedig a fényvédőt."
                    "Ha sminkelsz vagy fényvédőt használsz, akkor az első ezek eltávolítása: vagy egy olajos lemosóval kezdj, vagy pedig micellás vízzel. Ezeket a termékeket viszont le kell mosni! Ezért szükséged lesz egy másik lemosóra is, ami kíméletesen tisztítja a bőrt és lemossa az előző lemosás maradványait."
                    "A habzó lemosókat (amiben SLS és SLES van) és a szappanos lemosást igyekezzünk elkerülni, mint ahogy az alkoholt és a parfümöt is. Ezek eltávolítják a bőrödről a savköpenyt, és lúgosabbá válik. A lúgos bőr pedig tökéletes táptalaja a baktériumoknak."
                    "Hányszor kell arcot tisztítani? Este mindenképp! Azt viszont fontos tudni, hogy ezek a lemosók nem csak a rossz dolgokat távolítják el a bőrödről, hanem mindent! Azt is, aminek ott lenne a helye (pl lipidek). Ezért akármennyire jó a termék, kicsit szárítani és roncsolni is fog, emiatt nem érdemes túltisztítani sem! Reggel sok esetben elég, ha langyos vízzel leöblíted az arcod, aztán egy törölközővel felitatod, óvatosan rányomkodva azt. Minden nap használj új törölközőt! Persze ha az éjszakai rutinból azt látod, hogy maradt valami az arcodon, azt mosd le lemosóval reggel (a dupla lemosásnál használt második termékkel).\n",
                    style: TextStyle(color: Colors.white)),
                Text("HÁMLASZTÁS\n", style: TextStyle(color: Colors.white)),
                Text(
                    "A hámlasztás a bőr regenerációs és megújulási folyamatainak aktivizálási módszere. Kb. 4 hét alatt a bőr felső rétege egyébként is megújul, a kor előrehaladtával azonban ez a folyamat is egyre lassabban megy végbe, a kémiai hámlasztók ezt a természetes folyamatot tudják segíteni, gyorsítani. A tudatos bőrápoláshoz hozzátartozik a hámlasztás, mondhatni alap.\n"
                    "Mire jó a hámlasztás?\n"
                    "Eltávolítja az elhalt sejteket, megújítja a bőrt, apró hibákat megszünteti (hegek, foltok) és a bőrt egyenletessé teszi. Gyors és jól látható eredményt érhetünk el vele.\n",
                    style: TextStyle(color: Colors.white)),
                Text("FÉNYVÉDELEM\n", style: TextStyle(color: Colors.white)),
                Text(
                    "A tudatos bőrápolás a mindennapi fényvédelemnél kezdődik. A barnulást okozó UVB kevesebb télen, mint mikor hétágra süt a nap, de a legalább annyira káros UVA télen-nyáron ugyanúgy jelen van. A káros UV sugarak felelnek a ráncok és pigmentfoltok mintegy 80%-áért. A súlyos egészségügyi kockázatról nem beszélve (bőrrák). Sajnos a káros UVA-sugarak (ezek azok a sugarak, amik a bőröregedést okozzák) ugyanúgy érik a bőrödet az ablaküvegen keresztül is, az üveg ugyanis csak az UVB-sugarakat, vagyis a leégésért felelős sugarakat tudja kiszűrni.\n",
                    style: TextStyle(color: Colors.white)),
                Text(
                    "A különböző hatóanyagok kombinálása során jó, ha tudjuk, hogy melyek azok, amiket hasznos együtt alkalmazni, és melyek azok, amiket nem érdemes egy rutinban használni, mert vagy 'kiütik' egymás hatását, vagy irritálhatják a bőrünket.\n",
                    style: TextStyle(color: Colors.white)),
                Text(
                    "A Skinsmart készített egy jó kis infografikát, ezt láthatjátok az alábbi képen:\n",
                    style: TextStyle(color: Colors.white)),
                Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 2,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('assets/images/kisokos.jpg'),
                        fit: BoxFit.contain,
                      )),
                    ),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/images/hatoanyagok.jpg'),
                    fit: BoxFit.contain,
                  )),
                ),
                Text(
                    "Források:\n- Facebook: Tudatos bőrápolók klubja\n- SkinSmart",
                    style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
