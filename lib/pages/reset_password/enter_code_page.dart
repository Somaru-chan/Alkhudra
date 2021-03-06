import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:companies_alkhudra/Constant/locale_keys.dart';
import 'package:companies_alkhudra/designs/ButtonsDesign.dart';
import 'package:companies_alkhudra/designs/text_field_design.dart';
import 'package:companies_alkhudra/dialogs/message_dialog.dart';
import 'package:companies_alkhudra/dialogs/progress_dialog.dart';
import 'package:companies_alkhudra/helpers/shared_pref_helper.dart';
import 'package:companies_alkhudra/network/API/api_response_type.dart';
import 'package:companies_alkhudra/network/repository/register_repository.dart';
import 'package:companies_alkhudra/pages/reset_password/reset_password_page.dart';
import 'package:companies_alkhudra/resources/custom_colors.dart';
import 'package:companies_alkhudra/router/route_constants.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:easy_localization/easy_localization.dart';

class EnterCodePage extends StatefulWidget {
  final String userEmail;
  const EnterCodePage({Key? key, required this.userEmail}) : super(key: key);

  @override
  _EnterCodePageState createState() => _EnterCodePageState();
}

class _EnterCodePageState extends State<EnterCodePage> {
  int numberOfSecToWait = 120;
  String code = '1234'; //'get this code from DB here ';
  final TextEditingController controller = TextEditingController();
  late StreamController<int> _events;

  bool isBtnEnabled = true;
  bool isResendEnabled = true;

  String language = 'ar';
  @override
  void initState() {
    super.initState();
    _events = new StreamController<int>();
    PreferencesHelper.getSelectedLanguage.then((value) => language = value);

    numberOfSecToWait = 120;
    _events.add(numberOfSecToWait);

    startTimer(numberOfSecToWait, _events);
  }

  @override
  Widget build(BuildContext context) {
    String email = widget.userEmail;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors().primaryGreenColor,
        title: Text(LocaleKeys.reset_password.tr()),
      ),
      body: StreamBuilder<int>(
        stream: _events.stream,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          return Container(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    LocaleKeys.enter_code_note.tr() + '\n' + email,
                    style: TextStyle(
                      locale: Locale(language),
                      fontSize: 15,
                      color: CustomColors().primaryGreenColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: TextFieldDesign.textFieldStyle(
                    context: context,
                    verMarg: 5,
                    horMarg: 0,
                    controller: controller,
                    kbType: TextInputType.text,
                    lbTxt: LocaleKeys.enter_code.tr(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: ButtonsDesign.buttonsHeight,
                    margin: EdgeInsets.only(left: 50, right: 50, bottom: 20),
                    child: MaterialButton(
                      onPressed: () {
                        if (isBtnEnabled) sendCodeToDB(email);
                      },
                      shape: StadiumBorder(),
                      child: ButtonsDesign.buttonsText(
                          LocaleKeys.continue_btn.tr(),
                          CustomColors().primaryWhiteColor),
                      color: CustomColors().primaryGreenColor,
                    )),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 30,
                  padding: EdgeInsets.only(right: 10, left: 10),
                  child: Text(
                    LocaleKeys.resend_code_note.tr() + '\n',
                    style: TextStyle(
                        color: CustomColors().primaryGreenColor,
                        fontSize: 15.0),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 30,
                  padding: EdgeInsets.only(right: 10, left: 10),
                  child: GestureDetector(
                    onTap: () {
                      //you can tap if only finish timer
                      if (snapshot.data.toString() == '0') {
                        setState(() {
                          controller.text ='';
                          _events.add(numberOfSecToWait);
                          startTimer(numberOfSecToWait, _events);
                          resendCode(email);
                          print(snapshot.data.toString());
                        });

                      }
                    },
                    child: Text(
                      (snapshot.data.toString() != '0')
                          ? snapshot.data.toString()
                          : LocaleKeys.resend_code.tr(),
                      style: TextStyle(
                          color: CustomColors().primaryGreenColor,
                          fontSize: 15.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void startTimer(int _counter, StreamController<int> _events) {
    Timer.periodic(Duration(seconds: 1), (timer) {
      //setState(() {
      (_counter > 0) ? _counter-- : timer.cancel();
      //});
      print(_counter);
      _events.add(_counter);
    });
  }

  //-------------------

  void sendCodeToDB(String userEmail) {
    if (controller.text == '') {
      showErrorDialog(LocaleKeys.enter_code_note.tr());
      return;
    }

    isBtnEnabled = false;

    showLoaderDialog(context);
    print(userEmail + " " + controller.text);
    //----------start api ----------------
    RegisterRepository registerRepository = RegisterRepository();
    registerRepository
        .sendPasswordToken(userEmail, controller.text)
        .then((result) async {
      //-------- fail response ---------

      if (result == null || result.apiStatus.code != ApiResponseType.OK.code) {
        /* if (result.apiStatus.code == ApiResponseType.BadRequest)*/
        Navigator.pop(context);
        showErrorDialog(result.apiStatus.message);
        return;
      }

      //-------- success response ---------

      Navigator.pop(context);

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        Map<String, String> dataMap = {
          "email": userEmail,
          "token": controller.text
        };
        return ResetPasswordPage(dataMap: dataMap);
      }));
    });
  }

  //-------------------
  void resendCode(String userEmail) {
    isResendEnabled = false;
    showLoaderDialog(context);

    //-------- success response ---------

    //----------start api ----------------
    RegisterRepository registerRepository = RegisterRepository();
    registerRepository.forgetPassword(userEmail).then((result) async {
      //-------- fail response ---------

      if (result == null || result.apiStatus.code != ApiResponseType.OK.code) {
        /* if (result.apiStatus.code == ApiResponseType.BadRequest)*/
        Navigator.pop(context);
        showErrorDialog(result.message);
        return;
      }
      Navigator.pop(context);
    });

    //  initState();
  }

  //-------------------
  void showErrorDialog(String txt) {
    isBtnEnabled = true;
    isResendEnabled = true;
    showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            showMessageDialog(context, LocaleKeys.error.tr(), txt, noPage));
  }
}