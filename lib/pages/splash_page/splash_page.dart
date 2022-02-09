import 'package:flutter/material.dart';
import 'package:project_flutter/bloc/home_bloc.dart';
import 'package:project_flutter/pages/home_page/model/request_products_api_model.dart';
import 'package:project_flutter/pages/products_page/model/product_request_model.dart';
import 'package:project_flutter/utils/colors_util.dart';
import 'package:project_flutter/utils/convert_color_util.dart';
import 'package:project_flutter/utils/paths_util.dart';
import 'package:project_flutter/utils/shared_preference_util.dart';
import 'package:project_flutter/utils/url_util.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late HomeBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = HomeBloc();

    Future.delayed(
      Duration(seconds: 2),
          () async {
            String? token = await SharedPreferenceUtil().getStringSharePreference(key:
            SharedPreferenceUtil.accessToken);
            if(token != null){
              bloc.setToken(token);
            }
            bloc.requestGetUserApiBloc(context: context, bloc: bloc);
            bloc.productsApiBloc(context: context, bloc: bloc, body: ProductRequestModel(page: '1', limit: UrlUtil.limitPage, categoryId: 0 ));
            bloc.productCategoriesApiBloc(context: context, bloc: bloc);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: ConvertColorUtil(ColorsUtil.colorApp),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
              child: Image.asset(PathsUtil.logoApp))),
        ),
    );
  }
}
