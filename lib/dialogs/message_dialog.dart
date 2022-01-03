
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:companies_alkhudra/Constant/locale_keys.dart';
import 'package:companies_alkhudra/pages/login_page.dart';
import 'package:companies_alkhudra/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:companies_alkhudra/router/route_constants.dart';

Widget showMessageDialog(BuildContext context, String title, String txt,String pageRout) {
  if (Platform.isIOS) {
    return CupertinoAlertDialog(
      title: Text(title), // To display the title it is optional
      content: Text(txt), // Message which will be pop up on the screen
      actions: [
        if(pageRout == loginRoute)
          directToLoginPageBtns(context)
        else
        messageDialogBtns(context ),
      ],
    );
  } else {
    return AlertDialog(
      title: Text(title), // To display the title it is optional
      content: Text(txt), // Message which will be pop up on the screen
      actions: [
        if(pageRout == loginRoute)
          directToLoginPageBtns(context)
        else
          messageDialogBtns(context ),
      ],
    );
  }
}

TextButton messageDialogBtns(BuildContext context) {
  return TextButton(
    style: TextButton.styleFrom(
      // backgroundColor: CustomColors().backgroundColor,
    ),
    onPressed: () {
      Navigator.pop(context);
      },
    child: Text(
      LocaleKeys.ok.tr(),
      style: TextStyle(fontWeight: FontWeight.bold, color: CustomColors().primaryGreenColor),
    ),
  );
}


TextButton directToLoginPageBtns(BuildContext context) {

  return TextButton(
    style: TextButton.styleFrom(backgroundColor: CustomColors().primaryGreenColor,),
    onPressed: () {
      Navigator.pop(context);
      Navigator.push(context,

          MaterialPageRoute(builder: (context) {
            return LogInPage();
          }));
    },
    child: Text(
      LocaleKeys.ok.tr(),
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}