import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lmiis/models/SendDataModels/ChangePasswordSendModel.dart';
import 'package:lmiis/provider/AuthProvider.dart';
import 'package:provider/provider.dart';

import '../../utils/AppConstants.dart';
import '../../utils/app_images.dart';
import '../../utils/colors_resource.dart';
import '../../utils/dimensions.dart';
import '../home_screens/home_screen.dart';

import '../widgets/custom_text_field.dart';
import '../widgets/custtom_button.dart';
import '../widgets/showCustomSnackBar.dart';

class ChnagePassword extends StatefulWidget {
  const ChnagePassword({Key? key}) : super(key: key);

  @override
  State<ChnagePassword> createState() => _ChnagePasswordState();
}

class _ChnagePasswordState extends State<ChnagePassword> {

  TextEditingController currentPasswordTextEditingController = TextEditingController();
  TextEditingController newPasswordTextEditingController = TextEditingController();
  TextEditingController enterTheNewPasswordAgainTextEditingController = TextEditingController();
  FocusNode currentPasswordFocusNode = FocusNode();
  FocusNode newPasswordFocusNode = FocusNode();
  FocusNode enterTheNewPasswordAgainFocusNode = FocusNode();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Consumer<AuthProvider>(
        builder: (context,authProvider,child) =>
        Column(
          children: [
            Container(
              height: 100,
              color: ColorsResource.PRAYMERY_COLOR,
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 50, left: 10, right: 10),
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
                            child: SvgPicture.asset(AppImages.ic_back_blue)),
                        SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width - 65,
                          child: Text(
                            AppConstants.Change_the_password,
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
              margin: const EdgeInsets.only(left: 20,right: 20,top: 60),
              child: Column(
                children: [
                  CustomTextFieldWithTitle('',currentPasswordTextEditingController,currentPasswordFocusNode,insideHintText: AppConstants.current_password,inputTypePassword:true),
                  const SizedBox(height: 10,),
                  CustomTextFieldWithTitle('',newPasswordTextEditingController,newPasswordFocusNode,insideHintText: AppConstants.new_password,inputTypePassword:true),
                  const SizedBox(height: 5,),
                  CustomTextFieldWithTitle('',enterTheNewPasswordAgainTextEditingController,enterTheNewPasswordAgainFocusNode,insideHintText: AppConstants.enter_the_new_password_again,inputTypePassword:true),
                  const SizedBox(height: 30,),
                  CustomButton(AppConstants.Change_the_password_button,(){
                    String currentPassword= currentPasswordTextEditingController.text;
                    String newPassword= newPasswordTextEditingController.text;
                    String againNewPassword = enterTheNewPasswordAgainTextEditingController.text;

                    if(currentPassword == ''){
                      return showCustomSnackBar(AppConstants.current_password,context);
                    }

                    if(newPassword == ''){
                      return showCustomSnackBar(AppConstants.new_password,context);
                    }

                    if(againNewPassword == ''){
                      return showCustomSnackBar(AppConstants.enter_the_new_password_again,context);
                    }


                    ChangePasswordSendModel changePasswordSendModel = ChangePasswordSendModel(currentpassword: currentPassword,password: newPassword,passwordConfirmation: againNewPassword);


                    authProvider.changePassword(changePasswordSendModel).then((value) {
                      if(value.isSuccess){
                        currentPasswordTextEditingController.text = '';
                        newPasswordTextEditingController.text= '';
                        enterTheNewPasswordAgainTextEditingController.text= '';

                        showCustomSnackBar(value.message,context,isError: false);
                        successDialog(AppConstants.Password_has_been_successfully_reset);

                      }else{
                        showCustomSnackBar(value.message,context);
                      }
                    });


                  }, wight:250),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  successDialog(String title){
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)), //this right here
              child: Container(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(3),
                          topLeft: Radius.circular(3),
                        ),
                        color: ColorsResource.WHAIT,
                        border: Border.all(
                          color: ColorsResource.WHAIT,
                          width: 1,
                        ),
                      ),
                      height: 30,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onHover: (_){},
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                            },
                            child: Container(
                                margin: EdgeInsets.only(right: 10),
                                child: SvgPicture.asset(AppImages.ic_close,color: ColorsResource.TEXT_BLACK_COLOR,)),
                          )
                        ],
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                        child: Text(title,textAlign:TextAlign.center, style: TextStyle(fontSize: Dimensions.BODY_20,color: ColorsResource.TEXT_BLACK_COLOR),)),
                    SizedBox(height: 20,),
                    Align(
                        alignment: Alignment.center,
                        child: SvgPicture.asset(AppImages.ic_sucses))
                  ],
                ),
              )
          );
        }
    );
  }

}
