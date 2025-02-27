import 'package:ggd_ggdmart/common_widget/applogo_widget.dart';
import 'package:ggd_ggdmart/common_widget/bg_widget.dart';
import 'package:ggd_ggdmart/common_widget/coustom_textfield.dart';
import 'package:ggd_ggdmart/common_widget/our_button.dart';
import 'package:ggd_ggdmart/constant/consts.dart';
import 'package:ggd_ggdmart/controlall/auth_controller.dart';
import 'package:ggd_ggdmart/views/auth_screen/signup_screen.dart';
import 'package:ggd_ggdmart/views/home_screen/home.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            "log in to $appname".text.fontFamily(bold).white.size(18).make(),
            18.heightBox,
            Obx(
              () => Column(
                children: [
                  coustomtextfield(
                      hint: emailhint,
                      title: email,
                      isPass: false,
                      controller: controller.emailcontroller),
                  10.heightBox,
                  coustomtextfield(
                      hint: passwordhint,
                      title: password,
                      isPass: true,
                      controller: controller.passwordcontroller),
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {}, child: forgetpas.text.make())),
                  8.heightBox,
                  controller.isloading.value
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        )
                      : ourButton(
                          color: redColor,
                          title: login,
                          textcolor: whiteColor,
                          onPress: () async {
                            controller.isloading(true);
                            await controller
                                .loginMethod(context: context)
                                .then((value) {
                              if (value != null) {
                                VxToast.show(context, msg: loginsucess);
                                controller.isloading(false);
                                Get.offAll(() => const Home());
                              } else {
                                controller.isloading(false);
                              }
                            });
                          }).box.width(context.screenWidth - 50).make(),
                  6.heightBox,
                  createnewaccount.text.color(fontGrey).make(),
                  6.heightBox,
                  ourButton(
                      color: lightgolden,
                      title: signup,
                      textcolor: golden,
                      onPress: () {
                        Get.to(() => const SignupScreen());
                      }).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  loginwith.text.color(fontGrey).make(),
                  6.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        3,
                        (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: lightGrey,
                                radius: 25,
                                child: Image.asset(
                                  socialIconlist[index],
                                  width: 30,
                                ),
                              ),
                            )),
                  )
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(const EdgeInsets.all(15))
                  .width(context.screenWidth - 60)
                  .shadowSm
                  .make(),
            )
          ],
        ),
      ),
    ));
  }
}
