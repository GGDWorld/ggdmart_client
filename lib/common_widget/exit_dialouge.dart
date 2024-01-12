import 'package:flutter/services.dart';
import 'package:ggd_ggdmart/common_widget/our_button.dart';
import 'package:ggd_ggdmart/constant/consts.dart';

Widget exitDialouge(context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        const Divider(),
        10.heightBox,
        "Are you sure you want to exit"
            .text
            .size(16)
            .color(darkFontGrey)
            .make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(
                color: redColor,
                onPress: () {
                  SystemNavigator.pop();
                },
                textcolor: whiteColor,
                title: "Yes"),
            ourButton(
                color: bluecolor,
                onPress: () {
                  navigator!.pop(context);
                },
                textcolor: whiteColor,
                title: "No"),
          ],
        ),
        40.heightBox
      ],
    ).box.color(lightGrey).padding(const EdgeInsets.all(26)).rounded.make(),
  );
}
