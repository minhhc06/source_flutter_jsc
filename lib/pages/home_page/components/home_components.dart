import 'package:flutter/material.dart';
import 'package:project_flutter/bloc/home_bloc.dart';
import 'package:project_flutter/pages/gifts_page/gifts_page.dart';
import 'package:project_flutter/pages/home_page/model/products_home_model.dart';
import 'package:project_flutter/pages/login_page/login_page.dart';
import 'package:project_flutter/pages/products_page/model/product_request_model.dart';
import 'package:project_flutter/pages/products_page/products_page.dart';
import 'package:project_flutter/pages/profile_user_page/profile_user_page.dart';
import 'package:project_flutter/utils/colors_util.dart';
import 'package:project_flutter/utils/convert_color_util.dart';
import 'package:project_flutter/utils/enum_util.dart';
import 'package:project_flutter/utils/shared_preference_util.dart';
import 'package:project_flutter/utils/size_util.dart';
import 'package:project_flutter/utils/url_util.dart';

class HomeComponents{
  Widget switchPage({required SelectedNavigationBar selected, required HomeBloc bloc, String? token, required BuildContext context}) {
    switch (selected) {
      case SelectedNavigationBar.home:
        bloc.productsApiBloc(context: context, bloc: bloc, body: ProductRequestModel(page: '1', limit: UrlUtil.limitPage, categoryId: 0 ));
        return ProductsPage(bloc: bloc);
      case SelectedNavigationBar.gift:
        if(token != null && token != ''){
          return GiftPage(bloc: bloc);
        }else{
          return LoginPage(homeBloc: bloc, loginTypeEnum: LoginTypeEnum.normal,);
        }
      case SelectedNavigationBar.profile:
         if(token != null && token != ''){
           return ProfileUserPage(homeBloc: bloc);
         }else{
           return LoginPage(homeBloc: bloc, loginTypeEnum: LoginTypeEnum.normal);
         }
      default:
        return Container();
    }
  }


  Widget buildButtonNavigationBar({Function(SelectedNavigationBar)? onItemTapped, required Stream<SelectedNavigationBar> streamSelectedIndex}){
    return StreamBuilder<SelectedNavigationBar>(
      stream: streamSelectedIndex,
      builder: (context, snapshotSelected) {
        if(snapshotSelected.data == null){
          return Container();
        }
        return BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Trang chủ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard),
              label: 'Quà tặng',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Tài khoản',
            ),
          ],
          currentIndex: snapshotSelected.data!.index,
          selectedItemColor: ConvertColorUtil(ColorsUtil.colorApp),
          onTap: (int index){
            onItemTapped!(SelectedNavigationBar.values[index]);
          },
        );
      }
    );

  }

}