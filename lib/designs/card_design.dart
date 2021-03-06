import 'package:flutter/cupertino.dart';
import 'package:companies_alkhudra/resources/custom_colors.dart';

class CardDesign {
  static const double cardsHeight = 350;
  static const double cardsWidth = 400;

  static BoxDecoration largeCardDesign() {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
            color: CustomColors().cardShadowBackgroundColor,
            offset: Offset(0.2, 6.0),
            blurRadius: 6.0,
            spreadRadius: -2.0),
      ],
      borderRadius: BorderRadius.circular(50),
      color: CustomColors().cardBackgroundColor1,
      border: Border.all(color: CustomColors().cardBackgroundColor),
    );
  }
}