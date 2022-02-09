import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:project_flutter/bloc/home_bloc.dart';
import 'package:project_flutter/pages/detail_page/detail_page.dart';
import 'package:project_flutter/pages/home_page/model/products_home_model.dart';
import 'package:project_flutter/utils/colors_util.dart';
import 'package:project_flutter/utils/convert_color_util.dart';
import 'package:project_flutter/utils/paths_util.dart';
import 'dart:math' as math;

import 'package:project_flutter/utils/size_util.dart';
import 'package:project_flutter/utils/words_util.dart';

class BaseComponents {
  AppBar appbarBuild({required String title, Function? functionBack, required BuildContext context}){
    return  AppBar(
        backgroundColor: ConvertColorUtil(ColorsUtil.colorApp),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          if(functionBack != null){
            functionBack();
          }else{
            // Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.pop(context);
          }
        },
      ),
      title: Text(title),
    );
  }

  Widget textFromFieldUtil(
      {required TextEditingController controller,
      double paddingSize = SizeUtil.padding8,
      required String hintText,
      required String title,
      bool isObscureText = false,
      bool isRequired = true,
      TextInputType textInputType = TextInputType.text,
      Color focusedBorderColor = ColorsUtil.blackColorBtn,
      Color enabledBorderColor = ColorsUtil.blackColorBtn,
      required TextInputAction textInputAction,
      IconButton? iconButtonSuffixIcon,
        required Function(String) onChanged,
      Function(String)? validate}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SizeUtil.padding8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '$title',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                isRequired == true ? " *" : "",
                style: TextStyle(color: Colors.red),
              )
            ],
          ),
          const SizedBox(
            height: SizeUtil.padding8,
          ),
          TextFormField(
            controller: controller,
            keyboardType: textInputType,
            textInputAction: textInputAction,
            obscureText: isObscureText,
            decoration:  InputDecoration(
              suffixIcon:
                  iconButtonSuffixIcon != null ? iconButtonSuffixIcon : null,
              hintText: '$hintText',
              contentPadding: EdgeInsets.only(left: SizeUtil.padding16),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(color: ColorsUtil.grayColor, width: 1.0),
              ),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  borderSide: BorderSide(color: Colors.red)),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                borderSide: BorderSide(color: ColorsUtil.grayColor, width: 1.0),
              ),
            ),
            onSaved: (value) async {
              // This optional block of code can be used to run
              // code when the user saves the form.
            },
            onChanged: (String value){
              onChanged(value);
            },
            validator: (value) {
              return validate!(value!);
            },
          ),
        ],
      ),
    );
  }

  Widget buttonUtil(
      {String title = '${WordsUtil.exit}',
      Color? background,
      Color titleColor = ColorsUtil.whiteColorBtn,
      Function? handleOnPress}) {
    return ElevatedButton(
      onPressed: () => handleOnPress!(),
      style: ElevatedButton.styleFrom(
          primary: background != null
              ? background
              : ConvertColorUtil((ColorsUtil.colorApp)),
          shape: RoundedRectangleBorder(

            borderRadius: BorderRadius.circular(SizeUtil.borderRadiusDefault),
          )),
      child: Padding(
        padding: const EdgeInsets.all(SizeUtil.padding16),
        child: Text(
          '$title',
          style: TextStyle(
              fontSize: 16, color: titleColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buttonOutlineUtil(
      {String title = '${WordsUtil.exit}',
      Color? background,
      TextStyle? titleStyle = const TextStyle(
          fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black),
      Function? handleOnPress}) {
    return Container(
        height: 35,
        child: ElevatedButton(
            onPressed: () => handleOnPress!(),
            style: ElevatedButton.styleFrom(
                primary: background != null
                    ? background
                    : Colors.green[ColorsUtil.colorGreen],
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black),
                  borderRadius:
                      BorderRadius.circular(SizeUtil.borderRadiusDefault),
                )),
            child: Text(
              '$title',
              style: titleStyle,
            )));
  }



  floatingComponent({
    required List<Widget> icons,
    List<String>? textIcons,
    List<String>? colorsBg,
    required List<Function> functions,
    required AnimationController controller,
    Color backgroundColor = Colors.white,
    required Function onPressFloatButton,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(icons.length, (int index) {
        Widget child =  Container(
          height: SizeUtil.heightContainerFloatingComponent,
          // width: DoubleUtil.widthContainerFloatingComponent,
          alignment: FractionalOffset.topCenter,
          child:  ScaleTransition(
            scale:  CurvedAnimation(
              parent: controller,
              curve:  Interval(0.0, 1.0 - index / icons.length / 2.0,
                  curve: Curves.easeOut),
            ),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(50),
                        ),
                        color: textIcons != null
                            ? Colors.black54
                            : Colors.transparent
                        // color: ConvertColorUtil(colorsBg![index])
                        ),
                    child: Text(
                      textIcons != null ? textIcons[index] : '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  FloatingActionButton(
                      heroTag: null,
                      backgroundColor: ConvertColorUtil(colorsBg![index]),
                      mini: true,
                      child: icons[index],
                      onPressed: () {
                        functions[index]();
                      }),
                ],
              ),
            ),
          ),
        );
        return child;
      }).toList()
        ..add(
          FloatingActionButton(
            backgroundColor: Colors.white,
            heroTag: null,
            child: AnimatedBuilder(
              animation: controller,
              builder: (BuildContext context, Widget? child) {
                return Transform(
                  transform:
                      Matrix4.rotationZ(controller.value * 0.5 * math.pi),
                  alignment: FractionalOffset.center,
                  child: Icon(
                    controller.isDismissed ? Icons.add : Icons.close,
                    color: Colors.green,
                  ),
                );
              },
            ),
            onPressed: () {
              onPressFloatButton();
            },
          ),
        ),
    );
  }

  String formatDay({required String date}) {
    if (date == '' || date.length < 1) return '';
    final dateGet = DateTime.parse(date).toUtc();
    return '${dateGet.day < 10 ? '0${dateGet.day}' : dateGet.day}/${dateGet.month < 10 ? '0${dateGet.month}' : dateGet.month}/${dateGet.year}';
  }

  String parseDateTime(String date){
    DateTime dateTime = DateTime.parse(date);
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  // Future<InternetStatus> checkInternet() async {
  //   try {
  //     final result = await InternetAddress.lookup('google.com')
  //         .timeout(const Duration(seconds: SizeUtil.TIME_OUT), onTimeout: () {
  //       throw 'Request Time Out';
  //     });
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       return InternetStatus.connected;
  //     } else {
  //       return InternetStatus.notconnected;
  //     }
  //   } on SocketException catch (_) {
  //     return InternetStatus.notconnected;
  //   }
  // }

  Widget emptyLayout({required String title, required String description}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(PathsUtil.empty),
          Text(
            title,
            style: TextStyle(fontSize: 17),
          ),
          Text(
            description,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  void showLoadingIndicator({required BuildContext context}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: CircularProgressIndicator(
              color: Colors.green,
          ),
        );
      },
    );
  }

  void dialogProcessing(
      {required BuildContext context,
      Color? backgroundColor,
      bool barrierDismissible = false}) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: barrierDismissible,
      barrierColor: Colors.black.withOpacity(SizeUtil.opacityDialogProcessing),
      // transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Center(
            child: Container(
              height: SizeUtil.heightDialogProcessing,
              width: SizeUtil.widthDialogProcessing,
              child: SizedBox.expand(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                backgroundColor:
                    backgroundColor != null ? backgroundColor : Colors.green,
              )),
              margin: const EdgeInsets.only(
                  bottom: SizeUtil.widthDialogProcessing,
                  left: SizeUtil.leftRightMarginDialogProcessing,
                  right: SizeUtil.leftRightMarginDialogProcessing),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                    SizeUtil.borderRadiusDialogProcessing),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget processingUtil(isShow){
    return  isShow == true ? const Center(
      child: CircularProgressIndicator(
        color: Colors.yellow,
      ),
    ) : Container();
  }

  Widget buildGridView({required BuildContext context, required List<ProductHomeModel> products, required HomeBloc bloc}) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Padding(
        padding: const EdgeInsets.all(SizeUtil.padding8),
        child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailPage(id:products[index].id ,homeBloc: bloc,)),
                  );
                },
                child: Card(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Expanded(
                          flex: 7,
                          child: products[index].productImages.length > 0 ?  CachedNetworkImage(
                            imageUrl: products[index].productImages[0].url!,
                            placeholder: (context, url) => Container(
                              color: Colors.grey,
                            ),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ) : Icon(Icons.error),),
                      Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(products[index].name, maxLines: 2,
                                style: TextStyle(fontWeight: FontWeight.bold, ),),
                              Row(
                                children: [
                                  Text('${formatMoney(value: products[index].price)} đ',style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    width: SizeUtil.padding8,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow:  [
                                        BoxShadow(color: products[index].discount == '' ? Colors.white : Colors.red, spreadRadius: 1),
                                      ],
                                    ),
                                    child:  Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: Text(products[index].discount , style: TextStyle(color: Colors.red),),
                                    ),
                                  )
                                ],
                              )
                            ],
                          )),
                    ],
                  ),
                ),
              );
            }
        ),
      ),
    );
  }

  BoxDecoration myBoxDecoration({Color? background = Colors.grey, double? borderSide = 20.0 }) {
    return BoxDecoration(
      color: background,
      borderRadius: BorderRadius.all(
          Radius.circular(borderSide!) //                 <--- border radius here
      ),
    );
  }

  BoxDecoration myBoxDecorationWithBorder({Color? background = Colors.grey,
    Color? backgroundBorder = Colors.grey, double? borderSide = 20.0,
    double? border = 2.0 }) {
    return BoxDecoration(
      color: background,
      border: Border.all(
          color: backgroundBorder!,
          width: border!
      ),
      borderRadius: BorderRadius.all(
          Radius.circular(borderSide!) //                 <--- border radius here
      ),
    );
  }

  BoxDecoration myBoxDecorationCircle({Color? background = Colors.redAccent }) {
    return BoxDecoration(
      color: background,
      shape: BoxShape.circle,

    );
  }

  String? formatMoney({int? value}){
    int oCcyInt = value!;
    if(oCcyInt == value){
      var oCcy = new NumberFormat("#,##0", "vi");
      return "${oCcy.format(value)}";
    }

    var oCcy = new NumberFormat("#,##0.00", "vi");
    return "${oCcy.format(value)}";

  }

  void showDialogBase(BuildContext context) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            height: 300,
            child: SizedBox.expand(child: FlutterLogo()),
            margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }



}
