import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lmiis/utils/Apis.dart';
import 'package:lmiis/utils/AppConstants.dart';
import 'package:lmiis/utils/app_images.dart';
import 'package:lmiis/utils/dimensions.dart';

import '../../../models/ResponsModels/ViewAllJobsModel.dart';
import '../../../utils/colors_resource.dart';

class EmploymentItem extends StatelessWidget {
  ViewAllJobsData viewAllJobData;
  EmploymentItem(this.viewAllJobData);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (_) {},
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AlertDialog(
                title: Text("Please login"),
                content: Text("Hello World"),
              );
            });
        final box = GetStorage();
        String? token = box.read(AppConstants.TOKEN) ?? '';
        // token == ""
        //     ? Navigator.push(context,
        //         MaterialPageRoute(builder: (ctx) => const LogInScreen()))
        //     : Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) =>
        //                 JobDescriptionViewScreen(viewAllJobData)));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
        decoration: myBoxDecoration(),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.120,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  padding: const EdgeInsets.all(5),
                  child: viewAllJobData.serviceProvider!.logo != null
                      ? Image.network(
                          '${Apis.URL}${viewAllJobData.serviceProvider!.logo}',
                          height: 60,
                          width: 60,
                          fit: BoxFit.fill,
                        )
                      : Container(),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 10, top: 5),
                    width: MediaQuery.of(context).size.width - 120,
                    child: Text(
                      '${viewAllJobData.title}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: Dimensions.BODY_18,
                          color: ColorsResource.PRAYMARY_TEXT_COLOR,
                          fontWeight: Dimensions.FONT_MEDIUM),
                    )),
                Container(
                    margin: const EdgeInsets.only(left: 10, top: 3),
                    width: MediaQuery.of(context).size.width - 120,
                    child: Text(
                      '${viewAllJobData.serviceProviderName}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: Dimensions.BODY_14,
                          color: ColorsResource.TEXT_GRAY_COLOR_LOW,
                          fontWeight: Dimensions.FONT_MEDIUM_NORMUL),
                    )),
                Expanded(child: Container()),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 120,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppImages.ic_location,
                            color: ColorsResource.TEXT_BLACK_COLOR,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text('${viewAllJobData.address}')
                        ],
                      ),
                      Expanded(child: Container()),
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppImages.ic_clock,
                            color: ColorsResource.TEXT_BLACK_COLOR,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text('${viewAllJobData.deadline}')
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  myBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: ColorsResource.NEW_INFONMATION_ITEM_COLOR,
      border: Border.all(
        color: ColorsResource.NEW_INFONMATION_ITEM_COLOR,
        width: 1,
      ),
    );
  }

  myBoxDecorationTop() {
    return BoxDecoration(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(5.0),
      ),
      color: ColorsResource.PRAYMERY_COLOR,
      border: Border.all(
        color: ColorsResource.PRAYMERY_COLOR,
        width: 1,
      ),
    );
  }
}
