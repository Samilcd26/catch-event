import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/product/helper/image_picker.dart';
import '../../../core/product/helper/text_field.dart';

class AddEventPage extends StatefulWidget {
  AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  List<Marker> _markerlist = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(children: const [
              Expanded(
                child: //Titles
                    ILableTextField(
                  labelText: "Title",
                ),
              ),
              SizedBox(width: 10),
              //Price
              Expanded(
                child: //Price
                    ILableTextField(
                  labelText: "Price",
                ),
              )
            ]),
            const SizedBox(height: 10),
            //Description
            const ILableTextField(
              labelText: "Description",
              maxLine: 4,
              textInputType: TextInputType.multiline,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ILableTextField(
                    labelText: "Date",
                    textInputType: TextInputType.datetime,
                    icon: IconButton(onPressed: () {}, icon: const Icon(Icons.date_range)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ILableTextField(
                    labelText: "Hourse",
                    textInputType: TextInputType.datetime,
                    icon: IconButton(onPressed: () {}, icon: const Icon(Icons.more_time_sharp)),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: IImagePicker(title: "Image add +")),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.save_alt_outlined),
                  label: Text("Etkinliği başlat"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent.shade700,
                      minimumSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height * 0.08)),
                ))
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GoogleMap(
                markers: Set.of(_markerlist),
                initialCameraPosition: CameraPosition(target: LatLng(41, 29), zoom: 14),
                onTap: (argument) {
                  setState(() {
                    _markerlist.add(Marker(
                        draggable: true,
                        markerId: MarkerId('Marker'),
                        position: LatLng(argument.latitude, argument.longitude),
                        onDragEnd: ((newPosition) {
                          print(newPosition.latitude);
                          print(newPosition.longitude);
                        })));
                  });
                },
              ),
            )

            //DatePickerDialog(initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now()),
            //TimePickerDialog(initialTime: TimeOfDay.now()),
          ],
        ),
      )),
    );
  }
}
