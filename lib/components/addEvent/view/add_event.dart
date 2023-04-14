import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../Data/Models/organizer_model.dart';
import '../../../Data/Models/user_model.dart';
import '../../../Data/State/account_cubit.dart';
import '../../../Data/State/organizer_cubit.dart';
import '../../../core/product/helper/image_picker.dart';
import '../../../core/product/helper/text_field.dart';
import '../../../core/product/navigator/app_router.dart';
import '../../discovery/viewModel/event_categories.dart';

final eventTitle = TextEditingController();
String eventCategory = "Kategory Seç";
final eventDescription = TextEditingController();
bool needTicket = true;
String eventPlatform = "Lokasyonu Seç";
final eventUrl = TextEditingController();
final eventCapacity = TextEditingController();
final eventPrice = TextEditingController();
late DateTime? eventDate;
late TimeOfDay? eventTime;

const Map<String, String> platformList = {"Sadece Local": "OnlyLocal", "Sadece Online": "OnlyOnline", "Her İkiside": "OnlineAndLocal"};

class AddEventPage extends StatefulWidget {
  AddEventPage({super.key, required this.currentUser, required this.currentOrganizer, required this.parentContex});
  final BuildContext parentContex;
  late final UserModel? currentUser;
  late final OrganizerModel? currentOrganizer;
  LatLng selectAddressCor = LatLng(0, 0);
  String selectAddressText = "";

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.currentUser!.organizer != true
          ? showDialog<String>(
              context: context,
              builder: (BuildContext showctx) => AlertDialog(
                title: const Text('organizatör olmak istermisin'),
                content: const Text('Organizatör hesab olarak devam etmek ister misin ?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      AutoRouter.of(context).popAndPush(RootRoute());
                    },
                    child: const Text('Hayır'),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<AccountCubit>().toBeOrganizer(widget.currentUser!.id!);
                      context.read<AccountCubit>().loadingUserData();
                      AutoRouter.of(context).popAndPush(RootRoute());
                    },
                    child: const Text('Evet'),
                  ),
                ],
              ),
            )
          : "";
    });
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return widget.currentUser!.organizer != null && widget.currentUser!.organizer == true
        ? Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Row(children: [
                      Expanded(
                          child: //Titles
                              TextFormField(
                        decoration: ITextFieldStyle("Title"),
                        controller: eventTitle,
                        maxLength: 30,
                      )),
                      const SizedBox(width: 10),
                      //Price
                      Expanded(
                        child: //Price
                            Container(
                          padding: EdgeInsets.all(5),
                          decoration:
                              BoxDecoration(border: Border.all(color: Colors.grey.shade700), borderRadius: BorderRadius.circular(5)),
                          child: DropdownButton<String>(
                              borderRadius: BorderRadius.circular(20),
                              underline: Container(color: Colors.transparent),
                              hint: Text(eventCategory),
                              isExpanded: true,
                              icon: const Icon(Icons.arrow_downward),
                              elevation: 16,
                              onChanged: (String? value) {
                                // This is called when the user selects an item.

                                setState(() {
                                  eventCategory = value!;
                                });
                              },
                              items: allCategoryList.map((value) {
                                return DropdownMenuItem<String>(
                                  value: value.name,
                                  child: Text(value.name.toString()),
                                );
                              }).toList()),
                        ),
                      )
                    ]),

                    const SizedBox(height: 10),
                    //Description
                    TextFormField(
                      decoration: ITextFieldStyle("Description"),
                      controller: eventDescription,
                      maxLines: 4,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                            //Ticket Needed
                            child: Container(
                          padding: EdgeInsets.all(5),
                          decoration:
                              BoxDecoration(border: Border.all(color: Colors.grey.shade700), borderRadius: BorderRadius.circular(5)),
                          child: DropdownButton<bool>(
                            borderRadius: BorderRadius.circular(20),
                            underline: Container(color: Colors.transparent),
                            hint: Text(needTicket ? "Bilet Gerekli" : "Bilet Gereksiz"),
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            isExpanded: true,
                            style: const TextStyle(color: Colors.white),
                            onChanged: (bool? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                needTicket = value!;
                              });
                            },
                            items: [true, false].map<DropdownMenuItem<bool>>((bool value) {
                              return DropdownMenuItem<bool>(
                                value: value,
                                child: Text(value ? "Bilet Gerekli" : "Bilet Gereksiz"),
                              );
                            }).toList(),
                          ),
                        )),
                        const SizedBox(width: 10),
                        Expanded(
                            //Event Platform
                            child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration:
                              BoxDecoration(border: Border.all(color: Colors.grey.shade700), borderRadius: BorderRadius.circular(5)),
                          child: DropdownButton<String>(
                              borderRadius: BorderRadius.circular(20),
                              underline: Container(color: Colors.transparent),
                              hint: Text(eventPlatform),
                              isExpanded: true,
                              icon: const Icon(Icons.arrow_downward),
                              elevation: 16,
                              style: const TextStyle(color: Colors.white),
                              onChanged: (String? value) {
                                // This is called when the user selects an item.

                                setState(() {
                                  eventPlatform = value!;
                                });
                              },
                              items: platformList
                                  .map((description, value) {
                                    return MapEntry(
                                        description,
                                        DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(description),
                                        ));
                                  })
                                  .values
                                  .toList()),
                        ))
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(children: [
                      Expanded(
                          child: //Titles

                              TextFormField(
                        decoration: ITextFieldStyle("Online event url"),
                        controller: eventUrl,
                        enabled: eventPlatform != "OnlyLocal",
                      ))
                    ]),
                    const SizedBox(height: 10),
                    Row(children: [
                      Expanded(
                          child: //Titles
                              TextFormField(
                                  decoration: ITextFieldStyle("Kapasite"),
                                  controller: eventCapacity,
                                  validator: (value) {
                                    if (value!.isEmpty || !RegExp(r'^[0-9]*$').hasMatch(value)) {
                                      return "Lütfen Bir sayı girin";
                                    }
                                  })),
                      SizedBox(width: 10),
                      //Price
                      Expanded(
                        child: //Price
                            TextFormField(
                                decoration: ITextFieldStyle("Price"),
                                controller: eventPrice,
                                enabled: needTicket,
                                validator: (value) {
                                  if (value!.isEmpty || !RegExp(r'^[0-9]*$').hasMatch(value)) {
                                    return "Lütfen Bir sayı girin";
                                  }
                                }),
                      )
                    ]),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () async {
                                  widget.currentOrganizer!.verify!
                                      ? showDateRangePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime(2030))
                                      : await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime(2030))
                                          .then((value) => eventDate = value);
                                  //                                showDateRangePicker(  , context: context, firstDate: DateTime.now(), lastDate: DateTime(2030));
                                },
                                child: Text("Tarih seç"))),
                        const SizedBox(width: 10),
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value) => eventTime = value);
                                },
                                child: Text("Saat seç")))
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: IImagePicker(title: "Image add +")),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: ElevatedButton.icon(
                          onPressed: () {
                            AutoRouter.of(context).push(SearchLocationRoute(isChangeCurrentLocation: false));
                          },
                          icon: const Icon(Icons.save_alt_outlined),
                          label: Text("Lokastyon seç"),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.greenAccent.shade700,
                              minimumSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height * 0.08)),
                        ))
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: ListTile(
                              title: Text("Kalan event Yayınlama Ahhın"), subtitle: Text(widget.currentOrganizer!.eventLimit.toString())),
                        ),
                        ElevatedButton.icon(
                            icon: const Icon(Icons.start),
                            label: Text("Etkinliği başlat"),
                            onPressed: () {
                              if (eventCategory == "Kategory Seç") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  WarningMessage("Kategory Seç", "Lütfen Bir Kategory Seç."),
                                );
                              }
                              if (_formKey.currentState!.validate()) {
                                if (eventDate != null && eventTime != null) {
                                  DateTime _eventTime =
                                      DateTime(eventDate!.year, eventDate!.month, eventDate!.day, eventTime!.hour, eventTime!.minute);
                                  Event newEvent = Event(
                                    title: eventTitle.text,
                                    description: eventDescription.text,
                                    category: eventCategory,
                                    ticketNeed: needTicket,
                                    online: eventPlatform != "OnlyLocal" ? true : false,
                                    eventPlatform: eventPlatform != "OnlyLocal" ? eventPlatform : "",
                                    capacity: int.parse(eventCapacity.text),
                                    price: needTicket ? int.parse(eventPrice.text) : 0,
                                    onlineEventUrl: eventPlatform != "OnlyLocal" ? eventUrl.text : "",
                                    eventDateTime: [_eventTime],
                                  );
                                  context.read<OrganizerCubit>().createNewEvent(newEvent);
                                }
                              } else {}
                            })
                      ],
                    )
                    //DatePickerDialog(initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now()),
                    //TimePickerDialog(initialTime: TimeOfDay.now()),
                  ],
                ),
              ),
            )),
          )
        : Text("");
  }
}

SnackBar WarningMessage(String title, String description) {
  return SnackBar(
      backgroundColor: Colors.transparent,
      content: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 18, color: Colors.white)),
            Text(description, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, color: Colors.white)),
          ],
        ),
        padding: EdgeInsets.all(16),
        height: 90,
        decoration: const BoxDecoration(color: Color(0xFFC72C41), borderRadius: BorderRadius.all(Radius.circular(20))),
      ));
}
