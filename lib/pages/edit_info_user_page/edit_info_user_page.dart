import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/bloc/informaton_user_order_bloc.dart';
import 'package:project_flutter/pages/informaton_user_order_page/components/address_component.dart';
import 'package:project_flutter/pages/informaton_user_order_page/components/information_user_order_components.dart';
import 'package:project_flutter/utils/base_components.dart';
import 'package:project_flutter/utils/enum_util.dart';
import 'package:project_flutter/utils/size_util.dart';
import 'package:project_flutter/utils/words_util.dart';

class EditInfoUserPage extends StatefulWidget {
  const EditInfoUserPage({Key? key}) : super(key: key);

  @override
  _EditInfoUserPageState createState() => _EditInfoUserPageState();
}

class _EditInfoUserPageState extends State<EditInfoUserPage> with BaseComponents {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController wardController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  late InformationUserOrderBloc bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = InformationUserOrderBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarBuild(title: 'Chỉnh sửa thông tin', context: context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SizeUtil.padding16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(SizeUtil.padding32),
                child: Center(
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        width: 100,
                        height: 100,
                        imageUrl: "https://www.sgv.edu.vn/uploads/images/info/ong-gia-noel-co-that-khong.png",
                        placeholder: (context, url) => Container(
                          color: Colors.grey,
                        ),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),

                      Positioned(
                        top: SizeUtil.padding4,
                        right: SizeUtil.padding8,
                          child: Icon(Icons.edit, color: Colors.white,))

                    ],
                  ),
                ),
              ),

              textFromFieldUtil(onChanged: (String value){

              },
                  controller:
                  fullNameController,
                  textInputAction:
                  TextInputAction.next,
                  title: WordsUtil
                      .titleFullName,
                  hintText: WordsUtil
                      .inputFullName,
                  validate: (value) {
                    if (value != '') {
                      return null;
                    } else {
                      return '${WordsUtil.inputFullName}';
                    }
                  }),

              textFromFieldUtil(onChanged: (String value){

              },
                  controller:
                  phoneNumberController,
                  textInputAction:
                  TextInputAction.next,
                  title: WordsUtil
                      .titlePhoneNumber,
                  hintText: WordsUtil
                      .inputPhoneNumber,
                  validate: (value) {
                    if (value != '') {
                      return null;
                    } else {
                      return '${WordsUtil.inputPhoneNumber}';
                    }
                  }),

              InformationUserOrderComponents().textFromFieldAddress(controller: cityController,
                  iconButtonSuffixIcon: IconButton(onPressed: (){

                  }, icon: Icon(Icons.keyboard_arrow_down)),
                  hintText: WordsUtil.pleaseSelectCity, title: WordsUtil.selectCity, textInputAction: TextInputAction.next, context: context,
                  onPressHandle: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddressComponent(
                            bloc: bloc,
                            streamList: bloc.getProvince,
                            streamSelected: bloc.getProvinceSelected,
                            selectAddress: SelectAddress.province,
                          )),
                    );

                    if (result != null) {
                      bloc.setProvinceSelected(model: result);
                      cityController.text = result.toString();
                    }

                  },
                  validate: (String value){
                    if (value == null || value.isEmpty) {
                      return WordsUtil.pleaseSelectCity;
                    }
                    return null;
                  }),

              InformationUserOrderComponents().textFromFieldAddress(controller: districtController,
                  iconButtonSuffixIcon: IconButton(onPressed: (){

                  }, icon: Icon(Icons.keyboard_arrow_down)),
                  hintText: WordsUtil.pleaseSelectDistrict, title: WordsUtil.selectDistrict, textInputAction: TextInputAction.next, context: context,
                  onPressHandle: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddressComponent(
                            bloc: bloc,
                            streamList: bloc.getDistrict,
                            streamSelected: bloc.getDistrictSelected,
                            selectAddress: SelectAddress.district,
                          )),
                    );

                    if (result != null) {
                      bloc.setDistrictSelected(model: result);
                      districtController.text = result.toString();
                    }

                  },
                  validate: (String value){
                    if (value == null || value.isEmpty) {
                      return WordsUtil.pleaseSelectDistrict;
                    }
                    return null;
                  }),
              InformationUserOrderComponents().textFromFieldAddress(controller: wardController,
                  iconButtonSuffixIcon: IconButton(onPressed: (){

                  }, icon: Icon(Icons.keyboard_arrow_down)),
                  hintText: WordsUtil.pleaseSelectWard, title: WordsUtil.selectWard, textInputAction: TextInputAction.next, context: context,
                  onPressHandle: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddressComponent(
                            bloc: bloc,
                            streamList: bloc.getWard,
                            streamSelected: bloc.getWardSelected,
                            selectAddress: SelectAddress.ward,
                          )),
                    );

                    if (result != null) {
                      bloc.setWardSelected(model: result);
                      wardController.text = result.toString();
                    }

                  },
                  validate: (String value){
                    if (value == null || value.isEmpty) {
                      return WordsUtil.pleaseSelectCity;
                    }
                    return null;
                  }),

              textFromFieldUtil(onChanged: (String value){

              },
                  controller:
                  addressController,
                  textInputAction:
                  TextInputAction.next,
                  title: WordsUtil
                      .titleAddress,
                  hintText: WordsUtil
                      .inputAddress,
                  validate: (value) {
                    if (value != '') {
                      return null;
                    } else {
                      return '${WordsUtil.inputAddress}';
                    }
                  }),

              Row(
                children: [
                  Expanded(child: buttonUtil(title: 'Cập nhật'))
                ],
              )



            ],
          ),
        ),
      ),
    );
  }
}
