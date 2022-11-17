import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lmiis/provider/AuthProvider.dart';
import 'package:lmiis/utils/Apis.dart';
import 'package:lmiis/utils/AppConstants.dart';
import 'package:lmiis/utils/app_images.dart';
import 'package:lmiis/utils/colors_resource.dart';
import 'package:lmiis/utils/dimensions.dart';
import 'package:lmiis/views/employment_list_screens/employment_list_screen.dart';
import 'package:lmiis/views/home_screens/widgets/news_infomation_item.dart';
import 'package:lmiis/views/my_profile_screens/EditMyProfileScreen.dart';
import 'package:lmiis/views/widgets/custtom_button.dart';
import 'package:provider/provider.dart';

import '../../models/ResponsModels/NewsNoticeModel.dart';
import '../../provider/MyProfileProvider.dart';
import '../../provider/NewNoticePrvide.dart';
import '../employment_support_service_Screens/employment_support_service_screen.dart';
import '../login_screens/logIn_screen.dart';
import '../my_profile_screens/ChnagePassword.dart';
import '../my_profile_screens/MyProfileScreen.dart';
import '../news_information_see_more_screens/news_information_see_more_screen.dart';
import '../notification_screens/notification_screen.dart';
import '../training_screens/TrainingScreen.dart';
import '../training_service_provider_screens/TrainingServiceProviderScreen.dart';
import '../widgets/showCustomSnackBar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int countpage = 1;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NewsNoticeProvider>(context, listen: false)
          .getNewNotice(countpage);
      Provider.of<MyProfileProvider>(context, listen: false).getMyProfile();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    String token = box.read(AppConstants.TOKEN) ?? '';

    return riverpod.ProviderScope(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: ColorsResource.WHAIT,
        drawer: drawerLayout(),
        body: SingleChildScrollView(
          child: Consumer<NewsNoticeProvider>(
              builder: (context, newsNoticeProvider, child) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  //ToolBar
                  Expanded(
                    flex: 5,
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            color: ColorsResource.PRAYMARY_TEXT_COLOR,
                            height: 90,
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 30),
                              child: Row(
                                children: [
                                  InkWell(
                                    onHover: (_) {},
                                    onTap: () {
                                      _scaffoldKey.currentState?.openDrawer();
                                    },
                                    child: SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: Container(
                                          margin: const EdgeInsets.all(6),
                                          child: SvgPicture.asset(
                                              AppImages.ic_menu)),
                                    ),
                                  ),
                                  Expanded(child: Container()),
                                  Text(
                                    AppConstants.APP_NAME,
                                    style: TextStyle(
                                        color: ColorsResource.WHAIT,
                                        fontSize: Dimensions.BODY_30,
                                        fontWeight: Dimensions.FONT_BOLD),
                                  ),
                                  Expanded(child: Container()),
                                  token.isNotEmpty
                                      ? InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const NotificationScreen()));
                                          },
                                          onHover: (_) {},
                                          child: SvgPicture.asset(
                                              AppImages.ic_notificaton))
                                      : const Text("")
                                ],
                              ),
                            ),
                          ),
                          //topMenu
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 10,
                                        right: 5,
                                        top: 10,
                                        bottom: 10),
                                    width: MediaQuery.of(context).size.width *
                                        0.92,
                                    decoration: myBoxDecorationTop(),
                                    height: MediaQuery.of(context).size.height *
                                        0.150,
                                    child: InkWell(
                                      onHover: (_) {},
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const EmploymentListScreen()));
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                              AppImages.ic_employment),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            AppConstants.employment,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: ColorsResource
                                                    .PRAYMARY_TEXT_COLOR,
                                                fontSize: Dimensions.BODY_14,
                                                fontWeight: Dimensions
                                                    .FONT_MEDIUM_NORMUL),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 5, right: 5, top: 10, bottom: 10),
                                    width: MediaQuery.of(context).size.width *
                                        0.92,
                                    decoration: myBoxDecorationTop(),
                                    height: MediaQuery.of(context).size.height *
                                        0.150,
                                    child: InkWell(
                                      onHover: (_) {},
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const TrainingScreen()));
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                              AppImages.ic_training),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            AppConstants.training,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: ColorsResource
                                                    .PRAYMARY_TEXT_COLOR,
                                                fontSize: Dimensions.BODY_14,
                                                fontWeight: Dimensions
                                                    .FONT_MEDIUM_NORMUL),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 5, right: 5, top: 10, bottom: 10),
                                    width: MediaQuery.of(context).size.width *
                                        0.92,
                                    decoration: myBoxDecorationTop(),
                                    height: MediaQuery.of(context).size.height *
                                        0.150,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const EmploymentSupportServiceScreen()));
                                      },
                                      onHover: (_) {},
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(AppImages
                                              .ic_employment_support_service_provider),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            AppConstants
                                                .employment_support_service_provider,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: ColorsResource
                                                    .PRAYMARY_TEXT_COLOR,
                                                fontSize: Dimensions.BODY_14,
                                                fontWeight: Dimensions
                                                    .FONT_MEDIUM_NORMUL),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 5,
                                        right: 10,
                                        top: 10,
                                        bottom: 10),
                                    width: MediaQuery.of(context).size.width *
                                        0.92,
                                    decoration: myBoxDecorationTop(),
                                    height: MediaQuery.of(context).size.height *
                                        0.150,
                                    child: InkWell(
                                      onHover: (_) {},
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const TrainingServiceProvider()));
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(AppImages
                                              .ic_employment_support_service_provider),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            AppConstants
                                                .training_service_provider,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: ColorsResource
                                                    .PRAYMARY_TEXT_COLOR,
                                                fontSize: Dimensions.BODY_14,
                                                fontWeight: Dimensions
                                                    .FONT_MEDIUM_NORMUL),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //title button
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              children: [
                                Text(
                                  AppConstants.information_news,
                                  style: TextStyle(
                                      color:
                                          ColorsResource.PRAYMARY_TEXT_COLOR),
                                ),
                                Expanded(child: Container()),
                                CustomButton(
                                    AppConstants.see_more,
                                    () => {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const NewsInformationSeeMoreScreen()))
                                        },
                                    height: 25,
                                    wight: 115,
                                    textSize: Dimensions.BODY_10,
                                    padding: 2)
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 10, right: 10, top: 10),
                            height: 1,
                            width: MediaQuery.of(context).size.width,
                            color: ColorsResource.PRAYMARY_TEXT_COLOR,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 11,
                    child: newsNoticeProvider.newsNoticeModel != null
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                newsNoticeProvider.newsNoticeDataList!.length,
                            itemBuilder: (BuildContext context, int index) {
                              NewsNoticeData newsNoticeData =
                                  newsNoticeProvider.newsNoticeDataList![index];
                              return NewsInformationItem(newsNoticeData);
                            },
                          )
                        : Container(
                            child: const Align(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  myBoxDecorationTop() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: ColorsResource.PRAYMERY_COLOR,
      border: Border.all(
        color: ColorsResource.PRAYMERY_COLOR,
        width: 1,
      ),
    );
  }

  drawerLayout() {
    return Drawer(
      child: Consumer2<AuthProvider, MyProfileProvider>(
          builder: (context, authProvider, myProfileProvider, child) {
        final box = GetStorage();
        String? token = box.read(AppConstants.TOKEN) ?? '';
        log("sds");
        log('${token.isEmpty}');

        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  token.isNotEmpty
                      ? Column(
                          children: [
                            SizedBox(
                              height: 150,
                              child: DrawerHeader(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 70,
                                        height: 70,
                                        child: Container(
                                            margin: const EdgeInsets.all(10),
                                            child: myProfileProvider
                                                        .myProfileModel
                                                        ?.data
                                                        ?.file !=
                                                    null
                                                ? Image.network(
                                                    '${Apis.IMAGE_URL}${myProfileProvider.myProfileModel?.data?.file}')
                                                : Image.asset(
                                                    AppImages.ic_demo_person)),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 20, left: 10),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.7,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${myProfileProvider.myProfileModel?.data?.name}",
                                              style: TextStyle(
                                                  fontSize: Dimensions.BODY_16,
                                                  fontWeight:
                                                      Dimensions.FONT_MEDIUM,
                                                  color: ColorsResource
                                                      .PRAYMARY_TEXT_COLOR),
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "${myProfileProvider.myProfileModel?.data?.email}",
                                              style: TextStyle(
                                                  fontSize: Dimensions.BODY_12,
                                                  fontWeight:
                                                      Dimensions.FONT_MEDIUM,
                                                  color: ColorsResource
                                                      .TEXT_BLACK_COLOR),
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // SizedBox(
                            //   height: 150,
                            //   child: DrawerHeader(
                            //     child: Align(
                            //       alignment: Alignment.centerLeft,
                            //       child: Row(
                            //         children: [
                            //           SizedBox(
                            //             width: 70,
                            //             height: 70,
                            //             child: Container(
                            //                 margin: const EdgeInsets.all(10),
                            //                 child: myProfileProvider
                            //                             .myProfileModel
                            //                             ?.data
                            //                             ?.file !=
                            //                         null
                            //                     ? Image.network(
                            //                         '${Apis.IMAGE_URL}${myProfileProvider.myProfileModel?.data?.file}')
                            //                     : Image.asset(
                            //                         AppImages.ic_demo_person)),
                            //           ),
                            //           Container(
                            //             margin: const EdgeInsets.only(
                            //                 top: 20, left: 10),
                            //             width:
                            //                 MediaQuery.of(context).size.width /
                            //                     2.7,
                            //             child: Column(
                            //               crossAxisAlignment:
                            //                   CrossAxisAlignment.start,
                            //               children: [
                            //                 Text(
                            //                   "${myProfileProvider.myProfileModel?.data?.name}",
                            //                   style: TextStyle(
                            //                       fontSize: Dimensions.BODY_16,
                            //                       fontWeight:
                            //                           Dimensions.FONT_MEDIUM,
                            //                       color: ColorsResource
                            //                           .PRAYMARY_TEXT_COLOR),
                            //                   overflow: TextOverflow.ellipsis,
                            //                   softWrap: false,
                            //                 ),
                            //                 const SizedBox(
                            //                   height: 5,
                            //                 ),
                            //                 Text(
                            //                   "${myProfileProvider.myProfileModel?.data?.email}",
                            //                   style: TextStyle(
                            //                       fontSize: Dimensions.BODY_12,
                            //                       fontWeight:
                            //                           Dimensions.FONT_MEDIUM,
                            //                       color: ColorsResource
                            //                           .TEXT_BLACK_COLOR),
                            //                   overflow: TextOverflow.ellipsis,
                            //                   softWrap: false,
                            //                 ),
                            //               ],
                            //             ),
                            //           )
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MyProfileScreen()));
                                },
                                onHover: (value) {},
                                child: ListTile(
                                  title: Row(
                                    children: [
                                      ConstrainedBox(
                                        constraints: const BoxConstraints(
                                          minWidth: 20,
                                          minHeight: 20,
                                          maxWidth: 20,
                                          maxHeight: 20,
                                        ),
                                        child: SvgPicture.asset(
                                          AppImages.ic_profile_l,
                                          width: 20,
                                          height: 20,
                                        ),
                                      ),
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            AppConstants.Profile,
                                            style: TextStyle(
                                                fontSize: Dimensions.BODY_16,
                                                color: ColorsResource
                                                    .PRAYMARY_TEXT_COLOR),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const EditMyProfileScreen()));
                                },
                                onHover: (value) {},
                                child: ListTile(
                                  title: Container(
                                    child: Row(
                                      children: [
                                        ConstrainedBox(
                                          constraints: const BoxConstraints(
                                            minWidth: 20,
                                            minHeight: 20,
                                            maxWidth: 20,
                                            maxHeight: 20,
                                          ),
                                          child: SvgPicture.asset(
                                            AppImages.ic_edite_l,
                                            width: 20,
                                            height: 20,
                                          ),
                                        ),
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              AppConstants.Edit_profile,
                                              style: TextStyle(
                                                  fontSize: Dimensions.BODY_16,
                                                  color: ColorsResource
                                                      .PRAYMARY_TEXT_COLOR),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ChnagePassword()));
                              },
                              onHover: (_) {},
                              child: ListTile(
                                title: Container(
                                  child: Row(
                                    children: [
                                      ConstrainedBox(
                                        constraints: const BoxConstraints(
                                          minWidth: 20,
                                          minHeight: 20,
                                          maxWidth: 20,
                                          maxHeight: 20,
                                        ),
                                        child: SvgPicture.asset(
                                          AppImages.ic_change_key,
                                          width: 20,
                                          height: 20,
                                        ),
                                      ),
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            AppConstants.Change_the_password,
                                            style: TextStyle(
                                                fontSize: Dimensions.BODY_16,
                                                color: ColorsResource
                                                    .PRAYMARY_TEXT_COLOR),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      : const SizedBox(
                          height: 100,
                        ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const EmploymentListScreen()));
                    },
                    onHover: (_) {},
                    child: ListTile(
                      title: Container(
                        child: Row(
                          children: [
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                minWidth: 20,
                                minHeight: 20,
                                maxWidth: 20,
                                maxHeight: 20,
                              ),
                              child: SvgPicture.asset(
                                AppImages.ic_employment,
                                width: 20,
                                height: 20,
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  AppConstants.employment,
                                  style: TextStyle(
                                      fontSize: Dimensions.BODY_16,
                                      color:
                                          ColorsResource.PRAYMARY_TEXT_COLOR),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TrainingScreen()));
                    },
                    onHover: (_) {},
                    child: ListTile(
                      title: Container(
                        child: Row(
                          children: [
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                minWidth: 20,
                                minHeight: 20,
                                maxWidth: 20,
                                maxHeight: 20,
                              ),
                              child: SvgPicture.asset(
                                AppImages.ic_training,
                                width: 20,
                                height: 20,
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  AppConstants.training,
                                  style: TextStyle(
                                      fontSize: Dimensions.BODY_16,
                                      color:
                                          ColorsResource.PRAYMARY_TEXT_COLOR),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const EmploymentSupportServiceScreen()));
                    },
                    onHover: (_) {},
                    child: ListTile(
                      title: Container(
                        child: Row(
                          children: [
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                minWidth: 20,
                                minHeight: 20,
                                maxWidth: 20,
                                maxHeight: 20,
                              ),
                              child: SvgPicture.asset(
                                AppImages
                                    .ic_employment_support_service_provider,
                                width: 20,
                                height: 20,
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  AppConstants
                                      .employment_support_service_provider,
                                  style: TextStyle(
                                      fontSize: Dimensions.BODY_16,
                                      color:
                                          ColorsResource.PRAYMARY_TEXT_COLOR),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const TrainingServiceProvider()));
                    },
                    onHover: (_) {},
                    child: ListTile(
                      title: Container(
                        child: Row(
                          children: [
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                minWidth: 20,
                                minHeight: 20,
                                maxWidth: 20,
                                maxHeight: 20,
                              ),
                              child: SvgPicture.asset(
                                AppImages
                                    .ic_employment_support_service_provider,
                                width: 20,
                                height: 20,
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  AppConstants.training_service_provider,
                                  style: TextStyle(
                                      fontSize: Dimensions.BODY_16,
                                      color:
                                          ColorsResource.PRAYMARY_TEXT_COLOR),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  token.isNotEmpty
                      ? Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const HomeScreen()),
                                  (Route<dynamic> route) => false);
                            },
                            onHover: (_) {},
                            child: ListTile(
                              title: InkWell(
                                onTap: () {
                                  authProvider.logOut().then((value) {
                                    if (value.isSuccess) {
                                      Navigator.of(context).pop();
                                      final box = GetStorage();
                                      box.write(AppConstants.USER_EMAIL, '');
                                      box.write(AppConstants.USER_PASSWORD, '');
                                      box.write(AppConstants.TOKEN, '');
                                      showCustomSnackBar(value.message, context,
                                          isError: false);
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  const HomeScreen()),
                                          (Route<dynamic> route) => false);
                                    } else {
                                      Navigator.of(context).pop();
                                      showCustomSnackBar(
                                          value.message, context);
                                    }
                                  });
                                },
                                onHover: (_) {},
                                child: Row(
                                  children: [
                                    ConstrainedBox(
                                      constraints: const BoxConstraints(
                                        minWidth: 34,
                                        minHeight: 34,
                                        maxWidth: 34,
                                        maxHeight: 34,
                                      ),
                                      child: SvgPicture.asset(
                                          AppImages.bx_log_out),
                                    ),
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          AppConstants.LogOut,
                                          style: TextStyle(
                                              fontSize: Dimensions.BODY_16,
                                              color: ColorsResource
                                                  .TEXT_READ_COLOR),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
