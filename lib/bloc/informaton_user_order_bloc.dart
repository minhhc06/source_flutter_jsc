import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_flutter/bloc/provider/information_user_order_provider.dart';
import 'package:project_flutter/pages/informaton_user_order_page/model/province_model.dart';
import 'package:project_flutter/utils/base_bloc.dart';
import 'package:project_flutter/utils/base_model_api.dart';
import 'package:project_flutter/utils/colors_util.dart';
import 'package:project_flutter/utils/custom_dialog.dart';
import 'package:project_flutter/utils/enum_util.dart';
import 'package:project_flutter/utils/url_util.dart';
import 'package:project_flutter/utils/words_util.dart';
import 'package:rxdart/rxdart.dart';

class InformationUserOrderBloc extends BaseBloc{
  InformationUserOrderBloc(){
    setDistrictsAll([]);
  }

  BehaviorSubject<List<ProvinceModel>> _setProvince =
  BehaviorSubject<List<ProvinceModel>>();

  Stream<List<ProvinceModel>> get getProvince => _setProvince.stream;

  setProvince(List<ProvinceModel> list) {
    _setProvince.sink.add(list);
  }

  BehaviorSubject<ProvinceModel> _setProvinceSelected =
  BehaviorSubject<ProvinceModel>();

  Stream<ProvinceModel> get getProvinceSelected => _setProvinceSelected.stream;

  setProvinceSelected({required ProvinceModel model}) async {
    _setProvinceSelected.sink.add(model);

  }

  BehaviorSubject<List<ProvinceModel>> _setDistrict = BehaviorSubject<List<ProvinceModel>>();
  Stream<List<ProvinceModel>> get getDistrict => _setDistrict.stream;

  setDistrict(List<ProvinceModel> list) {
    _setDistrict.sink.add(list);
  }

  BehaviorSubject<List<ProvinceModel>> _setWard = BehaviorSubject<List<ProvinceModel>>();
  Stream<List<ProvinceModel>> get getWard => _setWard.stream;

  setWard(List<ProvinceModel> list) {
    _setWard.sink.add(list);
  }



  BehaviorSubject<List<ProvinceModel>> _setDistrictsAll =
  BehaviorSubject<List<ProvinceModel>>();
  Stream<List<ProvinceModel>> get getDistrictsAll => _setDistrictsAll.stream;

  setDistrictsAll(List<ProvinceModel> list) {
    _setDistrictsAll.sink.add(list);
  }

  BehaviorSubject<List<ProvinceModel>> _setWardsAll =
  BehaviorSubject<List<ProvinceModel>>();
  Stream<List<ProvinceModel>> get getWardsAll => _setWardsAll.stream;

  setWardsAll(List<ProvinceModel> list) {
    _setWardsAll.sink.add(list);
  }

  BehaviorSubject<ProvinceModel> _setDistrictSelected =
  BehaviorSubject<ProvinceModel>();
  Stream<ProvinceModel> get getDistrictSelected => _setDistrictSelected.stream;

  setDistrictSelected({required ProvinceModel model}) async {
    _setDistrictSelected.sink.add(model);
  }


  BehaviorSubject<ProvinceModel> _setWardSelected =
  BehaviorSubject<ProvinceModel>();
  Stream<ProvinceModel> get getWardSelected => _setWardSelected.stream;

  setWardSelected({required ProvinceModel model}) {
    _setWardSelected.sink.add(model);
  }

  updateBlocWardSelected({required ProvinceModel model}) {
    model.code = -1;
    _setWardSelected.sink.add(model);
  }

  requestAddressApiApiBloc({
    required BuildContext context, required SelectAddress selectAddress
  }) async {
    setIsLoadingUtil(isLoading: true);
    switch(selectAddress){
      case SelectAddress.province:
        if(_setProvinceSelected.stream.hasValue){
          var model = _setProvinceSelected.stream.value;
          setProvinceSelected(model: model);
          var district = _setDistrictSelected.stream.value;
          district.code = -1;
          _setDistrictSelected.sink.add(district);
          return model;
        }
        break;
      case SelectAddress.district:
        if(_setDistrictSelected.stream.hasValue){
          var model = _setDistrictSelected.stream.value;
          if( model.code != -1){
            setDistrictSelected(model: model);
            return model;
          }

        }
        break;
      case SelectAddress.ward:
        if(_setWardSelected.stream.hasValue){

          var model = _setWardSelected.stream.value;
          if(model.code != -1){
            setWardSelected(model: model);
            return model;
          }

        }
        break;
    }


    BaseModelApi? result = await InformationUserOrderProvider()
        .requestAddressApiProvider(context: context, url: selectAddress.nameApi!);
    switch (result!.statusCode) {
      case 200:
        List<ProvinceModel> listModel = [];
        json.decode(result.body).forEach((v) {
          listModel.add(ProvinceModel.fromJson(v));
        });

        switch(selectAddress){
          case SelectAddress.province:
              setProvince(listModel);

            break;
          case SelectAddress.district:
            var provinceCode = _setProvinceSelected.stream.value;
            List<ProvinceModel> listDistricts = [];
            for (var value in listModel) {
              if (value.province_code == provinceCode.code) {
                listDistricts.add(new ProvinceModel(
                    name: value.name,
                    code: value.code,
                    division_type: value.division_type,
                    codename: value.codename,
                    province_code: value.province_code,
                    district_code: value.district_code));
              }
            }

            if(_setWardSelected.stream.hasValue){
              var ward = _setWardSelected.stream.value;
              ward.code = -1;
              _setWardSelected.sink.add(ward);
            }

            setDistrict(listDistricts);

            break;
          case SelectAddress.ward:
            var districtCode = _setDistrictSelected.stream.value;
            List<ProvinceModel> listWards = [];
            for (var value in listModel) {
              if (value.district_code == districtCode.code) {
                listWards.add(new ProvinceModel(
                    name: value.name,
                    code: value.code,
                    division_type: value.division_type,
                    codename: value.codename,
                    province_code: value.province_code,
                    district_code: value.district_code));
              }
            }

            setWard(listWards);
            break;
        }
        setIsLoadingUtil(isLoading: false);
        break;

      default:
        setIsLoadingUtil(isLoading: false);
        CustomDialog().dialogNotification(
            context: context,
            title: WordsUtil.someError,
            description: WordsUtil.checkAgain,
            buttonTitle: WordsUtil.tryAgain,
            listColors: [
              ColorsUtil.colorOnTopGreen,
              ColorsUtil.colorDownBottomGreen,
            ],
            function: (BuildContext contextDialog) {
              Navigator.pop(contextDialog);

            });

        break;
    }
  }

}