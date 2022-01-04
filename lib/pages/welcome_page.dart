import 'package:flutter/material.dart';
import 'package:companies_alkhudra/Constant/locale_keys.dart';
import 'package:companies_alkhudra/designs/ButtonsDesign.dart';
import 'package:companies_alkhudra/designs/brand_name.dart';
import 'package:companies_alkhudra/pages/sign_up_page.dart';
import 'package:companies_alkhudra/resources/custom_colors.dart';
import 'package:companies_alkhudra/router/route_constants.dart';
import 'package:easy_localization/easy_localization.dart';

import 'login_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({ Key? key }) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
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
                  onButtonPressed(signupRoute);
                },
                height: ButtonsDesign.buttonsHeight,
                shape: StadiumBorder(),
                child: ButtonsDesign.buttonsText(LocaleKeys.create_account.tr(),CustomColors().primaryWhiteColor),
                color: CustomColors().primaryGreenColor,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: scWidth*0.12, right: scWidth*0.12),
              child: MaterialButton(
                onPressed: () {
                  onButtonPressed(loginRoute);
                },
                height: ButtonsDesign.buttonsHeight,
                shape: StadiumBorder(),
                child: ButtonsDesign.buttonsText(LocaleKeys.log_in.tr() , CustomColors().blackColor),
                color: CustomColors().grayColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onButtonPressed(String s) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      if (s == loginRoute)
        return LogInPage();
      else
        return SignUpPage();
    }));
  }
}