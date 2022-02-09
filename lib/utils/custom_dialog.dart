import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_flutter/utils/base_components.dart';
import 'package:project_flutter/utils/size_util.dart';
import 'package:project_flutter/utils/words_util.dart';


import 'colors_util.dart';

class CustomDialog with BaseComponents {
  static void showSuccessAlert(BuildContext context, String title,
      Column content, String titleButton, Function? handleOnPress) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              contentPadding: EdgeInsets.all(26),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              content: SingleChildScrollView(
                  child: Column(children: [
                    Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(10, 104, 54, 1),
                                Color.fromRGBO(65, 173, 73, 1)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                        ),
                        child: Icon(Icons.check, color: Colors.white, size: 32)),
                    SizedBox(height: 16),
                    Text(title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(38, 37, 37, 1),
                            fontSize: 16,
                            fontWeight: FontWeight.w700)),
                    content,
                    SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () => handleOnPress!(),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green[ColorsUtil.colorGreen],
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.green[ColorsUtil.colorGreen]!),
                            borderRadius:
                            BorderRadius.circular(SizeUtil.borderRadiusDefault),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(SizeUtil.padding16),
                        child: Text(
                          titleButton,
                          style: TextStyle(
                              fontSize: 14,
                              color: ColorsUtil.whiteColorBtn,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ])));
        });
  }

  static void showErrorAlert(
      BuildContext context,
      String title,
      Column content,
      String negatitveButton,
      Function? negativeOnPress,
      String posititveButton,
      Function? positiveOnPress) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              contentPadding: EdgeInsets.all(26),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              content: SingleChildScrollView(
                  child: Column(children: [
                    Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(104, 10, 10, 1),
                                Color.fromRGBO(232, 101, 101, 1)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                        ),
                        child: Icon(Icons.close, color: Colors.white, size: 32)),
                    SizedBox(height: 16),
                    Text(title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(38, 37, 37, 1),
                            fontSize: 16,
                            fontWeight: FontWeight.w700)),
                    content,
                    SizedBox(height: 40),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: ElevatedButton(
                          onPressed: () => negativeOnPress!(),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green[ColorsUtil.colorGreen],
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.green[ColorsUtil.colorGreen]!),
                                borderRadius: BorderRadius.circular(
                                    SizeUtil.borderRadiusDefault),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.all(SizeUtil.padding16),
                            child: Text(
                              negatitveButton,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: ColorsUtil.whiteColorBtn,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )),
                    SizedBox(height: 14),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: ElevatedButton(
                            onPressed: () => positiveOnPress!(),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.green[ColorsUtil.colorGreen]!),
                                  borderRadius: BorderRadius.circular(
                                      SizeUtil.borderRadiusDefault),
                                )),
                            child: Padding(
                                padding: const EdgeInsets.all(SizeUtil.padding16),
                                child: Text(posititveButton,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.green[ColorsUtil.colorGreen]!,
                                        fontWeight: FontWeight.bold)))))
                  ])));
        });
  }

  dialogNotification(
      {required BuildContext context,
        required String title,
        required String description,
        required String buttonTitle,
        Widget? icon = const Icon(Icons.check, color: Colors.white),
        Color? backgroundButton,
        required List<Color> listColors,
        required Function(BuildContext) function}) {
    showDialog(
        context: context,
        builder: (BuildContext contextDialog) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)), //this right here
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(SizeUtil.padding16),
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomLeft,
                              colors: listColors,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: icon,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: SizeUtil.padding8),
                          child: Text(
                            '$title',
                            style: TextStyle(

                                fontWeight: FontWeight.bold, fontSize: 17,),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          description,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: SizeUtil.padding8,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: buttonUtil(
                                    title: buttonTitle,
                                    background: backgroundButton,
                                    handleOnPress: () {
                                      function(contextDialog);
                                    })),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ));
        });
  }

  dialogNotificationPush(
      {required BuildContext context,
        required String title,
        // required DialogSuccessModel dialogSuccessModel,
        required String buttonTitle,
        Widget? icon,
        Color? backgroundButton,
        required List<Color> listColors,
        required Function(BuildContext) function}) {
    showDialog(
        context: context,
        builder: (BuildContext contextDialog) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)), //this right here
            child: _buildLayoutDialogPush(
                title: title,
                // dialogSuccessModel: dialogSuccessModel,
                textButton: buttonTitle,
                listColors: listColors,
                icon: icon,
                backgroundColorButton: backgroundButton,
                function: () {
                  function(contextDialog);
                }),
          );
        });
  }

  Widget _buildLayoutDialogPush(
      {required String title,
        // required DialogSuccessModel dialogSuccessModel,
        required String textButton,
        Color? backgroundColorButton,
        required List<Color> listColors,
        Widget? icon = const Icon(Icons.category, color: Colors.white),
        required Function function}) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.all(SizeUtil.padding16),
          child: Column(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomLeft,
                    colors: listColors,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: icon,
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: SizeUtil.padding8),
                child: Text(
                  '$title',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ),
              RichText(
                  text: TextSpan(
                      text: 'Đơn hàng',
                      style: TextStyle(
                          color: Color.fromRGBO(22, 19, 21, 1),
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                      children: [
                        TextSpan(
                            text: ' #123456  ',
                            style: TextStyle(
                                color: Color.fromRGBO(65, 173, 73, 1),
                                fontSize: 15,
                                fontWeight: FontWeight.w700)),
                        TextSpan(
                            text:
                            'dự kiến sẽ được giao vào ngày 24'
                                ' tháng 12 năm 2021.',
                            style: TextStyle(
                                color: Color.fromRGBO(22, 19, 21, 1),
                                fontSize: 15,
                                fontWeight: FontWeight.w400))
                      ])),
              SizedBox(height: 8),
              RichText(
                  text: TextSpan(
                      text:
                      'admin sẽ liện hệ với bạn sau.',
                      style: TextStyle(
                          color: Color.fromRGBO(22, 19, 21, 1),
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                      children: [
                        // TextSpan(
                        //     text: ' ${dialogSuccessModel.email != null ? dialogSuccessModel.email : ''}. ',
                        //     style: TextStyle(
                        //         color: Color.fromRGBO(65, 173, 73, 1),
                        //         fontSize: 15,
                        //         fontWeight: FontWeight.w700)),
                        TextSpan(
                            text:
                            ' Xin cảm ơn.',
                            style: TextStyle(
                                color: Color.fromRGBO(22, 19, 21, 1),
                                fontSize: 15,
                                fontWeight: FontWeight.w400))
                      ])),
              SizedBox(height: 8),
              RichText(
                  text: TextSpan(
                      text:
                      'Nếu có bất kì thắc mắc nào, vui lòng liên hệ hotline: ',
                      style: TextStyle(
                          color: Color.fromRGBO(22, 19, 21, 1),
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                      children: [
                        TextSpan(
                            text: ' 1900 636035 ',
                            style: TextStyle(
                                color: Color.fromRGBO(65, 173, 73, 1),
                                fontSize: 15,
                                fontWeight: FontWeight.w700))
                      ])),
              SizedBox(
                height: SizeUtil.padding16,
              ),
              Row(
                children: [
                  Expanded(
                      child: buttonUtil(
                          title: textButton,
                          background: backgroundColorButton,
                          handleOnPress: () {
                            function();
                          })),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  static void showComingSoonAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              content: SingleChildScrollView(
                  child: Column(children: [
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.close, color: Colors.black))
                    ]),
                    Container(
                        padding: EdgeInsets.all(26),
                        child: Column(children: [
                          Text('Tính năng đang được cập nhật',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromRGBO(38, 37, 37, 1),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700)),
                          SizedBox(height: 40),
                          SvgPicture.asset('assets/images/coming_soon.svg'),
                          SizedBox(height: 40),
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.green[ColorsUtil.colorGreen],
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.green[ColorsUtil.colorGreen]!),
                                  borderRadius: BorderRadius.circular(
                                      SizeUtil.borderRadiusDefault),
                                )),
                            child: Padding(
                              padding: const EdgeInsets.all(SizeUtil.padding16),
                              child: Text(
                                WordsUtil.titleApp,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: ColorsUtil.whiteColorBtn,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ]))
                  ])));
        });
  }

  static void showPickOrCapturePhoto(
      BuildContext context, Function onPressPickPhoto, Function onPressTakePhoto) {
    showModalBottomSheet(
        enableDrag: false,
        backgroundColor: Colors.transparent,
        barrierColor: Color.fromRGBO(196, 196, 196, 0.4),
        context: context,
        builder: (BuildContext bc) {
          return Container(
              margin: EdgeInsets.only(bottom: 20, left: 16, right: 16),
              width: MediaQuery.of(context).size.width,
              child: Column(children: [
                Expanded(child: Container()),
                Container(
                    height: 61,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    child: GestureDetector(
                        onTap: () => {
                          onPressPickPhoto(),
                          Navigator.of(context).pop()
                        },
                        child: Center(
                          child: Text('Thư viện ảnh',
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 122, 255, 1),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                  fontFamily: 'Roboto')),
                        ))),
                Container(height: 1, color: Color.fromRGBO(255, 255, 255, 0.8)),
                Container(
                    height: 61,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: GestureDetector(
                        onTap: () => {
                          onPressTakePhoto(),
                          Navigator.of(context).pop()
                        },
                        child: Center(
                          child: Text('Camera',
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 122, 255, 1),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                  fontFamily: 'Roboto')),
                        ))),
                SizedBox(height: 10),
                Container(
                    height: 61,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Center(
                          child: Text('Hủy',
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 122, 255, 1),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  fontFamily: 'Roboto')),
                        )))
              ]));
        });
  }
}
