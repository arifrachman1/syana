import 'package:flutter/material.dart';
import 'package:syana/Controller/LoginController.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/ScreenSizeHelper.dart';
import 'package:syana/utils/Strings.dart';
import 'package:syana/widgets/CustomButton.dart';
import 'package:syana/widgets/CustomDialog.dart';
import 'package:syana/widgets/CustomTextInput.dart';

class Login extends StatefulWidget {
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  TextEditingController usernameController = new TextEditingController(),
      passwordController = new TextEditingController();
  LoginController _loginController;
  bool isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginController = new LoginController();
  }

  void setLoadingState() {
    setState(() {
      isLoading = isLoading ? isLoading = false : isLoading = true;
    });
  }

  void login() {
    print('login');
    if (usernameController.text != "" && passwordController.text != "") {
      _loginController.login(context, setLoadingState, usernameController.text,
          passwordController.text);
    } else {
      CustomDialog.getDialog(
          title: Strings.DIALOG_TITLE_WARNING,
          message: Strings.DIALOG_MESSAGE_INSUFFICENT_CREDENTIALS,
          context: context,
          popCount: 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: ScreenSizeHelper.getDisplayWidth(context),
      height: ScreenSizeHelper.getDisplayHeight(
          context: context, which: ScreenSizeHelper.HEIGHT_WITH_STATUS_BAR),
      decoration: AppTheme.appBackground(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: LayoutBuilder(builder: (_, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: CustomTextInput.getCustomTextField(
                        widthFactor: 0.7,
                        context: context,
                        controller: usernameController,
                        hint: "Username"),
                  ),
                  CustomTextInput.getCustomTextField(
                      widthFactor: 0.7,
                      context: context,
                      controller: passwordController,
                      hint: "Password",
                      isPasswordField: true),
                  CustomButton.getCustomButton(
                      context: context,
                      callbackFunction: login,
                      buttonText: "Login")
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
