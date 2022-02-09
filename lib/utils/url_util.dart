class UrlUtil{
  /// test
  static const String domain = 'http://vantaiphyphy.com/api';
  static const String domainWthParam = 'vantaiphyphy.com';

  ///production


  /// domain
  static const String domainAddressApi = 'https://provinces.open-api.vn/api';

  static const String urlProvince = 'p';
  static const String urlDistrict = 'd';
  static const String urlWards = 'w';

  static const String signUp = 'auth/signup';
  static const String signIn = 'auth/signin';
  static const String getUser = 'auth/getUser';
  static const String products = 'product';
  static const String productsCategories = 'product-category/get-product-categories';
  static const String cart = 'cart';
  static const String order = 'order';
  static const String totalCart = 'cart/get-total-cart';
  static const String fetchOrderItem = 'order/fetch-order-item';



  /// status
  static const int statusSuccess = 201;
  static const int statusSuccessCreated = 200;
  static const int statusInCorrect = 400;
  static const int statusTimeOut = 408;
  static const int statusExpired = 400;
  static const int statusNotFount = 404;
  static const int statusLockedAccount = 403;
  static const String timeOut = 'TIMEOUT';
  static const String tokenExpired = 'TokenExpired';

  static const String limitPage = '20';
}