import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syana/Controller/ProfileController.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/Strings.dart';
import 'package:syana/widgets/CustomButton.dart';
import 'package:syana/widgets/CustomDialog.dart';
import 'package:syana/widgets/CustomTextInput.dart';

class SyanaChangePassword extends StatefulWidget {
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<SyanaChangePassword> {
  TextEditingController _oldPasswordController = new TextEditingController(),
      _newPasswordController = new TextEditingController(),
      _confirmationController = new TextEditingController();

  ProfileController _profileController;

  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _profileController = new ProfileController();
  }

  changePassword() async {
    if (_oldPasswordController.text.isNotEmpty ||
        _newPasswordController.text.isNotEmpty ||
        _confirmationController.text.isNotEmpty) {
      _profileController.changePassword(context, setLoadingState,
          _oldPasswordController.text, _newPasswordController.text);
    } else {
      CustomDialog.getDialog(
          title: Strings.DIALOG_TITLE_WARNING,
          message: Strings.DIALOG_MESSAGE_INSUFFICENT_INPUT,
          context: context,
          popCount: 1);
    }
  }

  void setLoadingState() {
    setState(() {
      _isLoading = _isLoading ? _isLoading = false : _isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: AppTheme.appBackground(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: CustomTextInput.getCustomTextField(
                    context: context,
                    controller: _oldPasswordController,
                    hint: "Password Lama",
                    textInputType: TextInputType.text,
                    isPasswordField: true),
              ),
              Container(
                child: CustomTextInput.getCustomTextField(
                    context: context,
                    controller: _newPasswordController,
                    hint: "Password Baru",
                    textInputType: TextInputType.text,
                    isPasswordField: true),
              ),
              Container(
                child: CustomTextInput.getCustomTextField(
                    context: context,
                    controller: _confirmationController,
                    hint: "Konfirmasi Password Baru",
                    textInputType: TextInputType.text,
                    isPasswordField: true),
              ),
              Container(
                child: CustomButton.getCustomButton(
                    context: context,
                    callbackFunction: changePassword,
                    buttonText: "Simpan"),
              )
            ],
          ),
        ));
  }
}
