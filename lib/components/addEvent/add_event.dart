// ignore_for_file: prefer_const_constructors_in_immutables, use_build_context_synchronously

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:threego/app/app_router.dart';
import 'package:threego/components/discovery/event_categories.dart';
import 'package:threego/core/SubWidgets/image_picker.dart';
import 'package:threego/core/SubWidgets/snack-bars.dart';
import 'package:threego/core/SubWidgets/text_field.dart';

import '../../../Data/Models/organizer_model.dart';
import '../../../Data/Models/user_model.dart';
import '../../../Data/State/account_cubit.dart';
import '../../../Data/State/organizer_cubit.dart';

//* Variables //////////////////////////////////////////////////////////////////
final eventTitle = TextEditingController();
String eventType = "";
String eventCategory = "Kategory Seç";
final eventDescription = TextEditingController();
bool needTicket = true;
String eventPlatform = "Lokasyonu Seç";
final eventUrl = TextEditingController();
final eventCapacity = TextEditingController();
final eventPrice = TextEditingController();
late DateTime? eventDate;
late TimeOfDay? eventTimeAndDay;
const Map<String, String> platformList = {"Sadece Local": "OnlyLocal", "Sadece Online": "OnlyOnline", "Her İkiside": "OnlineAndLocal"};
//* ////////////////////////////////////////////////////////////////////////////

@RoutePage()
class AddEventPage extends StatefulWidget {
  AddEventPage({super.key, required this.currentUser, required this.currentOrganizer, required this.parentContex});

  final BuildContext parentContex;
  late final UserModel? currentUser;
  late final OrganizerModel? currentOrganizer;

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  @override
  void initState() {
    var accountState = context.read<AccountCubit>();
    super.initState();
    //? check to be organizer
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.currentUser!.organizer != true
          ? showDialog<String>(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext showctx) => AlertDialog(
                title: const Text('organizatör olmak istermisin'),
                content: const Text('''
                                        ## Eğer [Onaylı Organizatör]("www.organiz") olmak İsterseniz:
                                        * Ayda 15 gün etkinlik yayınlama
                                        * Etkinliklerinizin ön plana çıkması
                                        * Ve birsürü faydalı içerik
                                        '''),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      AutoRouter.of(context).popAndPush(RootRoute());
                    },
                    child: const Text('Hayır'),
                  ),
                  TextButton(
                    onPressed: () {
                      accountState.toBeOrganizer(widget.currentUser!.id!);
                      //_accountState.initializ();
                      AutoRouter.of(context).popAndPush(RootRoute());
                    },
                    child: const Text('Evet'),
                  ),
                ],
              ),
            )
          : "";
    });
    //? /////////////////////////
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return widget.currentUser!.organizer != null && widget.currentUser!.organizer == true
        ? Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Expanded(flex: 1, child: Text("Event Tipi:")),
                          Expanded(
                            flex: 2,
                            child: DropdownButton<String>(
                              borderRadius: BorderRadius.circular(20),
                              underline: Container(color: Colors.transparent),
                              hint: Text(eventType.toString()),
                              icon: const Icon(Icons.arrow_downward),
                              elevation: 16,
                              isExpanded: true,
                              //style: const TextStyle(color: Colors.white),
                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  eventType = value!;
                                });
                              },
                              items: ["EVENT", "NOTIFICATION", "CAMPAIGN"].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(children: [
                        Expanded(
                            child: //Titles
                                TextFormField(
                                    decoration: ITextFieldStyle("Title"),
                                    controller: eventTitle,
                                    maxLength: 30,
                                    validator: (value) {
                                      if (value.ext.isNullOrEmpty) {
                                        return "Boş Olamz";
                                      } else {
                                        if (value!.length < 5) {
                                          return "15 Karekterende fazla olmaı";
                                        }
                                      }
                                      return null;
                                    })),
                        const SizedBox(width: 10),
                        //Price
                        Expanded(
                          child: //Price
                              Container(
                            padding: const EdgeInsets.all(5),
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
                      //Description input
                      TextFormField(
                        validator: (value) {
                          if (value.ext.isNullOrEmpty) {
                            return "Boş Olamz";
                          } else {
                            if (value!.length < 15) {
                              return "15 Karekterende fazla olmaı";
                            }
                          }
                          return null;
                        },
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
                            padding: const EdgeInsets.all(5),
                            decoration:
                                BoxDecoration(border: Border.all(color: Colors.grey.shade700), borderRadius: BorderRadius.circular(5)),
                            child: DropdownButton<bool>(
                              borderRadius: BorderRadius.circular(20),
                              underline: Container(color: Colors.transparent),
                              hint: Text(needTicket ? "Bilet Gerekli" : "Bilet Gereksiz"),
                              icon: const Icon(Icons.arrow_downward),
                              elevation: 16,
                              isExpanded: true,
                              //style: const TextStyle(color: Colors.white),
                              onChanged: eventType == "EVENT" || eventType == "CAMPAIGN"
                                  ? (bool? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        needTicket = value!;
                                      });
                                    }
                                  : null,
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
                              //*Event Platform
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
                            child: //Online Evet URL

                                TextFormField(
                          decoration: ITextFieldStyle("Online event url"),
                          controller: eventUrl,
                          enabled: eventPlatform != "OnlyLocal" && eventType != "NOTIFICATION",
                          validator: (value) {
                            if (eventType != "NOTIFICATION") {
                              if (eventPlatform != "OnlyLocal") {
                                if (value.ext.isNullOrEmpty) {
                                  return "Boş Olamz";
                                }
                              }
                            }
                            return null;
                          },
                        ))
                      ]),
                      const SizedBox(height: 10),
                      Row(children: [
                        Expanded(
                            child: //Titles
                                TextFormField(
                                    decoration: ITextFieldStyle("Kapasite"),
                                    controller: eventCapacity,
                                    enabled: eventType == "EVENT",
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (eventType == "EVENT") {
                                        if (value!.isEmpty || !RegExp(r'^[0-9]*$').hasMatch(value)) {
                                          return "Lütfen Bir sayı girin";
                                        }
                                      }
                                      return null;
                                    })),
                        const SizedBox(width: 10),
                        //Price
                        Expanded(
                          child: //Price
                              TextFormField(
                                  decoration: ITextFieldStyle("Price"),
                                  controller: eventPrice,
                                  enabled: needTicket && eventType == "EVENT",
                                  validator: (value) {
                                    if (eventType == "EVENT") {
                                      if (needTicket) {
                                        if (value!.isEmpty || !RegExp(r'^[0-9]*$').hasMatch(value)) {
                                          return "Lütfen Bir sayı girin";
                                        }
                                      }
                                    }
                                    return null;
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
                                  child: const Text("Tarih seç"))),
                          const SizedBox(width: 10),
                          Expanded(
                              child: ElevatedButton(
                                  onPressed: () {
                                    showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value) => eventTimeAndDay = value);
                                  },
                                  child: const Text("Saat seç")))
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
                            label: const Text("Lokastyon seç"),
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
                                title: const Text("Kalan event Yayınlama Ahhın"),
                                subtitle: Text(widget.currentOrganizer!.eventLimit.toString())),
                          ),
                          ElevatedButton.icon(
                              icon: const Icon(Icons.start),
                              label: const Text("Etkinliği başlat"),
                              onPressed: () async {
                                if (eventCategory == "Kategory Seç") {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    WarningMessage("Kategory Seç", "Lütfen Bir Kategory Seç."),
                                  );
                                }
                                if (formKey.currentState!.validate()) {
                                  if (eventDate != null && eventTimeAndDay != null) {
                                    DateTime eventTime = DateTime(
                                        eventDate!.year, eventDate!.month, eventDate!.day, eventTimeAndDay!.hour, eventTimeAndDay!.minute);

                                    Event newEvent = Event(
                                      title: eventTitle.text,
                                      description: eventDescription.text,
                                      category: eventCategory,
                                      ticketNeed: eventType == "Event" ? needTicket : false,
                                      type: eventType,
                                      online: eventPlatform != "OnlyLocal" && eventType == "EVENT" ? true : false,
                                      eventPlatform: eventPlatform,
                                      capacity: eventType == "Event" ? int.parse(eventCapacity.text) : 0,
                                      price: needTicket && eventType == "Event" ? int.parse(eventPrice.text) : 0,
                                      onlineEventUrl: eventPlatform != "OnlyLocal" ? eventUrl.text : "",
                                      eventDateTime: [eventTime],
                                    );
                                    bool isCreat = false;
                                    await context.read<OrganizerCubit>().createNewEvent(newEvent).then((value) => isCreat = value);
                                    if (isCreat) {
                                      if (!context.mounted) return;
                                      AnimatedSnackBar.rectangle(
                                        'Başarılı',
                                        'Etkinlik yayınlandı',
                                        type: AnimatedSnackBarType.success,
                                        brightness: Brightness.light,
                                      ).show(
                                        context,
                                      );
                                    } else {
                                      if (!context.mounted) return;
                                      AnimatedSnackBar.rectangle(
                                        'Hata',
                                        'Bİr Hata oluştu lütefen kontrol edin',
                                        type: AnimatedSnackBarType.error,
                                        brightness: Brightness.light,
                                      ).show(
                                        context,
                                      );
                                    }
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
              ),
            )),
          )
        : const Text("");
  }

  Future<void> setEventImage() async {}
}
