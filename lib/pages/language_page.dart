import 'package:flutter/material.dart';
import 'package:companies_alkhudra/designs/ButtonsDesign.dart';
import 'package:companies_alkhudra/designs/brand_name.dart';
import 'package:companies_alkhudra/helpers/shared_pref_helper.dart';
import 'package:companies_alkhudra/pages/welcome_page.dart';
import 'package:companies_alkhudra/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguagePage extends StatefulWidget {
  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {


  void onLanguageButtonPressed(BuildContext context , String localeName) async{


    if(localeName == 'en')
      await context.setLocale(Locale('en'));
    else   await context.setLocale(Locale('ar'));

    PreferencesHelper.setSelectedLanguage(localeName);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WelcomePage();
    }));
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors().backgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: brandName(250.0, 250.0, 30.0),
            ),
            SizedBox(
              height: 60,
            ),
            Container(
              margin: EdgeInsets.only(left: scWidth*0.12, right: scWidth*0.12),
              child: MaterialButton(
                onPressed: () {
                  onLanguageButtonPressed(context,'ar');
                },
                height: ButtonsDesign.buttonsHeight,
                shape: StadiumBorder(),
                child: ButtonsDesign.buttonsText('عربي',CustomColors().primaryWhiteColor),
                color: CustomColors().brownColor,
              ),
            ),
            SizedBox(
              height: scHeight*0.03,
            ),
            Container(
              margin: EdgeInsets.only(left: scWidth*0.12, right: scWidth*0.12),
              child: MaterialButton(
                onPressed: () {
                  onLanguageButtonPressed(context,'en');
                },
                height: ButtonsDesign.buttonsHeight,
                shape: StadiumBorder(),
                child: ButtonsDesign.buttonsText('english',CustomColors().primaryWhiteColor),
                color: CustomColors().primaryGreenColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}