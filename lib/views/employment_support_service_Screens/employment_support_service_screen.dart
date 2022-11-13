import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lmiis/views/employment_support_service_Screens/EmploymentSupportServiceDetailsScreen.dart';
import 'package:lmiis/views/employment_support_service_Screens/widgets/employment_support_service_item.dart';
import 'package:provider/provider.dart';

import '../../models/ResponsModels/ESSPModel.dart';
import '../../provider/ESSPProvider.dart';
import '../../utils/AppConstants.dart';
import '../../utils/app_images.dart';
import '../../utils/colors_resource.dart';
import '../../utils/dimensions.dart';

class EmploymentSupportServiceScreen extends StatefulWidget {
  const EmploymentSupportServiceScreen({Key? key}) : super(key: key);

  @override
  State<EmploymentSupportServiceScreen> createState() =>
      _EmploymentSupportServiceScreenState();
}

class _EmploymentSupportServiceScreenState
    extends State<EmploymentSupportServiceScreen> {
  int pageCount = 1;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ESSPProvider>(context, listen: false)
          .getVewAllEssp(pageCount);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<ESSPProvider>(
          builder: (context, eSSPProvider, child) => SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: ColorsResource.PRAYMERY_COLOR,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.050,
                      margin: EdgeInsets.only(top: 60, left: 10, right: 10),
                      child: Column(
                        children: [
                          //Toolbar
                          Row(
                            children: [
                              InkWell(
                                  onHover: (_) {},
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child:
                                      SvgPicture.asset(AppImages.ic_back_blue)),
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 65,
                                child: Text(
                                  AppConstants
                                      .Employment_support_service_provider,
                                  style: TextStyle(
                                      fontSize: Dimensions.BODY_20,
                                      fontWeight: Dimensions.FONT_MEDIUM_NORMUL,
                                      color:
                                          ColorsResource.PRAYMARY_TEXT_COLOR),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 8,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: eSSPProvider.esspModel != null
                          ? ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: eSSPProvider.esspModelDataList!.length,
                              itemBuilder: (BuildContext context, int index) {
                                EsspModelData esspModelData =
                                    eSSPProvider.esspModelDataList![index];
                                return EmploymentSupportServiceItem(
                                    esspModelData, () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EmploymentSupportServiceDetailsScreen(
                                                  esspModelData)));
                                });
                              },
                            )
                          : Container(
                              child: const Align(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(),
                              ),
                            ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
