import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_flutter/bloc/provider/history_order_provider.dart';
import 'package:project_flutter/pages/history_order_page/model/history_order_model.dart';
import 'package:project_flutter/utils/base_bloc.dart';
import 'package:project_flutter/utils/base_model_api.dart';
import 'package:project_flutter/utils/colors_util.dart';
import 'package:project_flutter/utils/custom_dialog.dart';
import 'package:project_flutter/utils/url_util.dart';
import 'package:project_flutter/utils/words_util.dart';
import 'package:rxdart/rxdart.dart';

class HistoryOrderBloc extends BaseBloc{
  BehaviorSubject<List<HistoryOrderModel>> _setHistoryOrderModel = BehaviorSubject<List<HistoryOrderModel>>();

  Stream<List<HistoryOrderModel>> get getHistoryOrderModel => _setHistoryOrderModel.stream;

  void setHistoryOrderModel(List<HistoryOrderModel> index) {
    _setHistoryOrderModel.sink.add(index);
  }

  fetchHistoryOrdersApiBloc({required BuildContext context,
    required  Map<String, dynamic>? body}) async {
    if(body!['page'] == '1'){
      setIsLoadingUtil(isLoading: true);
    }else{
      setIsLoadingPagination(isLoading: true);
    }

    print('body ${body}');

    BaseModelApi? response = await HistoryOrderProvider().fetchListApiProvider(
        nameApi: UrlUtil.fetchOrderItem, body: body);

    switch(response!.statusCode){
      case UrlUtil.statusSuccessCreated:

        final List<HistoryOrderModel> listOrder = [];
        json.decode(response.body)['data']['orders'].forEach((v) {
          listOrder.add(HistoryOrderModel.fromJson(v));
        });

        var model;
        if(body['page'] == '1'){
          model = <HistoryOrderModel>[];
        }else{

          model = _setHistoryOrderModel.stream.value;
        }

        model.addAll(listOrder);

        setHistoryOrderModel(model);
        if(body['page'] == '1'){
          setIsLoadingUtil(isLoading: false);

        }else{
          setIsLoadingPagination(isLoading: false);
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