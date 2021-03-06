import 'package:companies_alkhudra/Constant/locale_keys.dart';
import 'package:companies_alkhudra/designs/drawer_design.dart';
import 'package:companies_alkhudra/designs/text_field_design.dart';
import 'package:companies_alkhudra/resources/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

Widget searchBar(context, seController) {
  return Container(
    width: MediaQuery.of(context).size.width,
    child: Row(
      // mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SizedBox(width: 10,),

        Container(
          child: IconButton(
            icon: Icon(Icons.menu_rounded,),
            color: CustomColors().brownColor,
            iconSize: 28,
            onPressed: () {
              
            },
          ),
        ),

        // SizedBox(width: 5,),
        Container(
          margin: EdgeInsets.only(left: 5, right: 5),
          width: MediaQuery.of(context).size.width/1.4,
          child: TextFieldDesign.textFieldStyle(
            context: context,
            verMarg: 2,
            horMarg: 0, 
            controller: seController, 
            kbType: TextInputType.text,
            lbTxt: LocaleKeys.search_term.tr(),
            obscTxt: false,
          ),
        ),
        SizedBox(width: 5,),
        GestureDetector(
          child: Container(
            padding: EdgeInsets.all(8.0),
            width: MediaQuery.of(context).size.width*0.08,
            height: MediaQuery.of(context).size.height*0.04,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/logo.png'),
              ),
            ),
          ),
          onTap: () {},
        ),
      ],
    ),
  );
}