import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_flutter/bloc/home_bloc.dart';
import 'package:project_flutter/bloc/provider/confirm_order_provider.dart';
import 'package:project_flutter/pages/home_page/model/total_cart_model.dart';
import 'package:project_flutter/utils/base_bloc.dart';
import 'package:project_flutter/utils/base_model_api.dart';
import 'package:project_flutter/utils/base_provider.dart';
import 'package:project_flutter/utils/colors_util.dart';
import 'package:project_flutter/utils/convert_color_util.dart';
import 'package:project_flutter/utils/custom_dialog.dart';
import 'package:project_flutter/utils/url_util.dart';
import 'package:project_flutter/utils/words_util.dart';

class ConfirmOrderBloc extends BaseBloc{
  orderApiBloc({required BuildContext context, required Map<String, dynamic>? body,
    required HomeBloc homeBloc, int? productId}) async {
    setIsLoadingUtil(isLoading: true);
    BaseModelApi? response = await ConfirmOrderProvider().apiProvider(
        nameApi: UrlUtil.order, body: body);

    switch(response!.statusCode){
      case UrlUtil.statusSuccess:
        setIsLoadingUtil(isLoading: true);
        BaseModelApi? resTotalCart = await ConfirmOrderProvider().apiProvider(
            nameApi: UrlUtil.totalCart, method: Method.get);
        switch(resTotalCart!.statusCode) {
          case UrlUtil.statusSuccessCreated:
            var total = json.decode(resTotalCart.body)['data'];
            TotalCartModel result = TotalCartModel.fromJson(total);
            homeBloc.setTotalCart(result.total!);


            setIsLoadingUtil(isLoading: false);
            Navigator.of(context).popUntil((route) => route.isFirst);
            CustomDialog().dialogNotificationPush(context: context, title: WordsUtil.successCreateOrder,
                icon: Icon(Icons.check, color: Colors.white,),
                buttonTitle: WordsUtil.exit,  listColors: [
                  ConvertColorUtil(ColorsUtil.colorApp),
                  ConvertColorUtil(ColorsUtil.yellowColorDialog),
                ], function: (BuildContext buildContext){
                  Navigator.pop(buildContext);
                });
            break;
          default:
            setIsLoadingUtil(isLoading: false);
            Navigator.of(context).popUntil((route) => route.isFirst);
            break;
        }


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