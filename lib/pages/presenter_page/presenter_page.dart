import 'package:flutter/material.dart';
import 'package:project_flutter/utils/base_components.dart';
import 'package:project_flutter/utils/size_util.dart';
import 'package:project_flutter/utils/words_util.dart';

class PresenterPage extends StatefulWidget {
  const PresenterPage({Key? key}) : super(key: key);

  @override
  _PresenterPageState createState() => _PresenterPageState();
}

class _PresenterPageState extends State<PresenterPage> with BaseComponents {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarBuild(title: 'Người giới thiệu', context: context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SizeUtil.padding16),
          child: Column(
            children: [

              textFromFieldUtil(onChanged: (String value){

              },
                  controller:
                  emailController,
                  textInputAction:
                  TextInputAction.next,
                  title: WordsUtil.titleInputUsername,
                  hintText: WordsUtil
                      .inputUsername,
                  validate: (value) {
                    if (value != '') {
                      return null;
                    } else {
                      return '${WordsUtil.inputUsername}';
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
