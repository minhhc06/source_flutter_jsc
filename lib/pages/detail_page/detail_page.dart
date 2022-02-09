import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_flutter/bloc/detail_bloc.dart';
import 'package:project_flutter/bloc/home_bloc.dart';
import 'package:project_flutter/pages/detail_page/components/detail_components.dart';
import 'package:project_flutter/pages/detail_page/model/detail_model.dart';
import 'package:project_flutter/pages/login_page/login_page.dart';
import 'package:project_flutter/utils/base_components.dart';
import 'package:project_flutter/utils/colors_util.dart';
import 'package:project_flutter/utils/convert_color_util.dart';
import 'package:project_flutter/utils/enum_util.dart';
import 'package:project_flutter/utils/rating_bar/rating_bar.dart';
import 'package:project_flutter/utils/shared_preference_util.dart';
import 'package:project_flutter/utils/size_util.dart';

class DetailPage extends StatefulWidget {
  final int id;
  final HomeBloc homeBloc;
  const DetailPage({Key? key, required this.id, required this.homeBloc}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with BaseComponents{
  late DetailBloc bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = DetailBloc();
    bloc.fetchDetailApiBloc(context: context, id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DetailModel>(
        stream: bloc.getDetailModel,
        builder: (context, snapshotDetailModel) {
          if(snapshotDetailModel.data == null){
            return processingUtil(true);
          }
          return StreamBuilder<bool>(
            stream: bloc.getIsLoadingUtil,
            builder: (context, snapshotIsLoadingUtil) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: 300,
                            width: double.infinity,
                            child: Stack(
                              children: [
                                DetailComponents().listImagesProduct(bloc: bloc,
                                    productImages: snapshotDetailModel.data?.productImages),
                                Positioned(
                                    left: SizeUtil.padding16,
                                    top: SizeUtil.padding32,
                                    child: Container(
                                      decoration: myBoxDecoration(),
                                      child: IconButton(
                                        padding: EdgeInsets.all(8),
                                        constraints: BoxConstraints(),

                                        icon: const Padding(
                                          padding: EdgeInsets.only(left: 4.0),
                                          child: Icon(Icons.arrow_back_ios, color: Colors.white),
                                        ), onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      ),
                                    )),
                                Positioned(
                                    right: SizeUtil.padding16,
                                    top: SizeUtil.padding32,
                                    child: Stack(
                                      children: [
                                        Container(
                                          decoration: myBoxDecoration(),
                                          child: IconButton(
                                            padding: EdgeInsets.all(8),
                                            constraints: BoxConstraints(),

                                            icon: const Icon(Icons.shopping_cart_sharp, color: Colors.white,), onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          ),
                                        ),
                                        StreamBuilder<int>(
                                            stream: widget.homeBloc.getTotalCart,
                                            builder: (context, snapshotTotalCart) {
                                              if(snapshotTotalCart.data == null || snapshotTotalCart.data == 0){
                                                return Container();
                                              }
                                              return Positioned(
                                                  right: 4,
                                                  child: Container(
                                                    decoration: myBoxDecorationCircle(),
                                                    child:  Padding(
                                                      padding: EdgeInsets.all(4.0),
                                                      child: Text('${snapshotTotalCart.data}', style: TextStyle(color: Colors.white, fontSize: 10),),
                                                    ),
                                                  ));
                                            }
                                        )
                                      ],
                                    )),
                                Positioned(
                                    right: SizeUtil.padding16,
                                    bottom: SizeUtil.padding8,
                                    child: Container(
                                      decoration: myBoxDecoration(background: ConvertColorUtil(ColorsUtil.backgroundGray)),
                                      height: 30,
                                      width: 70,
                                      child: StreamBuilder<int>(
                                          stream: bloc.getIndexImages,
                                          builder: (context, snapshotIndex) {
                                            return Center(child: Text('${snapshotIndex.data != null ? snapshotIndex.data : 1} / ${snapshotDetailModel.data!.productImages!.length}'));
                                          }
                                      ),
                                    ))
                              ],
                            )
                        ),
                        Container(
                          decoration: myBoxDecoration(background: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(SizeUtil.padding16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 Text('${snapshotDetailModel.data!.name}',),
                                // Padding(
                                //   padding: const EdgeInsets.symmetric(vertical: SizeUtil.padding8),
                                //   child: DetailComponents().totalReview(),
                                // ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children:  [
                                    Text('${formatMoney(value: snapshotDetailModel.data!.price)} đ', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                                    SizedBox(width: SizeUtil.padding8,),
                                    // Text('148.000 đ', style: TextStyle(decoration: TextDecoration.lineThrough),),
                                  ],
                                ),


                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: SizeUtil.padding16),
                          child: Container(
                            decoration: myBoxDecoration(background: Colors.white),
                            child:   Padding(
                              padding: const EdgeInsets.symmetric(horizontal: SizeUtil.padding16),
                              child: DetailComponents().buildDescriptions(snapshotDetailModel.data!),
                            ),
                          ),
                        )

                      ],
                    ),
                  ),
                  processingUtil(snapshotIsLoadingUtil.data)
                ],
              );
            }
          );
        }
      ),
      bottomNavigationBar: StreamBuilder<DetailModel>(
        stream: bloc.getDetailModel,
        builder: (context, snapshotDetailModel) {
          if(snapshotDetailModel.data == null){
            return Container();
          }
          return DetailComponents().buildOptionNavigationBar(context: context,
            onTapAddCart: () async {



            String? token = await SharedPreferenceUtil().getStringSharePreference(key:
            SharedPreferenceUtil.accessToken);

            if(token != null){
              bloc.createCartApiBloc(context: context, id: snapshotDetailModel.data!.id!, isBuyNow: false, homeBloc: widget.homeBloc);
            }else{
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LoginPage(homeBloc: widget.homeBloc, loginTypeEnum: LoginTypeEnum.detail)),
              );
            }

          }, buyNow: () async {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => OrderListingPage()),
            // );


              String? token = await SharedPreferenceUtil().getStringSharePreference(key:
              SharedPreferenceUtil.accessToken);

              if(token != null){
                bloc.createCartApiBloc(context: context, id: snapshotDetailModel.data!.id!, isBuyNow: true, homeBloc: widget.homeBloc);
              }else{
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginPage(homeBloc: widget.homeBloc, loginTypeEnum: LoginTypeEnum.detail)),
                );
              }

          }, );
        }
      ),
    );
  }
}
