import 'package:auto_route/auto_route.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Data/State/account_cubit.dart';
import '../../../core/product/helper/loading_animation.dart';

@RoutePage()
class TicketPage extends StatelessWidget {
  const TicketPage({super.key, required this.parentContex});
  final BuildContext parentContex;

  @override
  Widget build(BuildContext context) {
    return parentContex.watch<AccountCubit>().isLoading
        ? SafeArea(
            child: Scaffold(
              backgroundColor: Colors.grey.shade300,
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(children: [
                  InkWell(
                    child: _ticketWidget(),
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: ((context) {
                            return Container(
                              color: Colors.red,
                            );
                          }));
                    },
                  ),
                ]),
              ),
            ),
          )
        : const LoadingBar();
  }
}

final dm = Barcode.dataMatrix();

class _ticketWidget extends StatelessWidget {
  _ticketWidget({
    super.key,
  });

// Generate a SVG with "Hello World!"

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage("https://cdn.pixabay.com/photo/2016/09/08/18/45/cube-1655118_960_720.jpg"))),
            child: Column(
              children: [
                Text("Title", style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 10),
                const Text("Slogan"),
                const SizedBox(height: 10),
                const _infoCardWidget(title: "22:30", subTitle: "Saat"),
                const SizedBox(height: 10),
                const _infoCardWidget(title: "06/04/2023", subTitle: "Tarih")
              ],
            ),
          ),
        ),

        //Barkod resmini büyüt büyüt
        Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {},
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BarcodeWidget(
                    width: 50,
                    height: 150,
                    barcode: Barcode.qrCode(),
                    data: 'Hello Flutter',
                  ),
                ),
              ),
            ))
      ],
    ));
  }
}

class _infoCardWidget extends StatelessWidget {
  const _infoCardWidget({super.key, required this.title, required this.subTitle});
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text(title), Text(subTitle)],
    );
  }
}
