import 'package:flutter/material.dart';
import 'package:project_flutter/bloc/home_bloc.dart';
import 'package:project_flutter/pages/home_page/model/products_home_model.dart';
import 'package:project_flutter/utils/base_components.dart';
import 'package:project_flutter/utils/colors_util.dart';
import 'package:project_flutter/utils/convert_color_util.dart';

class GiftPage extends StatefulWidget {
  final HomeBloc bloc;
  const GiftPage({Key? key, required this.bloc}) : super(key: key);

  @override
  _GiftPageState createState() => _GiftPageState();
}

class _GiftPageState extends State<GiftPage>  with BaseComponents{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ưu đãi'),
        backgroundColor: ConvertColorUtil(ColorsUtil.colorApp),
      ),
      body:  StreamBuilder<List<ProductHomeModel>>(
          stream: widget.bloc.getListProducts,
          builder: (context, snapshot) {
            if(snapshot.data == null){
              return Container();
            }
            return Center(
              child: Text('Chức năng sẽ sớm được cập nhật',
            ));
          }
      ),
    );
  }
}
