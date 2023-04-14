import 'package:flutter/material.dart';

import '../../../Data/Models/user_model.dart';

class UserPage extends StatelessWidget {
  UserPage({super.key, required this.currentUser, required this.parentContex});
  final BuildContext parentContex;
  late UserModel currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {},
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Center(
                        child: Column(
                  children: const [
                    Text("Takipçisayıı"),
                    SizedBox(
                      height: 40,
                    ),
                    Text("takip edilen")
                  ],
                ))),
                Expanded(
                    child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.teal,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(currentUser.imageURL.toString()),
                    radius: 58,
                  ),
                )),
                Expanded(
                    child: Center(
                        child: Column(
                  children: const [
                    Text("Katınılan Etkinlikler"),
                    SizedBox(
                      height: 40,
                    ),
                    Text("BEyenilme oranı")
                  ],
                )))
              ],
            ),
            const Divider(height: 50),
            const Card(
              child: ListTile(
                title: Text("title"),
                subtitle: Text("subtitle"),
                leading: FlutterLogo(size: 35),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Kaydedilenler"),
                subtitle: Text("Kaydedilen etkinlikler"),
                leading: FlutterLogo(size: 35),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
            )
          ],
        ),
      ),
    );
  }
}
