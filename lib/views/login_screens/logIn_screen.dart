import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lmiis/utils/AppConstants.dart';
import 'package:lmiis/utils/colors_resource.dart';
import 'package:lmiis/utils/dimensions.dart';
import 'package:lmiis/views/regi_screens/RegistationScren.dart';
import 'package:lmiis/views/widgets/showCustomSnackBar.dart';

import 'package:provider/provider.dart';

import '../../models/SendDataModels/UserLogin.dart';
import '../../provider/AuthProvider.dart';
import '../../utils/app_images.dart';

import '../home_screens/home_screen.dart';
import '../reset_password/password_reset.dart';

import '../widgets/custom_text_field.dart';
import '../widgets/custtom_button.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsResource.PRAYMERY_COLOR,
      body: SingleChildScrollView(
        child: Consumer<AuthProvider>(
          builder: (context,authProvider,child) =>
          Container(
            margin: EdgeInsets.only(top: 40,left: 10,right: 10,bottom: 10),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Text(
                  AppConstants.APP_NAME,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: Dimensions.BODY_36,fontWeight: Dimensions.FONT_BOLD,color: ColorsResource.PRAYMARY_TEXT_COLOR),),
                Text(
                  AppConstants.All_the_options_in_one_place,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: Dimensions.BODY_16,fontWeight: Dimensions.FONT_MEDIUM_NORMUL,color: ColorsResource.PRAYMARY_TEXT_COLOR),),
                SizedBox(height: MediaQuery.of(context).size.height * 0.200,),
                Text(
                  AppConstants.lag_in,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: Dimensions.BODY_30,fontWeight: Dimensions.FONT_MEDIUM,color: ColorsResource.PRAYMARY_TEXT_COLOR),),
                SizedBox(height: 20,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 10,right: 10),
                  child: Column(
                    children: [
                      CustomTextFieldWithTitle('',emailTextEditingController,emailFocusNode,prefixIcon: AppImages.ic_user,insideHintText: AppConstants.E_mail,),

                      CustomTextFieldWithTitle('',passwordTextEditingController,passwordFocusNode,prefixIcon: AppImages.ic_password_key,insideHintText: AppConstants.Password,inputTypePassword:true),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        width: MediaQuery.of(context).size.width,
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const PasswordReset()));

                          },
                          onHover: (_){},
                          child: Text(AppConstants.Forgot_your_password,
                            textAlign: TextAlign.end,
                            style: TextStyle(fontSize: Dimensions.BODY_16,fontWeight: Dimensions.FONT_MEDIUM_NORMUL,color: ColorsResource.TEXT_BLACK_COLOR),),
                        ),
                      ),
                      SizedBox(height:50 ,),
                      CustomButton(AppConstants.lag_in,(){
                       // showCustomDialog(context,'Loading');
                        String email = emailTextEditingController.text;
                        String password = passwordTextEditingController.text;


                       // Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));


                        if(email == ''){
                          return showCustomSnackBar(AppConstants.E_mail, context);
                        }
                        if(password == ''){
                          return showCustomSnackBar(AppConstants.Password, context);
                        }

                        showLoaderDialog(context);
                        UserLogin userLogin = UserLogin(email: email,password: password);
                        authProvider.login(userLogin).then((value) {
                          if(value.isSuccess){
                            Navigator.of(context).pop();
                            final box = GetStorage();
                            box.write(AppConstants.USER_EMAIL, email);
                            box.write(AppConstants.USER_PASSWORD, password);
                            box.write(AppConstants.TOKEN, '${authProvider.loginToken?.token}');
                            showCustomSnackBar('Login', context,isError: false);
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => HomeScreen()), (Route<dynamic> route) => false);
                          }else{
                            Navigator.of(context).pop();
                            showCustomSnackBar(value.message, context);
                          }
                        });




                      }),
                      SizedBox(height: 10,),

                      InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistationScreen()));
                          },
                          onHover: (_){},
                          child: Text(AppConstants.Create_a_new_account,style: TextStyle(color: ColorsResource.PRAYMARY_TEXT_COLOR,fontSize: Dimensions.BODY_14,fontWeight: Dimensions.FONT_MEDIUM_NORMUL),))
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }



}
