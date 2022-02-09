import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_flutter/bloc/home_bloc.dart';
import 'package:project_flutter/bloc/login_bloc.dart';
import 'package:project_flutter/pages/login_page/model/login_request_api_model.dart';
import 'package:project_flutter/pages/sign_up_page/sign_up_page.dart';
import 'package:project_flutter/utils/base_components.dart';
import 'package:project_flutter/utils/colors_util.dart';
import 'package:project_flutter/utils/enum_util.dart';
import 'package:project_flutter/utils/paths_util.dart';
import 'package:project_flutter/utils/size_util.dart';
import 'package:project_flutter/utils/words_util.dart';


import '../../utils/convert_color_util.dart';

class LoginPage extends StatefulWidget {
  final HomeBloc homeBloc;
  final LoginTypeEnum loginTypeEnum;
  const LoginPage({Key? key, required this.homeBloc, required this.loginTypeEnum}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with BaseComponents {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginBloc? bloc;
  var overlayStyle = SystemUiOverlayStyle.dark;

  @override
  void initState() {
    super.initState();
    bloc = new LoginBloc();
    // usernameController = new TextEditingController(text: 'minhhc08@gmail.com');
    // passwordController = new TextEditingController(text: '123456');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: StreamBuilder<bool>(
            stream: bloc!.getIsLoadingUtil,
            builder: (context, snapshotProcessing) {
              return Stack(
                children: [
                  AbsorbPointer(
                    absorbing: snapshotProcessing.data == true ? true : false,
                    child: Form(
                      key: _formKey,
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: widget.loginTypeEnum == LoginTypeEnum.normal ? 40 : 80,
                                  ),
                                  Center(
                                      child: Image.asset(
                                        PathsUtil.logoApp,
                                        height: 180,
                                      )),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Text(WordsUtil.titleApp,
                                      textAlign:
                                      TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight:
                                          FontWeight
                                              .bold,
                                          color: ConvertColorUtil(ColorsUtil.colorApp))),

                                  Container(
                                    padding: EdgeInsets.all(30),
                                    child: Column(children: [
                                      textFromFieldUtil(onChanged: (String value){

                                      },
                                          controller:
                                          usernameController,

                                          textInputAction:
                                          TextInputAction.next,
                                          title: WordsUtil
                                              .titleInputUsername,
                                          hintText: WordsUtil
                                              .inputUsername,
                                          validate: (value) {
                                            if (value != '') {
                                              return null;
                                            } else {
                                              return '${WordsUtil.validateInputUsername}';
                                            }
                                          }),

                                      StreamBuilder<bool>(
                                          stream: bloc
                                              ?.getIsShowPassword,
                                          builder: (context,
                                              isShowPasswordSnapshot) {
                                            if (isShowPasswordSnapshot
                                                .data ==
                                                null) {
                                              return Container();
                                            }
                                            return textFromFieldUtil(onChanged: (String value){

                                            },
                                                controller:
                                                passwordController,

                                                textInputAction:
                                                TextInputAction
                                                    .next,
                                                isObscureText:
                                                isShowPasswordSnapshot
                                                    .data!
                                                    ? isShowPasswordSnapshot
                                                    .data!
                                                    : false,
                                                iconButtonSuffixIcon:
                                                IconButton(
                                                    icon: isShowPasswordSnapshot.data ==
                                                        true
                                                        ? SvgPicture.asset(
                                                        PathsUtil
                                                            .eyesHideIcon)
                                                        : SvgPicture
                                                        .asset(PathsUtil
                                                        .eyesIcon),
                                                    onPressed:
                                                        () {
                                                      bloc?.setIsShowPassword(
                                                          !isShowPasswordSnapshot
                                                              .data!);
                                                    }),
                                                title: WordsUtil
                                                    .titleInputPassword,
                                                hintText: WordsUtil
                                                    .inputPassword,
                                                validate: (value) {
                                                  if (value != '') {
                                                    return null;
                                                  } else {
                                                    return '${WordsUtil.validateInputPassword}';
                                                  }
                                                });
                                          }),

                                      SizedBox(
                                        height: SizeUtil.padding16,
                                      ),

                                      Container(
                                          width:
                                          MediaQuery.of(context)
                                              .size
                                              .width,
                                          child: buttonUtil(
                                              title:
                                              WordsUtil.signIn,
                                              handleOnPress:
                                                  () async {
                                                FocusScope.of(
                                                    context)
                                                    .unfocus();

                                                if (_formKey.currentState!.validate()) {

                                                  // setState(() {
                                                  //   if (overlayStyle ==
                                                  //       SystemUiOverlayStyle
                                                  //           .dark) {
                                                  //     overlayStyle =
                                                  //         SystemUiOverlayStyle
                                                  //             .light;
                                                  //   }
                                                  // });
                                                  // bloc!
                                                  //     .setIsLoadingUtil(
                                                  //     isLoading:
                                                  //     true);
                                                  bloc!.requestLoginApiBloc(
                                                      context: context,
                                                      homeBloc: widget.homeBloc,
                                                      model: new LoginRequestApiModel(
                                                        username: usernameController
                                                            .text,
                                                        password: passwordController.text,
                                                      ), loginTypeEnum: widget.loginTypeEnum);
                                                }
                                              })),

                                      SizedBox(height: 20),
                                      GestureDetector(
                                        onTap: () {
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //       builder: (context) =>
                                          //           ForgotPasswordPage(),
                                          //     ));
                                        },
                                        child: Text(
                                          WordsUtil.forgotPassword,
                                          style: TextStyle(
                                              color: ConvertColorUtil(ColorsUtil.colorApp),
                                              fontWeight:
                                              FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .center,
                                          children: [
                                            Text(WordsUtil
                                                .donNotHave),
                                            GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder:
                                                            (context) =>
                                                            SignUpPage()),
                                                  );
                                                },
                                                child: Text(
                                                  WordsUtil.signUp,
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight
                                                          .bold,
                                                      color: ConvertColorUtil(ColorsUtil.colorApp)),
                                                ))
                                          ])

                                    ]
                                    ),
                                  )
                                ],
                              )),
                          widget.loginTypeEnum != LoginTypeEnum.normal ? Positioned(
                            top: 46,
                            left: 16,
                            child: IconButton(onPressed: (){
                              Navigator.pop(context);
                            }, icon: Icon(Icons.arrow_back_ios)),
                          ) : Container()
                        ],
                      ),
                    ),
                  ),
                  processingUtil(snapshotProcessing.data)
                ],
              );
            }),
      ),
    );
  }

  @override
  void dispose() {
    bloc!.disposeLoginBloc();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
