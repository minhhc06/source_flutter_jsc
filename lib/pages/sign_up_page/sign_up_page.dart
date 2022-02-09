import 'package:flutter/material.dart';
import 'package:project_flutter/bloc/sign_up_bloc.dart';
import 'package:project_flutter/pages/informaton_user_order_page/components/address_component.dart';
import 'package:project_flutter/pages/informaton_user_order_page/components/information_user_order_components.dart';
import 'package:project_flutter/pages/sign_up_page/components/sign_up_components.dart';
import 'package:project_flutter/pages/sign_up_page/model/sign_in_request_api_model.dart';
import 'package:project_flutter/utils/base_components.dart';
import 'package:project_flutter/utils/colors_util.dart';
import 'package:project_flutter/utils/convert_color_util.dart';
import 'package:project_flutter/utils/enum_util.dart';
import 'package:project_flutter/utils/size_util.dart';
import 'package:project_flutter/utils/words_util.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with BaseComponents {
  final _formKey = GlobalKey<FormState>();
  late SignUpBloc bloc;

  // final fullNameController = TextEditingController(text: 'minh');
  // final phoneNumberController = TextEditingController(text: '0987654312');
  // final emailController = TextEditingController(text: 'minh12@gmail.com');
  // final addressController = TextEditingController(text: '123 address');
  // final companyController = TextEditingController(text: 'company 1');
  // final taxCodeController = TextEditingController(text: '12345');
  // final groupController = TextEditingController(text: 'ccd');
  // final provincesController = TextEditingController(text: 'Ho Chi Minh');
  // final districtsController = TextEditingController(text: 'quan 5');
  // final wardsController = TextEditingController(text: 'phuong 6');
  // final noteController = TextEditingController(text: 'note');

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  TextEditingController cityController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController wardController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  late String category;


  @override
  void initState() {
    super.initState();
    bloc = new SignUpBloc();

    //  fullNameController = TextEditingController(text: 'Minh hc 7');
    //  phoneNumberController = TextEditingController(text: '0987654312');
    //  emailController = TextEditingController(text: 'minhhc7@gmail.com');
    // passwordController = TextEditingController(text: '123456');
    //  addressController = TextEditingController(text: '123 address');
    //
    // cityController = TextEditingController(text: 'Ho Chi Minh');
    // districtController = TextEditingController(text: 'quan 5');
    // wardController = TextEditingController(text: 'phuong 6');
    //  noteController = TextEditingController(text: 'note');

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: StreamBuilder<bool>(
            stream: bloc.getIsLoadingUtil,
            builder: (context, snapshotIsLoading) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(SizeUtil.padding16),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [

                            Text(
                              WordsUtil.signUpTitle,
                              style: TextStyle(
                                  color: ConvertColorUtil(ColorsUtil.colorApp),
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(SizeUtil.padding8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    WordsUtil.doYouHave,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(
                                    height: SizeUtil.padding16,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      WordsUtil.signIn,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: ConvertColorUtil(ColorsUtil.colorApp)),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            textFromFieldUtil(
                                controller: phoneNumberController,
                                onChanged: (String text){

                                },
                                textInputType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                title: WordsUtil.titleInputPhoneNumber,
                                hintText: WordsUtil.inputPhoneNumber,
                                validate: (value) {
                                  return SignUpComponents().validateMobile(value);
                                }),

                            textFromFieldUtil(
                                controller: fullNameController,
                                onChanged: (String text){

                                },
                                textInputAction: TextInputAction.next,
                                title: WordsUtil.titleFullName,
                                hintText: WordsUtil.inputFullName,
                                validate: (value) {
                                  if (value.trim() != '') {
                                    return null;
                                  } else {
                                    return '${WordsUtil.validateInputFullName}';
                                  }
                                }),


                            textFromFieldUtil(
                                controller: emailController,
                                onChanged: (String text){

                                },
                                textInputAction: TextInputAction.next,
                                title: WordsUtil.email,
                                hintText: WordsUtil.emailInput,
                                validate: (value) {
                                  if (value.trim() != '') {
                                    if (SignUpComponents().validateEmail(value) ==
                                        false) {
                                      return WordsUtil.emailWrongForm;
                                    }
                                    return null;
                                  } else {
                                    return '${WordsUtil.emailInputValidate}';
                                  }
                                }),


                            textFromFieldUtil(
                                controller: passwordController,
                                onChanged: (String text){

                                },
                                textInputAction: TextInputAction.next,
                                title: WordsUtil.inputPassword,
                                hintText: WordsUtil.inputPassword,
                                validate: (value) {
                                  if (value.trim() != '') {
                                    return null;
                                  } else {
                                    return '${WordsUtil.validateInputPassword}';
                                  }
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

                            textFromFieldUtil(controller: addressController, hintText: 'Nhập địa chỉ nhận hàng',
                                title: 'Địa chỉ nhận hàng', textInputAction:  TextInputAction.next,onChanged: (String value){

                                },
                                validate: (String value){
                                  if (value == null || value.isEmpty) {
                                    return 'Vui lòng nhập địa chỉ nhận hàng';
                                  }
                                  return null;
                                }),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: SizeUtil.padding32),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: buttonUtil(
                                          title: WordsUtil.signUp,
                                          handleOnPress: () {

                                            FocusScope.of(context).unfocus();

                                            if (_formKey.currentState!.validate()) {
                                              bloc.requestSignInApiBloc(context: context,
                                                  model:
                                              new SignInRequestApiModel(
                                                  username: phoneNumberController.text,
                                                  email: emailController.text,
                                                  password: passwordController.text,
                                                  fullName: fullNameController.text,
                                                  address: addressController.text,
                                                  city: cityController.text,
                                                  district: districtController.text,
                                                  ward: wardController.text,
                                              avatar: 'N/A'));

                                            }
                                          }))
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                  snapshotIsLoading.data == true ?processingUtil(true) : Container()
                ],
              );
            }
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // bloc.dispose();
    fullNameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    addressController.dispose();

    super.dispose();
  }
}
