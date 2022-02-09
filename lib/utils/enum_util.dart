import 'package:project_flutter/utils/colors_util.dart';
import 'package:project_flutter/utils/url_util.dart';
import 'package:project_flutter/utils/words_util.dart';

enum SelectedNavigationBar { home, gift, profile }



extension SelectedNavigationBarExtension on SelectedNavigationBar {
  int? get indexSelected {
    switch (this) {
      case SelectedNavigationBar.home:
        return 0;
      case SelectedNavigationBar.gift:
        return 1;
      case SelectedNavigationBar.profile:
        return 2;
      default:
        return null;
    }
  }
}

enum SelectAddress { province, district, ward }
extension addressExtension on SelectAddress {
  String? get addressUrlApi {
    switch (this) {
      case SelectAddress.province:
        return UrlUtil.urlProvince;
      case SelectAddress.district:
        return UrlUtil.urlDistrict;
      case SelectAddress.ward:
        return UrlUtil.urlWards;
      default:
        return null;
    }
  }

  String? get title {
    switch (this) {
      case SelectAddress.province:
        return WordsUtil.province;
      case SelectAddress.district:
        return WordsUtil.district;
      case SelectAddress.ward:
        return WordsUtil.wardAddress;
      default:
        return null;
    }
  }

  String? get nameApi {
    switch (this) {
      case SelectAddress.province:
        return UrlUtil.urlProvince;
      case SelectAddress.district:
        return UrlUtil.urlDistrict;
      case SelectAddress.ward:
        return UrlUtil.urlWards;
      default:
        return null;
    }
  }

}

enum AddressEnum { city, district, ward }
enum LoginTypeEnum { normal, cart, detail }
enum CartTypeEnum { normal, detail }

enum StatusOrder {all, processing, onDelivering, payOff, failed }

extension statusOrderExtension on StatusOrder {
  String? get titleTabBar {
    switch (this) {
      case StatusOrder.all:
        return WordsUtil.all;
      case StatusOrder.processing:
        return WordsUtil.processingStatus;
      case StatusOrder.onDelivering:
        return WordsUtil.onDeliveringStatus;
      case StatusOrder.payOff:
        return WordsUtil.payOffStatus;
      case StatusOrder.failed:
        return WordsUtil.failStatus;
      default:
        return null;
    }
  }

  String? get statusRequest {
    switch (this) {
      case StatusOrder.all:
        return null;
      case StatusOrder.processing:
        return WordsUtil.processing;
      case StatusOrder.onDelivering:
        return WordsUtil.onDelivering;
      case StatusOrder.payOff:
        return WordsUtil.payOff;
      case StatusOrder.failed:
        return WordsUtil.failed;
      default:
        return null;
    }
  }

}

enum StatusOrderItem {processing, onDelivering, payOff, failed }

int setIndexStatusOrderItem(String status){
  switch(status){
    case WordsUtil.processing:
      return 0;
    case WordsUtil.onDelivering:
      return 1;
    case WordsUtil.payOff:
      return 2;
    case WordsUtil.failed:
      return 3;
    default:
      return 0;
  }
}

extension StatusOrderItemExtension on StatusOrderItem {
  String? get titleStatus {
    switch (this) {
      case StatusOrderItem.processing:
        return WordsUtil.processingStatus;
      case StatusOrderItem.onDelivering:
        return WordsUtil.onDeliveringStatus;
      case StatusOrderItem.payOff:
        return WordsUtil.payOffStatus;
      case StatusOrderItem.failed:
        return WordsUtil.failStatus;
      default:
        return null;
    }
  }

  String? get colorStatus {
    switch (this) {
      case StatusOrderItem.processing:
        return ColorsUtil.green;
      case StatusOrderItem.onDelivering:
        return ColorsUtil.blue;
      case StatusOrderItem.payOff:
        return ColorsUtil.orange;
        case StatusOrderItem.failed:
        return ColorsUtil.red;
      default:
        return null;
    }
  }

}

