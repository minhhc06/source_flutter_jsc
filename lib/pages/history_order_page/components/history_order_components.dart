import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/pages/history_order_page/model/history_order_model.dart';
import 'package:project_flutter/utils/base_components.dart';
import 'package:project_flutter/utils/convert_color_util.dart';
import 'package:project_flutter/utils/enum_util.dart';
import 'package:project_flutter/utils/size_util.dart';

class HistoryOrderComponents extends BaseComponents{
  Widget buildListItems({required HistoryOrderModel model, }){
    return Padding(
      padding: const EdgeInsets.only(bottom: SizeUtil.padding8),
      child: Container(
        decoration: myBoxDecoration(background: Colors.white),
        height: 100,
        child: Row(
          children: [

            Expanded(
              flex: 2,
              child: model.product!.productImages[0].url != null ? CachedNetworkImage(
                width: 80,
                height: 80,
                imageUrl: model.product!.productImages[0].url!,
                placeholder: (context, url) => Container(
                  color: Colors.grey,
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ) : Icon(Icons.error),
            ),
            SizedBox(
              width: SizeUtil.padding8,
            ),
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(model.product!.name, maxLines: 2,style: TextStyle(fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis),
                  Text('Số lượng: ${model.quantity} | Giá: ${formatMoney(value: model.product!.price)} đ', maxLines: 1, style: TextStyle(color: Colors.red),),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text('${parseDateTime(model.created_at!)}', style: TextStyle(color: Colors.grey),),
                     Container(

                       decoration: myBoxDecorationOrderItem(color: StatusOrderItem.values[setIndexStatusOrderItem(model.statusName!)].colorStatus!),
                       child: Padding(
                         padding: const EdgeInsets.symmetric(vertical: SizeUtil.padding8, horizontal: SizeUtil.padding16),
                         child: Text('${StatusOrderItem.values[setIndexStatusOrderItem(model.statusName!)].titleStatus!}', style: TextStyle(color: Colors.white),),
                       ),
                     )
                   ],
                 )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration myBoxDecorationOrderItem({required String color, double? borderSide = 20.0 }) {
    return BoxDecoration(
      color: ConvertColorUtil(color),
      borderRadius: BorderRadius.all(
          Radius.circular(borderSide!) //                 <--- border radius here
      ),
    );
  }

}