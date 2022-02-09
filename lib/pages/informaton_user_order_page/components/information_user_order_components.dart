import 'package:flutter/material.dart';
import 'package:project_flutter/utils/base_components.dart';
import 'package:project_flutter/utils/colors_util.dart';
import 'package:project_flutter/utils/size_util.dart';

class InformationUserOrderComponents extends BaseComponents{
  Widget textFromFieldAddress(
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
}