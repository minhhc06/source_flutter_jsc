import 'package:flutter/material.dart';
import 'package:project_flutter/bloc/informaton_user_order_bloc.dart';
import 'package:project_flutter/pages/informaton_user_order_page/model/province_model.dart';
import 'package:project_flutter/utils/base_components.dart';
import 'package:project_flutter/utils/colors_util.dart';
import 'package:project_flutter/utils/convert_color_util.dart';
import 'package:project_flutter/utils/enum_util.dart';

// ignore: must_be_immutable
class AddressComponent extends StatefulWidget {
  InformationUserOrderBloc bloc;
  final Stream<List<ProvinceModel>> streamList;
  Stream<ProvinceModel> streamSelected;
  SelectAddress selectAddress;


  AddressComponent(
      {Key? key,
      required this.streamList,
      required this.streamSelected,
      required this.selectAddress,
      required this.bloc})
      : super(key: key);

  @override
  _AddressComponentState createState() => _AddressComponentState();
}

class _AddressComponentState extends State<AddressComponent>
    with BaseComponents {
  // late InformationUserOrderBloc bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.bloc.requestAddressApiApiBloc(context: context, selectAddress: widget.selectAddress);

  }

  _showDialog() async {
    await Future.delayed(Duration(milliseconds: 50));
    dialogProcessing(context: context);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarBuild(title: widget.selectAddress.title!, context: context),
      body: StreamBuilder<List<ProvinceModel>>(
          stream: widget.streamList,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return processingUtil(true);
            }
            return StreamBuilder<bool>(
              stream: widget.bloc.getIsLoadingUtil,
              builder: (context, snapshotIsLoading) {
                if(snapshotIsLoading.data == true){
                  return processingUtil(true);
                }
                return SingleChildScrollView(
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return StreamBuilder<ProvinceModel>(
                            stream: widget.streamSelected,
                            builder: (context, snapshotSelected) {
                              return ListTile(
                                title: Text(snapshot.data![index].toString()),
                                leading: Radio<ProvinceModel>(
                                  value: snapshot.data![index],
                                  groupValue: snapshotSelected.data == null
                                      ? new ProvinceModel(
                                          name: '',
                                          code: -1,
                                          division_type: '',
                                          codename: '',
                                          province_code: -1,
                                          district_code: -1)
                                      : snapshotSelected.data,
                                  onChanged: (value) {
                                    // setState(() { widget.list[index] = value; });

                                    Navigator.pop(context, value);
                                  },
                                ),
                              );
                            });
                      }),
                );
              }
            );
          }),
    );
  }
}
