
import 'package:flutter/material.dart';
import 'package:project_flutter/bloc/history_order_bloc.dart';
import 'package:project_flutter/pages/history_order_page/components/history_order_components.dart';
import 'package:project_flutter/pages/history_order_page/model/history_order_model.dart';
import 'package:project_flutter/pages/history_order_page/model/request_fetch_order_item_model.dart';
import 'package:project_flutter/utils/base_components.dart';
import 'package:project_flutter/utils/colors_util.dart';
import 'package:project_flutter/utils/convert_color_util.dart';
import 'package:project_flutter/utils/enum_util.dart';
import 'package:project_flutter/utils/size_util.dart';
import 'package:project_flutter/utils/url_util.dart';

class HistoryOrderPage extends StatefulWidget {
  const HistoryOrderPage({Key? key}) : super(key: key);

  @override
  _HistoryOrderPageState createState() => _HistoryOrderPageState();
}

class _HistoryOrderPageState extends State<HistoryOrderPage> with BaseComponents {
  late HistoryOrderBloc bloc;
  late int page = 1;
  late int indexStatus = 0;
  late ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = new HistoryOrderBloc();
    bloc.fetchHistoryOrdersApiBloc(context: context,
        body: new RequestFetchOrderItem(page: '1', limit: UrlUtil.limitPage).toJson());
    _scrollController = new ScrollController();
    _scrollController.addListener(() {
      _scrollListener(_scrollController);
    });

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarBuild(title: 'Đơn hàng của tôi', context: context),
      body: Stack(
        children: [
          DefaultTabController(
            length: 5,
            child: Column(
              children: [
                TabBar(
                  isScrollable: true,
                  indicatorColor: ConvertColorUtil(ColorsUtil.colorApp),
                  labelColor: ConvertColorUtil(ColorsUtil.colorApp),
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(text: StatusOrder.all.titleTabBar),
                    Tab(text: StatusOrder.processing.titleTabBar),
                    Tab(text: StatusOrder.onDelivering.titleTabBar),
                    Tab(text: StatusOrder.payOff.titleTabBar),
                    Tab(text: StatusOrder.failed.titleTabBar),
                  ],
                  onTap: (int index){
                    indexStatus = index;
                    page = 1;
                    bloc.fetchHistoryOrdersApiBloc(context: context,
                        body: new RequestFetchOrderItem(page: '1', limit: UrlUtil.limitPage,
                            status: StatusOrder.values[indexStatus].statusRequest).toJson());
                  },
                ),
            Expanded(
              child: StreamBuilder<List<HistoryOrderModel>>(
                stream: bloc.getHistoryOrderModel,
                builder: (context, snapshotOrder) {
                  if(snapshotOrder.data == null){
                    return Container();
                  }
                  if(snapshotOrder.data!.length == 0){
                    return emptyLayout(title: 'Không có đơn nào', description: 'Xin cảm ơn');
                  }
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          controller: _scrollController,
                          shrinkWrap: true,
                            padding: const EdgeInsets.all(8),
                            itemCount: snapshotOrder.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return HistoryOrderComponents().buildListItems(model: snapshotOrder.data![index]);
                            }
                        ),
                      ),
                      StreamBuilder<bool>(
                        stream: bloc.getIsLoadingPagination,
                        builder: (context, snapshotIsLoadingPagination) {
                          return processingUtil(snapshotIsLoadingPagination.data);
                        }
                      ),
                      SizedBox(height: SizeUtil.padding64,)
                    ],
                  );
                }
              ),
            )

            ],
            ),
          ),
          StreamBuilder<bool>(
            stream: bloc.getIsLoadingUtil,
            builder: (context, snapshotIsLoading) {
              return processingUtil(snapshotIsLoading.data);
            }
          )
        ],
      ),
    );
  }

  void _scrollListener(ScrollController _controller) async {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      page++;
      bloc.fetchHistoryOrdersApiBloc(context: context,
          body: new RequestFetchOrderItem(page: page.toString(), limit: UrlUtil.limitPage,
              status: StatusOrder.values[indexStatus].statusRequest).toJson());
    }
  }

}
