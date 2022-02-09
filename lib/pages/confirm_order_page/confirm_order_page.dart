
import 'package:flutter/material.dart';
import 'package:project_flutter/bloc/confirm_order_bloc.dart';
import 'package:project_flutter/bloc/home_bloc.dart';
import 'package:project_flutter/pages/confirm_order_page/components/confirm_order_components.dart';
import 'package:project_flutter/utils/base_components.dart';
import 'package:project_flutter/utils/colors_util.dart';
import 'package:project_flutter/utils/convert_color_util.dart';
import 'package:project_flutter/utils/custom_dialog.dart';
import 'package:project_flutter/utils/model/create_order_request_model.dart';
import 'package:project_flutter/utils/size_util.dart';

class ConfirmOrderPage extends StatefulWidget {
  final CreateOrderRequestModel requestApiModel;
  final HomeBloc homeBloc;
  const ConfirmOrderPage({Key? key, required this.requestApiModel, required this.homeBloc}) : super(key: key);

  @override
  _ConfirmOrderPageState createState() => _ConfirmOrderPageState();
}

class _ConfirmOrderPageState extends State<ConfirmOrderPage> with BaseComponents {
  late ConfirmOrderBloc bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = new ConfirmOrderBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConvertColorUtil(ColorsUtil.backgroundGray),
      appBar: appbarBuild(title: 'Xác nhận đơn hàng', context: context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ConfirmOrderComponents().buildInfoUser(widget.requestApiModel),
            SizedBox(height: SizeUtil.padding16,),
            ConfirmOrderComponents().listOrders(widget.requestApiModel.orderItems!),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        height: 90,
        child: Padding(
          padding: const EdgeInsets.all(SizeUtil.padding16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Tổng cộng'),
                  Text('${formatMoney(value: widget.requestApiModel.total)} đ', style: TextStyle(color: Colors.red),),
                ],
              ),

              buttonUtil(title: 'Đặt hàng', handleOnPress: (){
                widget.requestApiModel.statusName = 'processing';
                bloc.orderApiBloc(context: context, body: widget.requestApiModel.toJson(),
                    homeBloc: widget.homeBloc);

              })
            ],
          ),
        ),
      ),
    );
  }
}
