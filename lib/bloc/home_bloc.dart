import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_flutter/bloc/provider/home_provider.dart';
import 'package:project_flutter/pages/home_page/home_page.dart';
import 'package:project_flutter/pages/home_page/model/products_home_model.dart';
import 'package:project_flutter/pages/login_page/model/get_user_response_api_model.dart';
import 'package:project_flutter/pages/login_page/model/product_categories_model.dart';
import 'package:project_flutter/pages/products_page/model/product_request_model.dart';
import 'package:project_flutter/utils/base_bloc.dart';
import 'package:project_flutter/utils/base_model_api.dart';
import 'package:project_flutter/utils/colors_util.dart';
import 'package:project_flutter/utils/custom_dialog.dart';
import 'package:project_flutter/utils/enum_util.dart';
import 'package:project_flutter/utils/shared_preference_util.dart';
import 'package:project_flutter/utils/url_util.dart';
import 'package:project_flutter/utils/words_util.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BaseBloc{
  HomeBloc(){
    setSelectedBar(SelectedNavigationBar.home);
    setTotalCart(0);
    setListProducts([]);
  }

  BehaviorSubject<List<ProductHomeModel>> _setListProducts = BehaviorSubject<List<ProductHomeModel>>();

  Stream<List<ProductHomeModel>> get getListProducts => _setListProducts.stream;

  void setListProducts(List<ProductHomeModel> products) {

    _setListProducts.sink.add(products);
  }

  BehaviorSubject<List<ProductCategories>> _setProductCategories = BehaviorSubject<List<ProductCategories>>();

  Stream<List<ProductCategories>> get getProductCategories => _setProductCategories.stream;

  void setProductCategories(List<ProductCategories> categories) {

    _setProductCategories.sink.add(categories);
  }


  BehaviorSubject<SelectedNavigationBar> _setSelectedBar = BehaviorSubject<SelectedNavigationBar>();

  Stream<SelectedNavigationBar> get getSelectedBar => _setSelectedBar.stream;

  void setSelectedBar(SelectedNavigationBar selected) {
    _setSelectedBar.sink.add(selected);
  }

  BehaviorSubject<int> _setTotalCart = BehaviorSubject<int>();

  Stream<int> get getTotalCart => _setTotalCart.stream;

  void setTotalCart(int total) {
    _setTotalCart.sink.add(total);
  }

  void updateBlocTotalCart() {
    var total = _setTotalCart.stream.value;
    total = total + 1;
    _setTotalCart.sink.add(total);
  }


  BehaviorSubject<String> _setToken = BehaviorSubject<String>();

  Stream<String> get getToken => _setToken.stream;

  void setToken(String token) {
    _setToken.sink.add(token);
  }

  BehaviorSubject<GetUserResponseApiModel> _setGetUser = BehaviorSubject<GetUserResponseApiModel>();

  Stream<GetUserResponseApiModel> get getGetUser => _setGetUser.stream;

  void setGetUser(GetUserResponseApiModel model) {
    _setGetUser.sink.add(model);
  }

  requestGetUserApiBloc({required BuildContext context, required HomeBloc bloc}) async {
    setIsLoadingUtil(isLoading: true);
    String? token = await SharedPreferenceUtil().getStringSharePreference(key:
    SharedPreferenceUtil.accessToken);

    if(token != null){
      BaseModelApi? response = await HomeProvider().getUserApiProvider(
          url: UrlUtil.getUser);

      switch(response!.statusCode){
        case UrlUtil.statusSuccessCreated:

          var data = json.decode(response.body);
          GetUserResponseApiModel result = GetUserResponseApiModel.fromJson(data);
          setGetUser(result);
          setTotalCart(result.totalCarts!);

          setIsLoadingUtil(isLoading: false);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>  HomePage(bloc: bloc,),
            ),
          );

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
    }else{
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>  HomePage(bloc: bloc,),
        ),
      );
    }
  }

  productsApiBloc({required BuildContext context, required HomeBloc bloc,
    required ProductRequestModel? body}) async {
      if(body!.page == 1){
        setIsLoadingUtil(isLoading: true);
      }else{
        setIsLoadingPagination(isLoading: true);
      }

      print('body ${body.toJson()}');

      BaseModelApi? response = await HomeProvider().productsApiProvider(
          url: UrlUtil.products, body: body.toJson());

      switch(response!.statusCode){
        case UrlUtil.statusSuccessCreated:

          final List<ProductHomeModel> listProducts = [];
          json.decode(response.body)['data'].forEach((v) {
            listProducts.add(ProductHomeModel.fromJson(v));
          });

          var model;
          if(body.page == '1'){
            model = <ProductHomeModel>[];
          }else{

            model = _setListProducts.stream.value;
          }

          model.addAll(listProducts);

          setListProducts(model);
          if(body.page == 1){
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

  productCategoriesApiBloc({required BuildContext context, required HomeBloc bloc}) async {

    BaseModelApi? response = await HomeProvider().productsApiProvider(
        url: UrlUtil.productsCategories);

    switch(response!.statusCode){
      case UrlUtil.statusSuccessCreated:

        final List<ProductCategories> listCategories = [];
        json.decode(response.body)['data'].forEach((v) {
          listCategories.add(ProductCategories.fromJson(v));
        });

        setProductCategories(listCategories);
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

  Future<void> updateBlocSwitchPage() async {
    var page = _setSelectedBar.stream.value;
    setSelectedBar(page);
  }

  dispose(){
    _setListProducts.close();
    _setSelectedBar.close();
  }

}