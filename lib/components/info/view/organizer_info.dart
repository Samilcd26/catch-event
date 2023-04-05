import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Data/Models/organizer_model.dart';
import '../../../Data/Models/user_model.dart';
import '../../../Data/State/account_cubit.dart';
import '../../../Data/State/ssfl_cubit.dart';
import '../../../core/product/helper/loading_animation.dart';

class OrganizerInfoPage extends StatefulWidget {
  OrganizerInfoPage({super.key, required this.organizerModel});

  OrganizerModel organizerModel;

  @override
  State<OrganizerInfoPage> createState() => _OrganizerInfoPageState();
}

class _OrganizerInfoPageState extends State<OrganizerInfoPage> {
  late bool isSub;
  late final UserModel? currentUser;
  @override
  void initState() {
    currentUser = context.read<AccountCubit>().currentUser;
    if (currentUser != null && currentUser!.followOrganizer != null) {
      isSub = currentUser!.followOrganizer!.contains(widget.organizerModel.id);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return context.watch<AccountCubit>().isLoading
        ? Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.black,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new),
                  onPressed: () {
                    context.router.navigateBack();
                  },
                )),
            body: Column(
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
                        backgroundImage: NetworkImage(widget.organizerModel.image.toString()),
                        radius: 58,
                      ),
                    )),
                    Expanded(
                        child: Center(
                            child: Column(
                      children: const [
                        Text("Aktif etkinlikelr"),
                        SizedBox(
                          height: 40,
                        ),
                        Text("BEyenilme oranı")
                      ],
                    )))
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(),
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("data"),
                      ElevatedButton.icon(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(const StadiumBorder()),
                              backgroundColor: const MaterialStatePropertyAll(Colors.black)),
                          onPressed: () {
                            setState(() {
                              if (isSub) {
                                context.read<SSFLCubit>().unfollowOrganizer(currentUser!.id!, widget.organizerModel.id!);
                                chanceSubStatus();
                              } else {
                                context.read<SSFLCubit>().followOrganizer(currentUser!.id!, widget.organizerModel.id!);
                                chanceSubStatus();
                              }
                            });
                          },
                          icon: isSub ? const Icon(Icons.check_circle_outline_rounded) : const Icon(Icons.add),
                          label: isSub ? const Text("") : const Text("Sub"))
                    ],
                  ),
                  subtitle: Text(widget.organizerModel.description.toString()),
                ),
                const SizedBox(height: 10),
                const Divider(),
                /*
          ListView.builder(itemBuilder: (contex,index){
            //EventInfoCard(eventAddress: eventAddress, eventDates: eventDates, eventPrice: eventPrice, eventTitle: eventTitle, imageUrl: imageUrl)
          })
          */
              ],
            ),
          )
        : const LoadingBar();
  }

  void chanceSubStatus() {
    isSub = !isSub;
  }
}
