import 'package:flutter/material.dart';
import 'package:project_flutter/utils/base_components.dart';
import 'package:project_flutter/utils/colors_util.dart';
import 'package:project_flutter/utils/size_util.dart';
import 'package:project_flutter/utils/words_util.dart';

class SignUpComponents extends BaseComponents{
  bool validateEmail(String value) {
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
    return emailValid;
  }

  Widget textFromFieldSignUp(
      {required TextEditingController controller,
        double paddingSize = SizeUtil.padding8,
        required String hintText,
        required String title,
        bool isObscureText = false,
        bool isRequired = true,
        Color focusedBorderColor = ColorsUtil.blackColorBtn,
        Color enabledBorderColor = ColorsUtil.blackColorBtn,
        required TextInputAction textInputAction,
        IconButton ?iconButtonSuffixIcon,
        required BuildContext context,
        required Function onPressHandle,
        Function(String) ?validate}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SizeUtil.padding8),
      child: InkWell(
        onTap: (){
          onPressHandle();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('$title', style: TextStyle(fontWeight: FontWeight.bold),),
                Text( isRequired == true ? " *" : "" , style: TextStyle( color: Colors.red),)
              ],
            ),
            SizedBox(
              height: SizeUtil.padding8,
            ),
            AbsorbPointer(
              absorbing: true,
              child: TextFormField(
                controller: controller,
                // readOnly: true,
                textInputAction: textInputAction,
                obscureText: isObscureText,
                decoration: new InputDecoration(
                  suffixIcon: iconButtonSuffixIcon != null ? iconButtonSuffixIcon: null,

                  hintText: '$hintText',
                  contentPadding: EdgeInsets.only(left: SizeUtil.padding16),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: ColorsUtil.grayColor, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(color: ColorsUtil.grayColor, width: 1.0),
                  ),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.red)),
                ),
                onSaved: (value) async {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
                validator: ( value) {
                  return validate!(value!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);

    if(value.trim() != ''){
      if (value.length == 0) {
        return '${WordsUtil.validateInputPhoneNumber}';
      }
      else if (!regExp.hasMatch(value)) {
        return '${WordsUtil.wrongFormatPhoneNumber}';
      }
      return null;
    }else{
      return '${WordsUtil.validateInputPhoneNumber}';
    }

  }

}