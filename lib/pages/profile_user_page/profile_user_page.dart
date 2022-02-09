import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/bloc/home_bloc.dart';
import 'package:project_flutter/pages/edit_info_user_page/edit_info_user_page.dart';
import 'package:project_flutter/pages/history_order_page/history_order_page.dart';
import 'package:project_flutter/pages/login_page/model/get_user_response_api_model.dart';
import 'package:project_flutter/pages/presenter_page/presenter_page.dart';
import 'package:project_flutter/utils/base_components.dart';
import 'package:project_flutter/utils/colors_util.dart';
import 'package:project_flutter/utils/convert_color_util.dart';
import 'package:project_flutter/utils/shared_preference_util.dart';
import 'package:project_flutter/utils/size_util.dart';

class ProfileUserPage extends StatefulWidget {
  final HomeBloc homeBloc;
  const ProfileUserPage({Key? key, required this.homeBloc}) : super(key: key);

  @override
  _ProfileUserPageState createState() => _ProfileUserPageState();
}

class _ProfileUserPageState extends State<ProfileUserPage> with BaseComponents {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin'),
        backgroundColor: ConvertColorUtil(ColorsUtil.colorApp),
      ),
      body:  StreamBuilder<GetUserResponseApiModel>(
        stream: widget.homeBloc.getGetUser,
        builder: (context, snapshotGetUser) {
          if(snapshotGetUser.data == null){
            return Container();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 110,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: SizeUtil.padding16),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditInfoUserPage()),
                      );
                    },
                    child: Row(
                      children: [
                        Expanded(
                          flex:2,
                          child: CachedNetworkImage(
                            width: 80,
                            height: 80,
                            imageUrl: "https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png",
                            placeholder: (context, url) => Container(
                              color: Colors.grey,
                            ),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                        ),
                        SizedBox(width: SizeUtil.padding16,),
                        Expanded(
                          flex: 8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('${snapshotGetUser.data!.userInfo.fullname}', style: TextStyle(fontSize: 20),),
                              Text('${snapshotGetUser.data!.userInfo.username}', style: TextStyle(color: Colors.grey),)
                            ],
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios, color: Colors.grey,)
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: SizeUtil.padding16,),

              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(SizeUtil.padding16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Điểm tích lũy: '),
                          Text('${snapshotGetUser.data!.userInfo.coin} coin', style: TextStyle(color: Colors.blueAccent[700]),),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: SizeUtil.padding16),
                        child: Container(
                          color: Colors.grey,
                          height: 1,
                          width: double.infinity,
                        ),
                      ),

                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HistoryOrderPage()),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(Icons.article, color: Colors.blueAccent[700],),
                            SizedBox(width: SizeUtil.padding16,),
                            Text('Đơn hàng của tôi')
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: SizeUtil.padding16),
                        child: Container(
                          color: Colors.grey,
                          height: 1,
                          width: double.infinity,
                        ),
                      ),

                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PresenterPage()),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(Icons.mail, color: Colors.green[700]),
                            SizedBox(width: SizeUtil.padding16,),
                            Text('Nhập số điện thoại người giới thiệu')
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: SizeUtil.padding16),
                        child: Container(
                          color: Colors.grey,
                          height: 1,
                          width: double.infinity,
                        ),
                      ),

                      Row(
                        children: [
                          Icon(Icons.call, color: Colors.orange[700]),
                          SizedBox(width: SizeUtil.padding16,),
                          Text('Liên hệ với admin')
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: SizeUtil.padding16),
                        child: Container(
                          color: Colors.grey,
                          height: 1,
                          width: double.infinity,
                        ),
                      ),

                      GestureDetector(
                        onTap: () async {
                          await SharedPreferenceUtil()
                              .removeStringSharePreference(
                              key: SharedPreferenceUtil.accessToken);
                          widget.homeBloc.setToken('');
                          widget.homeBloc.updateBlocSwitchPage();
                        },
                        child: Row(
                          children: [
                            Icon(Icons.logout, color: Colors.red,),
                            SizedBox(width: SizeUtil.padding16,),
                            Text('Đăng xuất')
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),




            ],
          );
        }
      ),
    );
  }
}
