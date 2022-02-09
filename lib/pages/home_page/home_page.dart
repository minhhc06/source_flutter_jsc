import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/bloc/home_bloc.dart';
import 'package:project_flutter/pages/cart_page/cart_page.dart';
import 'package:project_flutter/pages/home_page/components/home_components.dart';
import 'package:project_flutter/pages/home_page/model/products_home_model.dart';
import 'package:project_flutter/pages/login_page/login_page.dart';
import 'package:project_flutter/pages/login_page/model/get_user_response_api_model.dart';
import 'package:project_flutter/utils/base_components.dart';
import 'package:project_flutter/utils/colors_util.dart';
import 'package:project_flutter/utils/convert_color_util.dart';
import 'package:project_flutter/utils/enum_util.dart';
import 'package:project_flutter/utils/shared_preference_util.dart';
import 'package:project_flutter/utils/size_util.dart';
import 'package:project_flutter/utils/words_util.dart';

class HomePage extends StatefulWidget {
  final HomeBloc bloc;
  const HomePage({Key? key, required this.bloc}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with BaseComponents {
  // late HomeBloc bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // bloc = HomeBloc();
    // bloc.requestGetUserApiBloc(context: context);

  }



  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SelectedNavigationBar>(
      stream: widget.bloc.getSelectedBar,
      builder: (context, snapshotSelected) {
        if(snapshotSelected.data == null){
          return Container();
        }
        return Scaffold(
          body: StreamBuilder<String>(
            stream: widget.bloc.getToken,
            builder: (context, snapshotToken) {
              return HomeComponents().switchPage(selected: snapshotSelected.data!, bloc: widget.bloc, token: snapshotToken.data, context: context);
            }
          ),
          bottomNavigationBar: HomeComponents().buildButtonNavigationBar(
              streamSelectedIndex: widget.bloc.getSelectedBar, onItemTapped: (SelectedNavigationBar selected) async {
            String? token = await SharedPreferenceUtil().getStringSharePreference(key:
            SharedPreferenceUtil.accessToken);
            if(token != null){
              widget.bloc.setToken(token);
            }
            widget.bloc.setSelectedBar(selected);

          }),
        );
      }
    );
  }
}
