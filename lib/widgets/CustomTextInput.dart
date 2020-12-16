import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:syana/models/CustomerModel.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/Dimens.dart';
import 'package:syana/utils/ScreenSizeHelper.dart';

class CustomTextInput {
  static Widget getCustomTextField(
      {@required context,
      @required controller,
      widthFactor,
      heightFactor,
      hint,
      textInputType,
      isPasswordField,
      key, icon, enabled}) {
    return Container(
      width: ScreenSizeHelper.getDisplayWidth(context) * (widthFactor ?? 1),
      height: Dimens.formHeight,
      margin: EdgeInsets.only(top: 25),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: AppTheme.inputDecoration(),
      child: TextField(
        key: key ?? null,
        controller: controller,
        keyboardType: textInputType ?? TextInputType.text,
        obscureText: isPasswordField ?? false,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 10.0),
            border: InputBorder.none,
            hintText: hint ?? "Text",
        icon: icon ?? null,
        enabled: enabled ?? true),
      ),
    );
  }

  static Widget getCustomAutoCompleteField(
      {@required context,
      @required controller,
      widthFactor,
      heightFactor,
      hint,
      textInputType,
      itemBuilderCallback,
      suggestionCallback,
      onSuggestionSelectedCallback}) {
    return Container(
      width: ScreenSizeHelper.getDisplayWidth(context) * (widthFactor ?? 1),
      height: 56,
      margin: EdgeInsets.only(top: 25),
      decoration: AppTheme.inputDecoration(),
      child: TypeAheadField(
          textFieldConfiguration: TextFieldConfiguration(
            controller: controller,
            keyboardType: textInputType,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10.0),
                border: InputBorder.none,
                hintText: hint ?? "Text"),
          ),
          suggestionsCallback: suggestionCallback,
          onSuggestionSelected: onSuggestionSelectedCallback,
          itemBuilder: itemBuilderCallback),
    );
  }

  static Widget getAutoCompleteFieldPurchasing(
      {@required context,
        @required controller,
        widthFactor,
        heightFactor,
        hint,
        textInputType,
        itemBuilderCallback,
        suggestionCallback,
        onSuggestionSelectedCallback}) {
    return Container(
      width: ScreenSizeHelper.getDisplayWidth(context) * (widthFactor ?? 1),
      height: 56,
      decoration: AppTheme.inputDecoration(),
      child: TypeAheadField(
          autoFlipDirection: true,
          textFieldConfiguration: TextFieldConfiguration(
            controller: controller,
            keyboardType: textInputType,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10.0),
                border: InputBorder.none,
                hintText: hint ?? "Text"),
          ),
          suggestionsCallback: suggestionCallback,
          onSuggestionSelected: onSuggestionSelectedCallback,
          itemBuilder: itemBuilderCallback),
    );
  }

  static Widget row(CustomerModel customer) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          customer.phoneNumber,
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(
          customer.fullName,
        ),
      ],
    );
  }
}
