import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_flutter/bloc/home_bloc.dart';
import 'package:project_flutter/bloc/provider/order_listing_provider.dart';
import 'package:project_flutter/pages/cart_page/model/order_listing_model.dart';
import 'package:project_flutter/pages/informaton_user_order_page/information_user_order_page.dart';
import 'package:project_flutter/utils/base_bloc.dart';
import 'package:project_flutter/utils/base_model_api.dart';
import 'package:project_flutter/utils/colors_util.dart';
import 'package:project_flutter/utils/convert_color_util.dart';
import 'package:project_flutter/utils/custom_dialog.dart';
import 'package:project_flutter/utils/model/create_order_request_model.dart';
import 'package:project_flutter/utils/model/order_items_model.dart';
import 'package:project_flutter/utils/url_util.dart';
import 'package:project_flutter/utils/words_util.dart';
import 'package:rxdart/rxdart.dart';

class CartBloc extends BaseBloc{
  CartBloc(){
    setTotalPrice(0);
  }

  BehaviorSubject<List<OrderListingModel>> _setListOrderListing = BehaviorSubject<List<OrderListingModel>>();

  Stream<List<OrderListingModel>> get getListOrderListing => _setListOrderListing.stream;

  setListOrderListing(List<OrderListingModel> list) {
    _setListOrderListing.sink.add(list);
  }

  BehaviorSubject<int> _setTotalPrice = BehaviorSubject<int>();

  Stream<int> get getTotalPrice => _setTotalPrice.stream;

  setTotalPrice(int total) {
    _setTotalPrice.sink.add(total);
  }

  updateBlocCheckbox({required int index}){
    var model = _setListOrderListing.stream.value;
    model[index].isSelected = !model[index].isSelected!;
    _setListOrderListing.sink.add(model);

    int total = 0;
    for(var order in model){
      if(order.isSelected == true){
        total = total + order.product!.price * order.quantity!;
      }
    }

    setTotalPrice(total);

  }

  updateBlocQuantity({required int index, required int quantity}){
    var model = _setListOrderListing.stream.value;
    model[index].quantity = quantity;
    _setListOrderListing.sink.add(model);

    int total = 0;
    for(var order in model){
      if(order.isSelected == true){
        total = total + order.product!.price * order.quantity!;
      }
    }

    setTotalPrice(total);

  }

  fetchOrderListingApiBloc({required BuildContext context, required Map<String, dynamic>? body, int? productId}) async {
    BaseModelApi? response = await OrderListingProvider().fetchOrderListingApiProvider(
        url: UrlUtil.cart, body: body);

    switch(response!.statusCode){
      case UrlUtil.statusSuccessCreated:
        final List<OrderListingModel> listCarts = [];

        json.decode(response.body)['data'].forEach((v) {
          listCarts.add(OrderListingModel.fromJson(v));
        });

        var model;
        if(body!['page'] == '1'){
          model = <OrderListingModel>[];
        }else{
          setIsLoadingPagination(isLoading: false);
          model = _setListOrderListing.stream.value;
        }

        if(productId != null){
          for(int i = 0; i < listCarts.length; i++){
            if(listCarts[i].product!.id == productId){
              listCarts[i].isSelected = true;
            }
          }
        }




        model.addAll(listCarts);

        num total = 0;
        for(var order in model){
          if(order.isSelected == true){
            total = total + order.product!.price * order.quantity!;
          }
        }

        setTotalPrice(total.toInt());

        setListOrderListing(model);

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

  goToInformationPage({required BuildContext context, required HomeBloc homeBloc}){
    var model = _setListOrderListing.stream.value;
    // List<OrderListingModel> listOrders = [];
    List<OrderItemsModel> listOrders = [];


    for(var order in model){
      if(order.isSelected == true){
        listOrders.add(new OrderItemsModel(productId: order.product!.id, quantity: order.quantity, total: order.quantity! * order.product!.price,
        title: order.product!.name, urlImage: order.product!.productImages[0].url));
      }
    }


    if(listOrders.length > 0){
      var totalPrice = _setTotalPrice.stream.value;


      CreateOrderRequestModel requestApiModel = new CreateOrderRequestModel();
      requestApiModel.orderItems = [];
      requestApiModel.orderItems!.addAll(listOrders);
      requestApiModel.total = totalPrice;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            InformationUserOrderPage(requestApiModel: requestApiModel,
              homeBloc: homeBloc,)),
      );
    }else{
      Fluttertoast.showToast(
          msg:
          WordsUtil.validateListOrder,
          toastLength: Toast
              .LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor:
          ConvertColorUtil(
              ColorsUtil
                  .toastColorWarning),
          textColor: ConvertColorUtil(
              ColorsUtil
                  .toastTextColorWarning),
          fontSize: 16.0);
    }



  }

}