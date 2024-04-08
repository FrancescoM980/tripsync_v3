import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tripsync_v3/ui/common_widget/main_button.dart';
import 'package:tripsync_v3/ui/screen/home/homepage.dart';
import 'package:tripsync_v3/utils.dart';

class StepTutorialWizard extends StatefulWidget {
  const StepTutorialWizard({super.key});

  @override
  _StepTutorialWizardState createState() => _StepTutorialWizardState();
}

class _StepTutorialWizardState extends State<StepTutorialWizard> {
  final PageController _pageController = PageController();
  double currentPage = 0; 

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: [
                buildTutorialPage(
                  imageName: 'assets/images/step1.png',
                  title: 'Benvenuto in TripSync!',
                  startDescription: "TripSync rende l'organizzazione dei viaggi di gruppo ",
                  focusedDescription: "semplice e divertente",
                  endDescription: ".\n\nPreparati ad esplorare il mondo come mai prima d'ora!",
                ),
                buildTutorialPage(
                  imageName: 'assets/images/step2.png',
                  title: 'Trova il momento perfetto per tutti',
                  startDescription: "Addio alle lunghe catene di messaggi per scegliere una data.\n\nScegliete insieme ",
                  focusedDescription: "il periodo migliore",
                  endDescription: " per il viaggio grazie al calendario condiviso",
                ),
                buildTutorialPage(
                  imageName: 'assets/images/step3.png',
                  title: 'Gestisci il budget di gruppo',
                  startDescription: "Tenere ",
                  focusedDescription: "traccia delle spese ",
                  endDescription: "e assicurarsi che tutti contribuiscano equamente è un gioco da ragazzi.\n\nGoditi il viaggio, non la matematica!",
                ),
                buildTutorialPage(
                  imageName: 'assets/images/step4.png',
                  title: 'Destinazioni che entusiasmano tutti!',
                  startDescription: "Proponi e vota le destinazioni di viaggio con il tuo gruppo.\n\nTrova ",
                  focusedDescription: "il luogo perfetto ",
                  endDescription: "per la vostra avventura.",
                ),
                // Aggiungi altre pagine qui
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
            child: currentPage == 2.0
              ? MainButton(
                  onTap: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setBool('has_tutorial', true);
                    Get.off(HomePageScreen());
                    // Aggiungi la logica per saltare il tutorial
                  }, 
                  titleText: 'ENTRA E VIAGGIA'
                )
              : Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: Text('SKIP'),
                  onTap: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setBool('has_tutorial', true);
                    Get.off(HomePageScreen());
                    // Aggiungi la logica per saltare il tutorial
                  },
                ),
                InkWell(
                  child: Card(
                    elevation: 5,
                    color: TripUtils.arancione,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                      child: Text(
                        'Avanti >',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        )
                      ),
                    )
                  ),
                  onTap: () {
                    setState(() {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                        currentPage = _pageController.page ?? 0;
                        print(currentPage);
                    });
                    
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildTutorialPage({
    required String imageName, 
    required String title, 
    required String startDescription,
    required String focusedDescription,
    required String endDescription,
  }) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 100),
          Container(
            height: MediaQuery.of(context).size.height/3,
            child: Image.asset(imageName)
          ),
          SizedBox(height: 25),
          Text(
            title,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 25),
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: Theme.of(context).primaryColor
              ),
              children: <TextSpan>[
                TextSpan(
                  text: startDescription,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                TextSpan(
                  text: focusedDescription,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: TripUtils.arancione,
                  ),
                ),
                TextSpan(
                  text: endDescription,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          )

          //Text(
          //  description,
          //  style: TextStyle(
          //    fontSize: 16,
          //    fontWeight: FontWeight.w300,
          //    color: TripUtils.grigioScuro,
          //  ),
          //  textAlign: TextAlign.center,
          //),
        ],
      ),
    );
  }
}
