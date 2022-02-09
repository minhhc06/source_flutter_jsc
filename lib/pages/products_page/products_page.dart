import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/bloc/home_bloc.dart';
import 'package:project_flutter/pages/cart_page/cart_page.dart';
import 'package:project_flutter/pages/home_page/model/products_home_model.dart';
import 'package:project_flutter/pages/home_page/model/request_products_api_model.dart';
import 'package:project_flutter/pages/login_page/login_page.dart';
import 'package:project_flutter/pages/login_page/model/get_user_response_api_model.dart';
import 'package:project_flutter/pages/login_page/model/product_categories_model.dart';
import 'package:project_flutter/pages/products_page/model/product_request_model.dart';
import 'package:project_flutter/utils/base_components.dart';
import 'package:project_flutter/utils/colors_util.dart';
import 'package:project_flutter/utils/convert_color_util.dart';
import 'package:project_flutter/utils/enum_util.dart';
import 'package:project_flutter/utils/shared_preference_util.dart';
import 'package:project_flutter/utils/size_util.dart';
import 'package:project_flutter/utils/url_util.dart';
import 'package:rxdart/rxdart.dart';

class ProductsPage extends StatefulWidget {
  final HomeBloc bloc;
  const ProductsPage({Key? key, required this.bloc}) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> with BaseComponents{
  List<String> listMenu=["Thịt, rau củ", "Bách hóa", "Nhà cửa", "Thiết bị số", "Điện thoại", "Làm đẹp", "Gia dụng"];
  List<String> listImage=["https://salt.tikicdn.com/cache/w1080/ts/banner/c0/67/e7/0a3ea3ac2e0b4a7364ad29cd96669861.png.webp",
    "https://salt.tikicdn.com/cache/w1080/ts/banner/ae/c7/33/04b17cc023ccda36785b7bf91aa926fa.png.webp",
    "https://salt.tikicdn.com/cache/w1080/ts/banner/3e/3d/53/0e13f03302417fdc5876e9900db10a93.png.webp",
  ];

  int page = 1;
  int indexCategory = -1;
  late ScrollController _scrollController;

  final searchOnChange = new BehaviorSubject<String>();


  void _scrollListener(ScrollController _controller) async {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      page++;
      widget.bloc.productsApiBloc(context: context, bloc: widget.bloc,
          body: ProductRequestModel(page: page.toString(),
              limit: UrlUtil.limitPage, categoryId: indexCategory));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = new ScrollController();
    _scrollController.addListener(() {
      _scrollListener(_scrollController);
    });

    searchOnChange.debounceTime(Duration(milliseconds: 500)).listen((queryString) {
      page = 1;
      widget.bloc.productsApiBloc(context: context, bloc: widget.bloc,
          body: ProductRequestModel(page: page.toString(), searchString: queryString,
              limit: UrlUtil.limitPage));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110.0),
        child: AppBar(
          centerTitle: false,
          backgroundColor: ConvertColorUtil(ColorsUtil.colorApp),
          title: StreamBuilder<GetUserResponseApiModel>(
              stream: widget.bloc.getGetUser,
              builder: (context, snapshotGetUser) {
                if(snapshotGetUser.data == null){
                  return Container();
                }
                return StreamBuilder<String>(
                    stream: widget.bloc.getToken,
                    builder: (context, snapshotToken) {
                      if(snapshotToken.data != null && snapshotToken.data != ''){
                        return Row(
                          children: [
                            Icon(Icons.account_balance_wallet),
                            Text('${snapshotGetUser.data!.userInfo.coin} coin'),
                          ],
                        );
                      }
                      return Container();

                    }
                );
              }
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.share,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
              },
            ),
            Stack(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.shopping_cart_sharp,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    // do something
                    String? token = await SharedPreferenceUtil().getStringSharePreference(key:
                    SharedPreferenceUtil.accessToken);
                    if(token != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CartPage(homeBloc: widget.bloc,)),
                      );
                    }else{
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPage(homeBloc: widget.bloc, loginTypeEnum: LoginTypeEnum.cart)),
                      );
                    }
                  },
                ),
                StreamBuilder<int>(
                    stream: widget.bloc.getTotalCart,
                    builder: (context, snapshotTotalCart) {
                      if(snapshotTotalCart.data == null || snapshotTotalCart.data == 0){
                        return Container();
                      }
                      return Positioned(
                          right: 8,
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
            ),
          ],
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child: Padding(
                padding:  EdgeInsets.only(left: SizeUtil.padding16,
                    right: SizeUtil.padding16,
                    bottom: SizeUtil.padding16,
                    top: SizeUtil.padding8),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: const [
                      // BoxShadow(color: Colors.green, spreadRadius: 3),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: TextField(
                    onChanged: (text) {
                      searchOnChange.add(text);
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                        hintText: 'Bạn tìm gì hôm nay?'
                    ),
                  ),
                ),
              )
          ),
        ),
      ) ,
      body: StreamBuilder<bool>(
        stream: widget.bloc.getIsLoadingUtil,
        builder: (context, snapshotIsLoadingUtil) {
          return Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    StreamBuilder<List<ProductCategories>>(
                      stream: widget.bloc.getProductCategories,
                      builder: (context, snapshotProductCategories) {
                        if(snapshotProductCategories.data == null){
                          return Container();
                        }
                        return Container(
                          color: ConvertColorUtil(ColorsUtil.colorApp),
                          height: 50,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshotProductCategories.data!.length,
                            itemBuilder: (BuildContext context, int index) =>  Padding(
                              padding: const EdgeInsets.only(left: 16, right: 16),
                              child: InkWell(
                                onTap: (){
                                  indexCategory = snapshotProductCategories.data![index].id!;
                                  page = 1;
                                  widget.bloc.productsApiBloc(bloc: widget.bloc,
                                      body: ProductRequestModel(page: page.toString(), limit: UrlUtil.limitPage, categoryId:  indexCategory), context: context);
                                },
                                  child: Center(child: Text(snapshotProductCategories.data![index].name!, style: TextStyle(color: Colors.white),))),
                            ),
                          ),
                        );
                      }
                    ),

                    SizedBox(
                      height: 150.0,
                      width: double.infinity,
                      child: Swiper(
                          itemBuilder: (BuildContext context,int index){
                            return Image.network(listImage[index],fit: BoxFit.fill,);
                          },

                          itemCount: listImage.length,
                          autoplay: true
                      ),
                    ),
                    StreamBuilder<List<ProductHomeModel>>(
                        stream: widget.bloc.getListProducts,
                        builder: (context, snapshot) {
                          if(snapshot.data == null){
                            return Container();
                          }
                          return buildGridView(context: context, products: snapshot.data!, bloc: widget.bloc);
                        }
                    ),
                    StreamBuilder<bool>(
                      stream: widget.bloc.getIsLoadingPagination,
                      builder: (context, snapshotIsLoadingPagination) {
                        return Column(
                          children: [
                            processingUtil(snapshotIsLoadingPagination.data),
                            SizedBox(height: 50,)
                          ],
                        );
                      }
                    ),


                  ],
                ),
              ),
              processingUtil(snapshotIsLoadingUtil.data)
            ],
          );
        }
      ),
    );
  }
}
