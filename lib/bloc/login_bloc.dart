import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_flutter/bloc/home_bloc.dart';
import 'package:project_flutter/bloc/provider/login_in_provider.dart';
import 'package:project_flutter/pages/cart_page/cart_page.dart';
import 'package:project_flutter/pages/login_page/model/get_user_response_api_model.dart';
import 'package:project_flutter/pages/login_page/model/login_request_api_model.dart';
import 'package:project_flutter/pages/login_page/model/login_response_model.dart';
import 'package:project_flutter/utils/base_bloc.dart';
import 'package:project_flutter/utils/base_model_api.dart';
import 'package:project_flutter/utils/colors_util.dart';
import 'package:project_flutter/utils/custom_dialog.dart';
import 'package:project_flutter/utils/enum_util.dart';
import 'package:project_flutter/utils/shared_preference_util.dart';
import 'package:project_flutter/utils/url_util.dart';
import 'package:project_flutter/utils/words_util.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends BaseBloc {
  LoginBloc() {
    setIsShowPassword(true);
  }

  BehaviorSubject<bool> _setIsShowPassword = BehaviorSubject<bool>();

  Stream<bool> get getIsShowPassword => _setIsShowPassword.stream;

  setIsShowPassword(bool value) {
    _setIsShowPassword.sink.add(value);
  }

  requestLoginApiBloc({required BuildContext context,
    required LoginRequestApiModel model, required HomeBloc homeBloc, required LoginTypeEnum loginTypeEnum}) async {
    setIsLoadingUtil(isLoading: true);

    BaseModelApi? response = await LoginProvider().loginApiProvider(
        url: UrlUtil.signIn,
        body: model.toJson());

    switch(response!.statusCode){
      case UrlUtil.statusSuccess:
        var data = json.decode(response.body);
        LoginResponseModel result = LoginResponseModel.fromJson(data);

        homeBloc.setToken(result.accessToken!);
        switch(loginTypeEnum){
          case LoginTypeEnum.normal:
            homeBloc.updateBlocSwitchPage();

            break;
          case LoginTypeEnum.cart:
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CartPage(homeBloc: homeBloc,)),
            );
            break;

          case LoginTypeEnum.detail:
            Navigator.pop(context);
            break;
        }
        await SharedPreferenceUtil().setStringSharePreference(
            key: SharedPreferenceUtil.accessToken, value: result.accessToken!);

        setIsLoadingUtil(isLoading: false);
        requestGetUserApiBloc(context: context, homeBloc: homeBloc);

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

  requestGetUserApiBloc({required BuildContext context, required HomeBloc homeBloc}) async {
    setIsLoadingUtil(isLoading: true);

    BaseModelApi? response = await LoginProvider().getUserApiProvider(
        url: UrlUtil.getUser);

    switch(response!.statusCode){
      case UrlUtil.statusSuccessCreated:

        var data = json.decode(response.body);
        GetUserResponseApiModel result = GetUserResponseApiModel.fromJson(data);
        homeBloc.setGetUser(result);
        homeBloc.setTotalCart(result.totalCarts!);
        setIsLoadingUtil(isLoading: false);

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


  disposeLoginBloc() {
    _setIsShowPassword.close();
  }
}
