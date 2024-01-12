import 'package:ggd_ggdmart/common_widget/exit_dialouge.dart';
import 'package:ggd_ggdmart/constant/consts.dart';
import 'package:ggd_ggdmart/controlall/home_controller.dart';
import 'package:ggd_ggdmart/views/Catagory_screen/catagory_screen.dart';
import 'package:ggd_ggdmart/views/cart_screen/cart_screen.dart';
import 'package:ggd_ggdmart/views/home_screen/home_screen.dart';
import 'package:ggd_ggdmart/views/profile_screen/profile_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    //init home controller
    var controller = Get.put(HomeController());

    var nabbarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(
            icHome,
            width: 26,
          ),
          label: home),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCategories,
            width: 26,
          ),
          label: categories),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCart,
            width: 26,
          ),
          label: cart),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProfile,
            width: 26,
          ),
          label: account),
    ];

    var navBody = [
      const HomeScreen(),
      const CatagortScreen(),
      const CartScreen(),
      const ProfileScreen()
    ];

    return WillPopScope(
      onWillPop: () async {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: ((context) => exitDialouge(context)));
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(
              () => Expanded(
                child: navBody.elementAt(controller.currentNavIndex.value),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            selectedItemColor: redColor,
            selectedLabelStyle: const TextStyle(fontFamily: semibold),
            backgroundColor: whiteColor,
            type: BottomNavigationBarType.fixed,
            items: nabbarItem,
            onTap: (value) {
              controller.currentNavIndex.value = value;
            },
          ),
        ),
      ),
    );
  }
}
