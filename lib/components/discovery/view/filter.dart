import 'package:flutter/material.dart';

import '../../../core/product/helper/text.dart';
import '../../../core/product/helper/text_field.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

bool isOnline = false;
bool ticketNeed = false;
bool free = false;

class _FilterPageState extends State<FilterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(heroTag: "CancelBtn", backgroundColor: Colors.redAccent, child: Icon(Icons.cancel), onPressed: () {}),
          const SizedBox(width: 5),
          FloatingActionButton(heroTag: "AcceptBtn", backgroundColor: Colors.greenAccent, child: Icon(Icons.check), onPressed: () {})
        ],
      ),
      appBar: AppBar(backgroundColor: Colors.black),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeadSmallText(text: "Online/local"),
            const Divider(),
            //Online or Local
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    title: const Text("Online"),
                    value: true,
                    groupValue: isOnline,
                    onChanged: (value) {
                      setState(() {
                        isOnline = value!;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: const Text("Local"),
                    value: false,
                    groupValue: isOnline,
                    onChanged: (value) {
                      setState(() {
                        isOnline = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const Divider(),
            HeadSmallText(text: "Ticket Need"),
            //TicketNeed
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    title: const Text("Need"),
                    value: true,
                    groupValue: ticketNeed,
                    onChanged: (value) {
                      setState(() {
                        ticketNeed = value!;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: const Text("Not Need"),
                    value: false,
                    groupValue: ticketNeed,
                    onChanged: (value) {
                      setState(() {
                        ticketNeed = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const Divider(),
            Align(alignment: Alignment.topLeft, child: HeadSmallText(text: "Price")),
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    title: const Text("Need"),
                    value: true,
                    groupValue: free,
                    onChanged: (value) {
                      setState(() {
                        free = value!;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: const Text("Not Need"),
                    value: false,
                    groupValue: free,
                    onChanged: (value) {
                      setState(() {
                        free = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: const [
                Expanded(
                    child: ILableTextField(
                  labelText: "En Az",
                )),
                Expanded(
                    child: ILableTextField(
                  labelText: "En  Çok",
                ))
              ],
            ),
            const Divider(),
            HeadSmallText(text: "Zaman Aralığı"),
            Row(
              children: const [
                Expanded(
                    child: ILableTextField(
                  labelText: "En Az",
                )),
                Expanded(
                    child: ILableTextField(
                  labelText: "En  Çok",
                ))
              ],
            ),
            const Divider(),
            Text("Kategory"),
          ],
        ),
      ),
    );
  }
}
