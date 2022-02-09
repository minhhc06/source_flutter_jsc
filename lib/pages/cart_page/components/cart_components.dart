import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/bloc/cart_bloc.dart';
import 'package:project_flutter/pages/cart_page/model/order_listing_model.dart';
import 'package:project_flutter/utils/base_components.dart';
import 'package:project_flutter/utils/colors_util.dart';
import 'package:project_flutter/utils/convert_color_util.dart';
import 'package:project_flutter/utils/size_util.dart';

class CartComponents extends BaseComponents{
  Widget buildOrderListing({required CartBloc bloc, required BuildContext contextState}){
    return StreamBuilder<List<OrderListingModel>>(
      stream: bloc.getListOrderListing,
      builder: (context, snapshotOrderListing) {
        if(snapshotOrderListing.data == null){
          return processingUtil(true);
        }
        return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            primary: false,
            shrinkWrap: true,
            padding: const EdgeInsets.all(SizeUtil.padding16),
            itemCount: snapshotOrderListing.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return buildListItems( model: snapshotOrderListing.data![index],
                  updateCheckbox: (){
                bloc.updateBlocCheckbox(index: index);
              },
                  updateQuantity: (int quantity){
                    bloc.updateBlocQuantity(index: index, quantity: quantity);
                  },
                showDialogInput: (int value){
                  _textFieldController.text = value.toString() ;
                  _displayTextInputDialog(context, index, bloc);

                }
                  );
            }
        );
      }
    );
  }

  TextEditingController _textFieldController = TextEditingController();

  Future<void> _displayTextInputDialog(BuildContext context, int index, CartBloc bloc) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Nhập số lượng sản phẩm'),
          content: TextField(
            keyboardType: TextInputType.number,
            controller: _textFieldController,
            decoration: InputDecoration(hintText: "Nhập số lượng sản phẩm"),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Thoát'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('Đồng ý'),
              onPressed: () {
                print(_textFieldController.text);
                bloc.updateBlocQuantity(index: index, quantity:  int.parse(_textFieldController.text));
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildListItems({required OrderListingModel model, required Function updateCheckbox,
    required Function(int) updateQuantity, required Function(int) showDialogInput}){
    return Padding(
      padding: const EdgeInsets.only(bottom: SizeUtil.padding8),
      child: Container(
        decoration: myBoxDecoration(background: Colors.white),
        height: 100,
        child: Row(
          children: [
            Checkbox(value: model.isSelected,
                checkColor: Colors.white,
                activeColor: ConvertColorUtil(ColorsUtil.colorApp),
                onChanged: (bool? value){
              updateCheckbox();
            }),

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
                  Text('${formatMoney(value: model.product!.price)} đ', maxLines: 1, style: TextStyle(color: Colors.red),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 30,

                        decoration: myBoxDecorationWithBorder(background: Colors.white, backgroundBorder: Colors.grey),
                        child: Row(
                          children: [
                            IconButton(
                              // constraints: BoxConstraints(),
                                padding: EdgeInsets.zero,
                                onPressed: (){
                                  if(model.quantity! > 1)
                                  updateQuantity(model.quantity! - 1);
                                }, icon: Icon(Icons.remove)),
                            Container(
                              color: Colors.grey,
                              height: double.infinity,
                              width: 1,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: SizeUtil.padding8),
                              child: GestureDetector(
                                onTap: (){
                                  showDialogInput(model.quantity!);
                                },
                                  child: Text('${model.quantity}')),
                            ),
                            Container(
                              color: Colors.grey,
                              height: double.infinity,
                              width: 1,
                            ),
                            IconButton(
                              // constraints: BoxConstraints(),
                                padding: EdgeInsets.zero,
                                onPressed: (){
                                  updateQuantity(model.quantity! + 1);
                                }, icon: Icon(Icons.add))
                          ],
                        ),
                      ),
                      TextButton(

                        onPressed: () {  },
                        child: Text('Xóa'),
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
}