import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/bloc/informaton_user_order_bloc.dart';
import 'package:project_flutter/bloc/provider/sign_up_provider.dart';
import 'package:project_flutter/pages/informaton_user_order_page/model/province_model.dart';
import 'package:project_flutter/pages/sign_up_page/model/sign_in_request_api_model.dart';
import 'package:project_flutter/utils/base_bloc.dart';
import 'package:project_flutter/utils/base_model_api.dart';
import 'package:project_flutter/utils/colors_util.dart';
import 'package:project_flutter/utils/convert_color_util.dart';
import 'package:project_flutter/utils/custom_dialog.dart';
import 'package:project_flutter/utils/url_util.dart';
import 'package:project_flutter/utils/words_util.dart';
import 'package:rxdart/rxdart.dart';

class SignUpBloc extends InformationUserOrderBloc {
  requestSignInApiBloc({required BuildContext context,
    required SignInRequestApiModel model}) async {
    setIsLoadingUtil(isLoading: true);

    BaseModelApi? response = await SignUpProvider().signInApiProvider(url: UrlUtil.signUp,
        body: model.toJson());

    switch(response!.statusCode){
      case UrlUtil.statusSuccess:
        print(response.body);
        setIsLoadingUtil(isLoading: false);
        Navigator.pop(context);

        await CustomDialog().dialogNotification(
            context: context,
            title: WordsUtil.successSignUp,
            description: WordsUtil.thankYou,
            buttonTitle: WordsUtil.exit,
            listColors: [
              ColorsUtil.colorYellowDialog,
              ColorsUtil.colorYellowDialog,
            ],
            backgroundButton: ConvertColorUtil(ColorsUtil.colorApp),
            function: (BuildContext contextDialog) {
              Navigator.pop(contextDialog);
            });
        break;
      default:
        setIsLoadingUtil(isLoading: false);
       CustomDialog().dialogNotification(
          context: context,
          title: WordsUtil.someError,
          description: WordsUtil.checkAgain,
          buttonTitle: WordsUtil.exit,
          listColors: [
            ColorsUtil.colorOnTopRed,
            ColorsUtil.colorDownBottomRed,
          ],
          backgroundButton: Colors.red[ColorsUtil.colorRed],
          function: (BuildContext contextDialog) {
            Navigator.pop(contextDialog);
          });
        break;

    }

  }

}