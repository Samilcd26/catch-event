import 'package:barcode_widget/barcode_widget.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_widget/ticket_widget.dart';

import '../../../Data/State/root_cubit.dart';
import '../../../core/product/helper/loading_animation.dart';

class TicketPage extends StatelessWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<RootCubit>().loadingInitData();
    final dm = Barcode.dataMatrix();

// Generate a SVG with "Hello World!"
    final svg = dm.toSvg('Hello World!', width: 200, height: 200);

    return context.watch<RootCubit>().isLoading
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

class _ticketWidget extends StatelessWidget {
  const _ticketWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TicketWidget(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.3,
        isCornerRounded: true,
        padding: EdgeInsets.all(20),
        child: Center(
            child: Column(
          children: [
            Text("Title", style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 10),
            const Text("Slogan"),
            const SizedBox(height: 40),
            const DottedLine(lineThickness: 3),
            const SizedBox(height: 20),
            const _infoCardWidget(title: "22:30", subTitle: "Saat"),
            const SizedBox(height: 10),
            const _infoCardWidget(title: "06/04/2023", subTitle: "Tarih")
          ],
        )));
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
