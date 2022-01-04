import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:companies_alkhudra/Constant/conts.dart';
import 'package:companies_alkhudra/Constant/locale_keys.dart';
import 'package:companies_alkhudra/designs/ButtonsDesign.dart';
import 'package:companies_alkhudra/designs/brand_name.dart';
import 'package:companies_alkhudra/designs/card_design.dart';
import 'package:companies_alkhudra/designs/text_field_design.dart';
import 'package:companies_alkhudra/dialogs/alret_dialog.dart';
import 'package:companies_alkhudra/dialogs/message_dialog.dart';
import 'package:companies_alkhudra/dialogs/progress_dialog.dart';
import 'package:companies_alkhudra/helpers/info_correcter_helper.dart';
import 'package:companies_alkhudra/helpers/shared_pref_helper.dart';
import 'package:companies_alkhudra/network/API/api_response_type.dart';
import 'package:companies_alkhudra/network/models/login_response_model.dart';
import 'package:companies_alkhudra/network/models/string_response_model.dart';
import 'package:companies_alkhudra/network/repository/register_repository.dart';
import 'package:companies_alkhudra/pages/home_page.dart';
import 'package:companies_alkhudra/pages/reset_password/enter_code_page.dart';
import 'package:companies_alkhudra/pages/sign_up_page.dart';
import 'package:companies_alkhudra/resources/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:companies_alkhudra/router/route_constants.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'add_branches_page.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  bool isBtnEnabled = true;
  bool isForgetPassBtnEnabled = true;
  static bool isHasBranches = false;
  

  @override
  Widget build(BuildContext context) {

  Size? size = MediaQuery.of(context).size;
  double scWidth = size.width; 
  double scHeight = size.height;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        //todo:
        /********
         *
         * design problems:
         * height of card  , width of main column ,place of btn
         * *********/
        backgroundColor: CustomColors().backgroundColor,
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 120, left: 30, right: 30),
              width: MediaQuery.of(context).size.width / 0.3,
              height: MediaQuery.of(context).size.height / 1.8,
              decoration: CardDesign.largeCardDesign(),
            ),
            // SizedBox(
            //   height: 10,
            // ),
            brandNameMiddle(),
            // SizedBox(
            //   height: 10,
            // ),
            Container(
              margin: EdgeInsets.only(top: scHeight*0.13, right: scWidth*0.1, left: scWidth*0.1),
              // padding: EdgeInsets.symmetric(horizontal: scWidth/9, vertical: scHeight/5),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFieldDesign.textFieldStyle(
                    context: context,
                    verMarg: 5,
                    horMarg: 0,
                    controller: emailController,
                    kbType: TextInputType.emailAddress,
                    obscTxt: false,
                    lbTxt: LocaleKeys.email.tr(),
                  ),
                  SizedBox(height: 3,),
                  TextFieldDesign.textFieldStyle(
                    context: context,
                    verMarg: 5,
                    horMarg: 0,
                    controller: passController,
                    kbType: TextInputType.visiblePassword,
                    obscTxt: true,
                    lbTxt: LocaleKeys.password.tr(),
                  ),
                  SizedBox(
                    height: scHeight/20,
                  ),
                  Container(
                      height: scHeight/30,
                      padding: EdgeInsets.only(right: 10, left: 10),
                      child: GestureDetector(
                        onTap: () {
                          if (isForgetPassBtnEnabled)
                            showDialog(
                                builder: (BuildContext context) =>
                                    showEnterEmailDialog(context),
                                context: context);
                        },
                        child: Text(LocaleKeys.forget_pass.tr(),
                            style: TextStyle(
                                color: CustomColors().primaryGreenColor)),
                      )),
                  Container(
                      height: scHeight/33,
                      padding: EdgeInsets.only(right: 10, left: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SignUpPage();
                          }));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(LocaleKeys.new_user.tr(),
                                style:
                                    TextStyle(color: CustomColors().blackColor)),
                            Text(LocaleKeys.create_account.tr(),
                                style: TextStyle(
                                    color: CustomColors().primaryGreenColor))
                          ],
                        ),
                      )),
                  SizedBox(height: scHeight*0.05,),
                  Container(
                      height: ButtonsDesign.buttonsHeight,
                      margin: EdgeInsets.only(left: 50, right: 50),
                      child: MaterialButton(
                        onPressed: () {
                          if (isBtnEnabled) logIn();
                          // Navigator.push(context, MaterialPageRoute(
                          //   builder: (context) => HomePage()));
                        },
                        shape: StadiumBorder(),
                        child: ButtonsDesign.buttonsText(LocaleKeys.log_in.tr(),
                            CustomColors().primaryWhiteColor),
                        color: CustomColors().primaryGreenColor,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showErrorDialog(String txt) {
    isForgetPassBtnEnabled = true;
    isBtnEnabled = true;
    showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            showMessageDialog(context, LocaleKeys.error.tr(), txt, noPage));
  }

  ////---------------------------		
  void logIn() {		
    if (emailController.value.text == '') {		
      showErrorDialog(LocaleKeys.email_required.tr());		
      return;		
    }		
    if (isValidEmail(emailController.value.text) == false) {		
      showErrorDialog(LocaleKeys.email_not_valid.tr());		
      return;		
    }		
    if (passController.value.text == '') {		
      showErrorDialog(LocaleKeys.pass_required.tr());		
      return;		
    }		
    isBtnEnabled = false;		
    print('continue log in ');		
    //----------show progress----------------		
    showLoaderDialog(context);		
    //----------start api ----------------		
    RegisterRepository registerRepository = RegisterRepository();		
    registerRepository		
        .loginUser(emailController.text, passController.text)		
        .then((result) async {		
      //-------- fail response ---------		
      //todo: edit after adjustments		
      if (result == null || result.apiStatus.code != ApiResponseType.OK.code) {		
        /* if (result.apiStatus.code == ApiResponseType.BadRequest)*/		
        Navigator.pop(context);		
        showErrorDialog(result.message);		
        return;		
      }		
      //-------- success response ---------		
      LoginResponseModel model = result.result;		
      print(model.user.toString());		
      User user = model.user!;		
      // if(user != null) {		
      // print(model.user.get);		
      PreferencesHelper.setUserID(user.id!);		
      PreferencesHelper.getUserID.then((value) => print('user id : $value'));		
      PreferencesHelper.setUserToken(model.token);		
      PreferencesHelper.getUserToken.then((value) => print('token : $value'));		
      PreferencesHelper.setUser(user);		
      isHasBranches = user.branches!.isNotEmpty;		
      Navigator.pop(context);		
      directToHomePage();		
      //todo: check user status and show message if not registered		
    });		
  }		

////---------------------------

  Widget showEnterEmailDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: Container(
        height: CardDesign.cardsHeight,
        width: CardDesign.cardsWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              LocaleKeys.reset_password.tr(),
              style: TextStyle(
                fontSize: 20,
                color: CustomColors().darkBlueColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (!isValidEmail(controller.text)) {
                    return LocaleKeys.email_not_valid.tr();
                  }
                },
                controller: controller,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                    color: CustomColors().blackColor,
                    fontWeight: FontWeight.bold),
                decoration: textFieldDecorationWithIcon(
                    LocaleKeys.email.tr(), Icons.email),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Container(
                height: ButtonsDesign.buttonsHeight,
                margin: EdgeInsets.only(left: 50, right: 50),
                child: MaterialButton(
                  onPressed: () {
                    forgetPasswordProcess(controller.text);
                  },
                  shape: StadiumBorder(),
                  child: ButtonsDesign.buttonsText(
                      LocaleKeys.reset_password.tr(),
                      CustomColors().primaryWhiteColor),
                  color: CustomColors().primaryGreenColor,
                ))
          ],
        ),
      ),
    );
  }
////---------------------------

////---------------------------
  void directToHomePage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return HomePage(isHasBranch: isHasBranches);
    }));
  }

  ////---------------------------
  void forgetPasswordProcess(String userEmail) {
    if (userEmail != '') {
      isForgetPassBtnEnabled = false;

      print(userEmail);
      //----------show progress----------------

      showLoaderDialog(context);
      //----------start api ----------------
      RegisterRepository registerRepository = RegisterRepository();
      registerRepository.forgetPassword(userEmail).then((result) async {
        //-------- fail response ---------

        if (result == null ||
            result.apiStatus.code != ApiResponseType.OK.code) {
          /* if (result.apiStatus.code == ApiResponseType.BadRequest)*/
          Navigator.pop(context);
          showErrorDialog(result.message);
          return;
        }

        //-------- success response ---------

        Navigator.pop(context);
        Navigator.pop(context);

        Navigator.push(context, MaterialPageRoute(builder: (context) {
          isForgetPassBtnEnabled = true;
          return EnterCodePage(
            userEmail: userEmail,
          );
        }));
      });

      //    Navigator.pop(context, controller.text);
      //---------------
      /*     showDialog(
          builder: (BuildContext context ) =>
              showPinDialog(context ,userEmail,false),
          context: context).then((newPass) {
        if(newPass == success)
        {

        }
      });*/
      } 
    }
  }
