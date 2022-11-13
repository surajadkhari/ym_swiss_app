import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lmiis/views/employment_list_screens/widgets/employment_item.dart';
import 'package:provider/provider.dart';

import '../../models/ResponsModels/MunicipalitiesModel.dart';
import '../../models/ResponsModels/ViewAllJobsModel.dart';
import '../../provider/JobProvider.dart';
import '../../provider/LocationProvider.dart';
import '../../utils/AppConstants.dart';
import '../../utils/app_images.dart';
import '../../utils/colors_resource.dart';
import '../../utils/dimensions.dart';
import '../news_information_see_more_screens/widgets/custtom_search_button.dart';
import '../news_information_see_more_screens/widgets/search_text_field.dart';
import '../widgets/showCustomSnackBar.dart';

class EmploymentListScreen extends StatefulWidget {
  const EmploymentListScreen({Key? key}) : super(key: key);

  @override
  State<EmploymentListScreen> createState() => _EmploymentListScreenState();
}

class _EmploymentListScreenState extends State<EmploymentListScreen> {


  String locationHintValWord = AppConstants.Select_the_municipality;
  List<String> locationList = [AppConstants.Select_the_municipality];
  List<int> locationListIdList = [0];
  int locationListId = 0;


  var gradValueWord = AppConstants.grade;
  String gradHintValWord = AppConstants.grade;
  List<String> gradList = [AppConstants.grade];
  List<int> gradListIdList = [0];
  int gradListId = 0;






  int pageCount = 1;
  int sPageCount = 1;
  bool isSearching = false;

  List<MunicipalitiesData>? municipalitiesData;

  @override
  void initState() {
    municipalitiesData = [];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<JobProvider>(context, listen: false).getVewAllJob(pageCount);
      Provider.of<JobProvider>(context, listen: false).getJobCategory(1).then((value) {

        var viewAllJobCategoryDataList = Provider.of<JobProvider>(context, listen: false).viewAllJobCategoryDataList;
        viewAllJobCategoryDataList!.forEach((element) {
          gradList.add(element.name!);
          gradListIdList.add(element.id!);
        });
      });

      var municipalities = Provider.of<LocationProvider>(context, listen: false);
      municipalities.municipalitiesDataAll!.forEach((element) {
        locationList.add(element.districtName!);
        locationListIdList.add(element.id!);
      });


    });
    super.initState();
  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Consumer2<JobProvider,LocationProvider>(
        builder: (context,jobProvider,locationProvider,child) =>
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                  flex: 5,
                child: Column(
                  children: [
                    Container(
                      color: ColorsResource.PRAYMERY_COLOR,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.040,
                        margin: EdgeInsets.only(top: 40, left: 10, right: 10),
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
                                    AppConstants.employment,
                                    style: TextStyle(
                                        fontSize: Dimensions.BODY_20,
                                        fontWeight: Dimensions.FONT_MEDIUM_NORMUL,
                                        color: ColorsResource.PRAYMARY_TEXT_COLOR),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5,left: 20,right: 20),
                            width: MediaQuery.of(context).size.width - 80,
                            child: selectLocationDropdown(),
                          )
                        ],
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5,left: 20,right: 20),
                            width: MediaQuery.of(context).size.width - 80,
                            child: selectGradeDropdown(),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5,left: 20,right: 20),
                      width: MediaQuery.of(context).size.width - 80,
                      child: Row(
                        children: [
                          Expanded(child: Container()),
                          CustomSearchButton(AppConstants.search_for, (){

                            showLoaderDialog(context);

                            if(locationListId == 0 && gradListId == 0){
                              jobProvider.getVewAllJob(pageCount).then((value) {
                                if(value.isSuccess){
                                  isSearching = false;
                                  Navigator.of(context).pop();
                                }else{
                                  isSearching = false;
                                  Navigator.of(context).pop();
                                }
                              });

                              return;
                            }

                            String url = '';
                            if(locationListId != 0){
                              url = '&muni_id=$locationListId';
                            }

                            if(gradListId != 0){
                              url = '$url&category_id=$gradListId';
                            }
                            print('shfgshjfghsd $url');



                            jobProvider.getSearchAllJob(url,sPageCount).then((value) {
                              if(value.isSuccess){
                                isSearching = true;
                                Navigator.of(context).pop();
                              }else{
                                isSearching = false;
                                Navigator.of(context).pop();
                              }
                            });

                          },height: 25,
                              wight: 100,
                              textSize: Dimensions.BODY_10,
                              padding: 2)
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Container(
                        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                        width: MediaQuery.of(context).size.width,
                        child: Text(AppConstants.Related_jobs,style: TextStyle(color: ColorsResource.PRAYMARY_TEXT_COLOR),),
                    ),
                    Container(
                      height: 1,
                      color: ColorsResource.PRAYMARY_TEXT_COLOR,
                    )
                  ],
                ),
              ),
             // EmploymentItem(),
              Expanded(
                  flex: 11,
                  child: jobProvider.viewAllJobsModel != null? ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: jobProvider.viewAllJobsData!.length,
                    itemBuilder: (BuildContext context, int index) {
                      ViewAllJobsData viewAllJobData = jobProvider.viewAllJobsData![index];
                      return EmploymentItem(viewAllJobData);
                    },
                  ) : Container(
                    child: const Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    ),
                  )
              ),

              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(top: 10,bottom: 5),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    width: MediaQuery.of(context).size.width,
                    height: 33,
                    child: Align(
                      alignment: Alignment.center,
                      child: jobProvider.viewAllJobsModel != null ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: jobProvider.viewAllJobsModel!.meta!.links!.length,
                        itemBuilder: (BuildContext context, int index){
                          List<LinksMeta>? linkList = jobProvider.viewAllJobsModel!.meta!.links!;
                          LinksMeta linkMeta = jobProvider.viewAllJobsModel!.meta!.links![index];
                          int lastItemIndexNumber = linkList.length - 1;
                          if(index == 0){
                            return InkWell(
                              onTap: (){
                                if(linkMeta.url != null){
                                  isSearching == true ? sPageCount = sPageCount -1 : pageCount = pageCount - 1;
                                  Provider.of<JobProvider>(context, listen: false).getVewAllJob(pageCount);
                                }else{
                                  showCustomSnackBar('No more page', context);
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.all(5),
                                decoration: selectNextButtonBoxDecoration(),
                                width: 20,
                                height: 10,
                                child: Container(
                                    width: 10,
                                    height: 10,
                                    margin: EdgeInsets.all(3),
                                    child: SvgPicture.asset(AppImages.ic_back_forword,width: 10, height: 10,)),
                              ),
                            );
                          }else if (index == lastItemIndexNumber){
                            return InkWell(
                              onTap: (){
                                if(linkMeta.url != null){
                                  isSearching == true ? sPageCount = sPageCount + 1 : pageCount = pageCount + 1;

                                  print('fshdghdsh${pageCount }');
                                  Provider.of<JobProvider>(context, listen: false).getVewAllJob(pageCount);
                                }else{
                                  showCustomSnackBar('No more page', context);
                                }
                              },
                              child: Container(
                                  margin: EdgeInsets.all(5),
                                  decoration: unselectNextButtonBoxDecoration(),
                                  width: 22,
                                  height: 22,
                                  child: Container(
                                      margin: EdgeInsets.all(2),
                                      child: SvgPicture.asset(AppImages.ic_forword,))),
                            );
                          }else {
                            return InkWell(
                              onTap: (){
                                pageCount = int.parse(linkMeta.label!);
                                Provider.of<JobProvider>(context, listen: false).getVewAllJob(pageCount);
                              },
                              child: Container(
                                margin: EdgeInsets.all(5),
                                decoration: linkMeta.active == true?  selectPossitionButtonBoxDecoration() : unselectPossitionButtonBoxDecoration(),
                                width: 22,
                                height: 22,
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Text('${linkMeta.label}',textAlign: TextAlign.center, style: TextStyle(color: ColorsResource.PRAYMARY_TEXT_COLOR),))),
                              ),
                            );
                          }
                        },
                      ) : Container(
                        child: const Align(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  selectLocationDropdown() {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width / 1.1,
      decoration: myBoxDecoration(),
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: Align(
          alignment: Alignment.centerRight,
          child: DropdownButton<String>(
            elevation: 16,
            isExpanded: true,
            style: TextStyle(color: ColorsResource.TEXT_BLACK_COLOR),
            underline: Container(
              height: 2,
              color: Colors.transparent,
            ),
            hint: Text(locationHintValWord,
              style: TextStyle(
                  fontWeight: Dimensions.FONT_MEDIUM_NORMUL,
                  fontSize: Dimensions.BODY_16,
                  color: locationHintValWord != AppConstants.Select_the_municipality ? ColorsResource.TEXT_BLACK_COLOR : ColorsResource.TEXT_GRAY_COLOR),
            ),
            iconSize: 30,
            //value: locationValueWord,
            //add this parameter
            items: locationList.map((String dropDownStringItem) {
              return DropdownMenuItem(
                value: dropDownStringItem,
                child: Text(
                  dropDownStringItem,
                  style: TextStyle(
                      fontWeight: Dimensions.FONT_MEDIUM_NORMUL,
                      fontSize: Dimensions.BODY_16,
                      color: dropDownStringItem != AppConstants.Select_the_municipality ? ColorsResource.TEXT_BLACK_COLOR : ColorsResource.TEXT_GRAY_COLOR),
                ),
              );
            }).toList(),
            onChanged: (selectedValue) {
              setState(() {
                locationHintValWord = selectedValue!;
                locationListId = locationListIdList[locationList.indexOf(selectedValue)];


               // print('${locationListIdList.indexOf(locationList.indexOf(selectedValue))}');
               // print('${locationListIdList[locationList.indexOf(selectedValue)]} ');


              });
            },
          ),
        ),
      ),
    );
  }
  selectGradeDropdown() {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width / 1.1,
      decoration: myBoxDecoration(),
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: Align(
          alignment: Alignment.centerRight,
          child: DropdownButton<String>(
            elevation: 16,
            isExpanded: true,
            style: TextStyle(color: ColorsResource.TEXT_BLACK_COLOR),
            underline: Container(
              height: 2,
              color: Colors.transparent,
            ),
            hint: Text(
              gradHintValWord,
              style: TextStyle(
                  fontWeight: Dimensions.FONT_MEDIUM_NORMUL,
                  fontSize: Dimensions.BODY_16,
                  color: ColorsResource.TEXT_GRAY_COLOR),
            ),
            iconSize: 30,
            value: gradValueWord,
            //add this parameter
            items: gradList.map((String dropDownStringItem) {
              return DropdownMenuItem(
                value: dropDownStringItem,
                child: Text(
                  dropDownStringItem,
                  style: TextStyle(
                      fontWeight: Dimensions.FONT_MEDIUM_NORMUL,
                      fontSize: Dimensions.BODY_16,
                      color: dropDownStringItem !=
                          AppConstants.grade
                          ? ColorsResource.TEXT_BLACK_COLOR
                          : ColorsResource.TEXT_GRAY_COLOR),
                ),
              );
            }).toList(),
            onChanged: (selectedValue) {
              setState(() {
                gradValueWord = selectedValue!;
                gradHintValWord = selectedValue;
                gradListId = gradListIdList[gradList.indexOf(selectedValue)];
                print(gradListId);
              });
            },
          ),
        ),
      ),
    );
  }
  myBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: ColorsResource.WHAIT,
      border: Border.all(
        color: ColorsResource.PRAYMARY_TEXT_COLOR,
        width: 1,
      ),
    );
  }
  selectNextButtonBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(3),
      color: ColorsResource.TEXT_GRAY_COLOR_LOW,
      border: Border.all(
        color: ColorsResource.TEXT_GRAY_COLOR_LOW,
        width: 1,
      ),
    );
  }
  unselectNextButtonBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(3),
      color: ColorsResource.WHAIT,
      border: Border.all(
        color: ColorsResource.TEXT_GRAY_COLOR_LOW,
        width: 1,
      ),
    );
  }
  selectPossitionButtonBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(3),
      color: ColorsResource.WHAIT,
      border: Border.all(
        color: ColorsResource.PRAYMARY_TEXT_COLOR,
        width: 2,
      ),
    );
  }
  unselectPossitionButtonBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(3),
      color: ColorsResource.WHAIT,
      border: Border.all(
        color: ColorsResource.TEXT_GRAY_COLOR,
        width: 1,
      ),
    );
  }


}
