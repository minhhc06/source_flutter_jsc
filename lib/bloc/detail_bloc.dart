import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_flutter/bloc/home_bloc.dart';
import 'package:project_flutter/bloc/provider/detail_product_provider.dart';
import 'package:project_flutter/pages/cart_page/cart_page.dart';
import 'package:project_flutter/pages/detail_page/model/detail_model.dart';
import 'package:project_flutter/utils/base_bloc.dart';
import 'package:project_flutter/utils/base_model_api.dart';
import 'package:project_flutter/utils/colors_util.dart';
import 'package:project_flutter/utils/custom_dialog.dart';
import 'package:project_flutter/utils/enum_util.dart';
import 'package:project_flutter/utils/url_util.dart';
import 'package:project_flutter/utils/words_util.dart';
import 'package:rxdart/rxdart.dart';

class DetailBloc extends BaseBloc{

  DetailBloc(){
    setIndexImages(1);
  }

  BehaviorSubject<int> _setIndexImages = BehaviorSubject<int>();

  Stream<int> get getIndexImages => _setIndexImages.stream;

  void setIndexImages(int index) {
    _setIndexImages.sink.add(index);
  }

  BehaviorSubject<DetailModel> _setDetailModel = BehaviorSubject<DetailModel>();

  Stream<DetailModel> get getDetailModel => _setDetailModel.stream;

  void setDetailModel(DetailModel index) {
    _setDetailModel.sink.add(index);
  }

  fetchDetailApiBloc({required BuildContext context, required int id}) async {

    BaseModelApi? response = await DetailProductProvider().fetchDetailProductApiProvider(
        nameApi: UrlUtil.products,  id: id);

    switch(response!.statusCode){
      case UrlUtil.statusSuccessCreated:
        var data = json.decode(response.body)['data'];
        DetailModel model =  DetailModel.fromJson(data);
        setDetailModel(model);
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

  Map<String, dynamic> toJsonId(int id) => {
    "productId": id
  };

  createCartApiBloc({required BuildContext context,
    required int id, required bool isBuyNow, required HomeBloc homeBloc}) async {
    setIsLoadingUtil(isLoading: true);
    BaseModelApi? response = await DetailProductProvider().createCartApiProvider(
        nameApi: UrlUtil.cart,  body: toJsonId(id));

    switch(response!.statusCode){
      case UrlUtil.statusSuccess:

        setIsLoadingUtil(isLoading: false);
        homeBloc.updateBlocTotalCart();
        if(isBuyNow == true){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage(productId: id, homeBloc: homeBloc,)),
          );
        }else{

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


  addCartApiBloc({required BuildContext context, required int productId}) async {
    setIsLoadingUtil(isLoading: true);

    BaseModelApi? response = await DetailProductProvider().fetchDetailProductApiProvider(
        nameApi: UrlUtil.cart,  id: productId);

    switch(response!.statusCode){
      case UrlUtil.statusSuccessCreated:

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

  dispose(){
    _setIndexImages.close();
  }

}