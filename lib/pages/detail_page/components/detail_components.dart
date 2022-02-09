
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/bloc/detail_bloc.dart';
import 'package:project_flutter/pages/detail_page/model/detail_model.dart';
import 'package:project_flutter/pages/image_full_page/image_full_page.dart';
import 'package:project_flutter/utils/base_components.dart';
import 'package:project_flutter/utils/colors_util.dart';
import 'package:project_flutter/utils/convert_color_util.dart';
import 'package:project_flutter/utils/model/product_images_model.dart';
import 'package:project_flutter/utils/rating_bar/rating_bar.dart';
import 'package:project_flutter/utils/size_util.dart';

class DetailComponents extends BaseComponents{
  Widget listImagesProduct({required DetailBloc bloc, List<ProductImages>? productImages}){
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: productImages!.length,
      onPageChanged: (index){
        bloc.setIndexImages(index + 1);

      },
      itemBuilder: (BuildContext context,int position) =>
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return ImageFullPage(url: productImages[position].url!);
              }));
            },
            child: CachedNetworkImage(
              imageUrl: productImages[position].url!,
              placeholder: (context, url) => Container(
                color: Colors.grey,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
    );
  }

  Widget totalReview(){
    return Row(
      children: [
        AbsorbPointer(
          absorbing: true,
          child: RatingBar.builder(
            itemSize: 20,
            initialRating: 4,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            updateOnDrag: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {

            },
          ),
        ),
        const Text('(42) | Đã bán 241', style: TextStyle(color: Colors.grey),)
      ],
    );
  }

  Widget buildOptionNavigationBar({required BuildContext context, required Function onTapAddCart, required Function buyNow}){
    return Container(
      color: Colors.white,
      height: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: ConvertColorUtil(ColorsUtil.backgroundGray),
            height: 1.0,
            width: double.infinity,
          ),
          const SizedBox(height: SizeUtil.padding8,),
          Row(
            children: [
              const SizedBox(width: SizeUtil.padding16,),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: (){
                    onTapAddCart();
                  },
                  child: Container(
                      decoration: myBoxDecorationWithBorder(background: Colors.white, borderSide: 10),
                      child: const Padding(
                        padding: EdgeInsets.all(SizeUtil.padding16),
                        child: Text('Thêm vào giỏ hàng', style: TextStyle(color: Colors.blueAccent),
                            textAlign: TextAlign.center),
                      )),
                ),
              ),
              const SizedBox(width: SizeUtil.padding16,),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: (){
                    buyNow();
                  },
                  child: Container(
                      decoration: myBoxDecoration(background: Colors.redAccent, borderSide: 10),
                      child: const Padding(
                        padding: EdgeInsets.all(SizeUtil.padding16),
                        child: Text('Mua ngay', textAlign: TextAlign.center, style: TextStyle(color: Colors.white),),
                      )),
                ),
              ),
              const SizedBox(width: SizeUtil.padding16,),
            ],
          ),
          const SizedBox(height: SizeUtil.padding8,),
          Container(
            color: ConvertColorUtil(ColorsUtil.backgroundGray),
            height: 1.0,
            width: double.infinity,
          ),
        ],
      ),
    );
  }

  Widget buildDescriptions(DetailModel detailModel){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SizeUtil.padding16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          const Text('Mô tả chi tiết', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),),
          const SizedBox(height: SizeUtil.padding8,),
          textDescription(title:  'Giới thiệu',
          description: '${detailModel.about}.'),
          textDescription(title:  'Nhãn hiệu',
          description: '${detailModel.brand}.'),
          textDescription(title:  'Nguyên liệu chính',
          description: '${detailModel.material}.'),
          textDescription(title:  'Sản xuất',
              description: '${detailModel.made_in}.'),
          textDescription(title:  'Hạn sử dụng',
              description: '${formatDay(date: detailModel.expiry!)}.'),
          textDescription(title:  'Bảo quản',
              description: '${detailModel.preserve}.'),
          textDescription(title:  'Loại da phù hợp',
              description: '${detailModel.type_skin}.'),

        ],
      ),
    );
  }

  Widget textDescription({required String title, required String description}){
    return Padding(
      padding: const EdgeInsets.only(bottom: SizeUtil.padding8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
              child: Text('$title:', style: TextStyle(fontWeight: FontWeight.bold),)),
          Expanded(
            flex: 7,
              child: Text(description, maxLines: 3,)),
        ],
      ),
    );
  }

}