import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggd_ggdmart/common_widget/loading_indicator.dart';
import 'package:ggd_ggdmart/constant/consts.dart';
import 'package:ggd_ggdmart/services/fire_store_services.dart';
import 'package:ggd_ggdmart/views/chat_screen/chat_screen.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Messages".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getAllMessage(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No Messages yet !"
                  .text
                  .color(darkFontGrey)
                  .fontFamily(semibold)
                  .makeCentered();
            } else {
              var data = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                child: ListTile(
                                  onTap: () {
                                    Get.to(
                                      () => const ChatScreen(),
                                      arguments: [
                                        data[index]['friend_name'],
                                        data[index]['toId'],
                                      ],
                                    );
                                  },
                                  leading: const CircleAvatar(
                                    backgroundColor: redColor,
                                    child: Icon(
                                      Icons.person,
                                      color: whiteColor,
                                    ),
                                  ),
                                  title: "${data[index]['friend_name']}"
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                  subtitle: "${data[index]['last_msg']}"
                                      .text
                                      .color(darkFontGrey)
                                      .make(),
                                ),
                              );
                            }))
                  ],
                ),
              );
            }
          }),
    );
  }
}
