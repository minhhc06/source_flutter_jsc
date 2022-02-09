import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/utils/base_components.dart';
import 'package:project_flutter/utils/model/create_order_request_model.dart';
import 'package:project_flutter/utils/model/order_items_model.dart';
import 'package:project_flutter/utils/size_util.dart';

class ConfirmOrderComponents extends BaseComponents{
  Widget buildInfoUser(CreateOrderRequestModel requestApiModel){
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(SizeUtil.padding16),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.blue,),
                SizedBox(width: SizeUtil.padding8,),
                Text(requestApiModel.name_receiver!),
                SizedBox(width: SizeUtil.padding8,),
                Text(requestApiModel.phone_number!)
              ],
            ),
            Text('${requestApiModel.address}, Phường ${requestApiModel.ward}, Quận ${requestApiModel.district}, Thành phố ${requestApiModel.city}',
              style: TextStyle(color: Colors.grey),)
          ],
        ),
      ),
    );
  }

  Widget listOrders(List<OrderItemsModel> listOrders){
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(SizeUtil.padding16),
            child: Text('Danh sách sản phẩm', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) =>
                  ListTile(
                      title: Row(
                          children: [
                        Expanded(
                            flex: 2,
                            child: CachedNetworkImage(
                              width: 80,
                              height: 80,
                              imageUrl: listOrders[index].urlImage!,
                              placeholder: (context, url) => Container(
                                color: Colors.grey,
                              ),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),),
                        SizedBox(width: SizeUtil.padding8,),
                        Expanded(
                            flex: 8,
                            child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 9,
                                          child: Text(
                                              '${listOrders[index].title}', maxLines: 2,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                  color:
                                                  Colors.black)),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                              'x${listOrders[index].quantity}',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                  color: Colors.green)),
                                        )
                                      ]),
                                  SizedBox(height: 4),
                                  RichText(
                                      text: TextSpan(
                                          text:
                                          '${formatMoney(value: listOrders[index].total)} đ',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                              FontWeight.w300,
                                              color: Color.fromRGBO(
                                                  39, 43, 47, 1)),
                                          children: [
                                            TextSpan(
                                                text:
                                                '',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                    FontWeight.w700,
                                                    color:
                                                    Colors.green))
                                          ]))
                                ]))
                      ])),
              separatorBuilder:
                  (BuildContext context, int index) =>
                  Container(),
              itemCount: listOrders.length),
        ],
      ),
    );
  }
}