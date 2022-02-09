import 'package:flutter/material.dart';
import 'package:project_flutter/bloc/home_bloc.dart';
import 'package:project_flutter/bloc/informaton_user_order_bloc.dart';
import 'package:project_flutter/pages/confirm_order_page/confirm_order_page.dart';
import 'package:project_flutter/pages/informaton_user_order_page/components/address_component.dart';
import 'package:project_flutter/pages/informaton_user_order_page/components/information_user_order_components.dart';
import 'package:project_flutter/utils/base_components.dart';
import 'package:project_flutter/utils/enum_util.dart';
import 'package:project_flutter/utils/model/create_order_request_model.dart';
import 'package:project_flutter/utils/size_util.dart';
import 'package:project_flutter/utils/words_util.dart';

class InformationUserOrderPage extends StatefulWidget {
  final CreateOrderRequestModel requestApiModel;
  final HomeBloc homeBloc;
  const InformationUserOrderPage({Key? key, required this.requestApiModel, required this.homeBloc}) : super(key: key);

  @override
  _InformationUserOrderPageState createState() => _InformationUserOrderPageState();
}

class _InformationUserOrderPageState extends State<InformationUserOrderPage> with BaseComponents {
  TextEditingController cityController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController wardController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


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
      appBar: appbarBuild(title: 'Thông tin nhận hàng', context: context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SizeUtil.padding16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                textFromFieldUtil(controller: fullNameController, hintText: 'Nhập tên người nhận',
                    title: 'Tên người nhận', textInputAction:  TextInputAction.next,
                    onChanged: (String value){

                    },
                    validate: (String value){
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập tên người nhận';
                      }
                      return null;
                    }
                    ),

                textFromFieldUtil(controller: phoneNumberController, hintText: 'Nhập số điện thoại người nhận',
                    title: 'Số điện thoại người nhận', textInputAction:  TextInputAction.next, textInputType: TextInputType.number,
                    onChanged: (String value){

                    },
                    validate: (String value){
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập số điện thoại người nhận';
                      }
                      return null;
                    }),

                textFromFieldUtil(controller: addressController, hintText: 'Nhập địa chỉ nhận hàng',
                    title: 'Địa chỉ nhận hàng', textInputAction:  TextInputAction.next,onChanged: (String value){

                    },
                    validate: (String value){
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập địa chỉ nhận hàng';
                      }
                      return null;
                    }),

                InformationUserOrderComponents().textFromFieldAddress(controller: cityController,
                    iconButtonSuffixIcon: IconButton(onPressed: (){

                    }, icon: Icon(Icons.keyboard_arrow_down)),
                    hintText: 'Vui lòng chọn thành phố', title: 'Chọn thành phố', textInputAction: TextInputAction.next, context: context,
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
                        return 'Vui lòng chọn tỉnh/ thành phố';
                      }
                      return null;
                    }),
                InformationUserOrderComponents().textFromFieldAddress(controller: districtController,
                    iconButtonSuffixIcon: IconButton(onPressed: (){

                    }, icon: Icon(Icons.keyboard_arrow_down)),
                    hintText: 'Vui lòng chọn quận/ huyện', title: 'Chọn quận/ huyện', textInputAction: TextInputAction.next, context: context,
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
                        return 'Vui lòng chọn quận/ huyện';
                      }
                      return null;
                    }),
                InformationUserOrderComponents().textFromFieldAddress(controller: wardController,
                    iconButtonSuffixIcon: IconButton(onPressed: (){

                    }, icon: Icon(Icons.keyboard_arrow_down)),
                    hintText: 'Vui lòng chọn phường/ xã', title: 'Chọn phường/ xã', textInputAction: TextInputAction.next, context: context,
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
                        bloc.updateBlocWardSelected(model: result);
                        wardController.text = result.toString();
                      }

                    },
                    validate: (String value){
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng chọn phường/ xã';
                      }
                      return null;
                    }),
                SizedBox(
                  height: SizeUtil.padding16,
                ),
                Row(
                  children: [
                    Expanded(child: buttonUtil(title: 'Tiếp tục', handleOnPress: (){
                      if (_formKey.currentState!.validate()) {
                        widget.requestApiModel.name_receiver = fullNameController.text;
                        widget.requestApiModel.phone_number = phoneNumberController.text;
                        widget.requestApiModel.address = addressController.text;
                        widget.requestApiModel.city = cityController.text;
                        widget.requestApiModel.district = districtController.text;
                        widget.requestApiModel.ward = wardController.text;

                        print(widget.requestApiModel);

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              ConfirmOrderPage(requestApiModel: widget.requestApiModel,
                                homeBloc: widget.homeBloc,)),
                        );
                      }


                    })),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
