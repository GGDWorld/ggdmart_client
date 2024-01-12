// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggd_ggdmart/common_widget/loading_indicator.dart';
import 'package:ggd_ggdmart/constant/consts.dart';
import 'package:ggd_ggdmart/controlall/home_controller.dart';
import 'package:ggd_ggdmart/controlall/product_controller.dart';
import 'package:ggd_ggdmart/services/fire_store_services.dart';
import 'package:ggd_ggdmart/views/Catagory_screen/item_details.dart';

class TodayDeals extends StatelessWidget {
  const TodayDeals({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();

    ProductController productController = Get.put(ProductController());

    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: "Today deals".text.color(fontGrey).make(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            StreamBuilder(
              stream: FirestoreServices.allProducts(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return loadingIndicator();
                } else {
                  var allproductsdata = snapshot.data!.docs;
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: allproductsdata.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      mainAxisExtent: 300,
                    ),
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            allproductsdata[index]['p_imgs'][0],
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                          const Spacer(),
                          10.heightBox,
                          "${allproductsdata[index]['p_name']}"
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                          10.heightBox,
                          "${allproductsdata[index]['p_price']}"
                              .numCurrency
                              .text
                              .color(redColor)
                              .fontFamily(bold)
                              .size(16)
                              .make(),
                        ],
                      )
                          .box
                          .white
                          .margin(const EdgeInsets.symmetric(horizontal: 12))
                          .roundedSM
                          .padding(const EdgeInsets.all(7))
                          .make()
                          .onTap(() {
                        Get.to(() => ItemDetails(
                              title: "${allproductsdata[index]['p_name']}",
                              data: allproductsdata[index],
                            ));
                      });
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
