import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threego/Data/Models/organizer_model.dart';
import 'package:threego/Data/State/account_cubit.dart';
import 'package:threego/core/product/helper/snack-bars.dart';
import 'package:threego/core/product/helper/text.dart';
import 'package:threego/core/product/navigator/app_router.dart';

import '../../../Data/Models/user_model.dart';

@RoutePage()
class UserPage extends StatelessWidget {
  UserPage({super.key, required this.currentUser, required this.currentOrganizer, required this.parentContex});
  final BuildContext parentContex;
  late UserModel currentUser;
  late OrganizerModel currentOrganizer;

  @override
  Widget build(BuildContext context) {
    var accountState = parentContex.read<AccountCubit>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            UserInfoPart(
                imageUrl: currentUser.imageURL ?? "",
                createdEvent: currentOrganizer.event!,
                followed: currentOrganizer.followedList!,
                follower: currentOrganizer.followerList!,
                savedEvent: currentUser.userEventStore!),
            const Divider(height: 50),
            const Card(
              child: ListTile(
                title: Text("Kaydedilenler"),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
            const Card(
              child: ListTile(
                title: Text("Ayarlar"),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
            const SizedBox(height: 100),
            Expanded(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: Card(
                child: ListTile(
                  title: const Text("hesaptan çıkış yap"),
                  trailing: IconButton(
                      onPressed: () async {
                        bool res = await accountState.logoutUser();
                        if (res) {
                          AutoRouter.of(context).push(RootRoute());
                        } else {
                          ErrorMessage("Çıkış işlemi", "Başarısız");
                        }
                      },
                      icon: const Icon(Icons.close)),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class UserInfoPart extends StatelessWidget {
  const UserInfoPart(
      {super.key,
      required this.imageUrl,
      required this.createdEvent,
      required this.followed,
      required this.follower,
      required this.savedEvent});
  final String imageUrl;
  final List<int> follower;
  final List<int> followed;
  final List<int> savedEvent;
  final List<Event> createdEvent;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //*Follower & followed info text
        Expanded(
            child: Center(
                child: Column(
          children: [
            ListTile(
              title: const CenterText(data: "Takipçi"),
              subtitle: CenterText(data: '${follower.length}'),
            ),
            ListTile(
              title: const CenterText(data: "Takip"),
              subtitle: CenterText(data: '${followed.length}'),
            )
          ],
        ))),

        //User profile photo
        Expanded(
            child: CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(imageUrl),
          radius: 70,
        )),
        Expanded(
            child: Center(
                child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ListTile(
              title: const CenterText(data: "Yaratılan Etki"),
              subtitle: CenterText(data: '${createdEvent.length}'),
            ),
            //! karar verilmedi
            const ListTile(
              title: CenterText(data: "Katılım"),
              subtitle: CenterText(
                data: '0',
              ),
            ),
          ],
        )))
      ],
    );
  }
}
