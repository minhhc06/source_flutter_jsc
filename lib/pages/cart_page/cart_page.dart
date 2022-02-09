import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/bloc/cart_bloc.dart';
import 'package:project_flutter/bloc/home_bloc.dart';
import 'package:project_flutter/pages/informaton_user_order_page/information_user_order_page.dart';
import 'package:project_flutter/utils/base_components.dart';
import 'package:project_flutter/utils/enum_util.dart';
import 'package:project_flutter/utils/model/pagination_model.dart';
import 'package:project_flutter/utils/size_util.dart';
import 'package:project_flutter/utils/url_util.dart';

import 'components/cart_components.dart';

class CartPage extends StatefulWidget {
  final int? productId;
  final HomeBloc homeBloc;

  const CartPage({Key? key, this.productId, required this.homeBloc }) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with BaseComponents {
  late CartBloc bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = new CartBloc();
    bloc.fetchOrderListingApiBloc(context: context, productId: widget.productId,
        body: new PaginationModel(page: '1', limit: UrlUtil.limitPage).toJsonPagination());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarBuild(title: 'Danh sách đơn hàng', context: context, functionBack: (){
        Navigator.of(context).popUntil((route) => route.isFirst);
      }),
      body: SingleChildScrollView(
        child: CartComponents().buildOrderListing(bloc: bloc, contextState: context),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 5.0,
            ),
          ],
        ),
        height: 70,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SizeUtil.padding16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Tổng cộng:'),
                  StreamBuilder<int>(
                    stream: bloc.getTotalPrice,
                    builder: (context, snapshotTotal) {
                      return Text('${snapshotTotal.data} đ', style: TextStyle(color: Colors.red),);
                    }
                  ),
                ],
              ),
              buttonUtil(title: 'Mua hàng', background: Colors.red, handleOnPress: (){
                bloc.goToInformationPage(context: context, homeBloc: widget.homeBloc);
              })
            ],
          ),
        ),
      ),
    );
  }
}
