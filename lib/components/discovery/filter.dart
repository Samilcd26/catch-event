// ignore_for_file: use_build_context_synchronously

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:threego/components/discovery/event_categories.dart';
import 'package:threego/core/SubWidgets/text.dart';
import 'package:threego/core/SubWidgets/text_field.dart';

import '../../../Data/Models/category_model.dart';
import '../../../Data/Models/filter_organizer_model.dart';
import '../../../Data/State/account_cubit.dart';

@RoutePage()
class FilterPage extends StatefulWidget {
  const FilterPage({super.key, required this.parentContex});
  final BuildContext parentContex;
  @override
  State<FilterPage> createState() => _FilterPageState();
}

//! ------------------------------------------------------------------------------------------------
String eventType = "EVENT";
TimeOfDay? startHour;
TimeOfDay? endHour;
RangeValues visibleRange = const RangeValues(0, 10);
List<CategoryModel?> selectCategory = allCategoryList;
bool isOnline = false;
bool onlyFollow = false;
bool ticketNeed = false;
bool free = true;
bool verifyAccound = false;
DateTimeRange? filterDate;
final minPrice = TextEditingController(text: "0");
final maxPrice = TextEditingController(text: "0");

//! ------------------------------------------------------------------------------------------------
class _FilterPageState extends State<FilterPage> {
  final RoundedLoadingButtonController _btnfloatController = RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: RoundedLoadingButton(
        controller: _btnfloatController,
        onPressed: () async {
          List<String> categories = [];
          selectCategory.map((e) => categories.add(e!.name.toString()));
          FilterOrganizerModel filter = FilterOrganizerModel(
              eventType,
              null,
              null,
              null,
              filterDate?.start.toString(),
              filterDate?.end.toString(),
              endHour?.toString(),
              startHour?.toString(),
              categories,
              isOnline,
              onlyFollow,
              ticketNeed,
              free,
              verifyAccound,
              int.parse(minPrice.text),
              int.tryParse(maxPrice.text));

          context.read<AccountCubit>().filterModel = filter;
          await context.read<AccountCubit>().getAllOrganizerByFilter()
              ? AutoRouter.of(context).back()
              : AnimatedSnackBar.material(
                  'Bir Hata oluştu !',
                  type: AnimatedSnackBarType.error,
                ).show(context);
        },
        child: const Icon(Icons.check),
      ),
      appBar: AppBar(backgroundColor: Colors.black),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const VerticalDivider(),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade700), borderRadius: BorderRadius.circular(5)),
                child: DropdownButton<String>(
                  borderRadius: BorderRadius.circular(20),
                  underline: Container(color: Colors.transparent),
                  hint: Text(onlyFollow ? "Takip Edilen Hesapalr" : "Herkes"),
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  value: eventType,
                  items: <String>["EVENT", "NOTIFICATION", "CAMPAIGN"].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      eventType = value!;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              //Online or Local
              Row(
                children: [
                  //account Status
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade700), borderRadius: BorderRadius.circular(5)),
                      child: DropdownButton<bool>(
                        borderRadius: BorderRadius.circular(20),
                        underline: Container(color: Colors.transparent),
                        hint: Text(verifyAccound ? "Onaylı Hesaplar" : "Tüm Kullanıcılar"),
                        isExpanded: true,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        value: verifyAccound,
                        items: <bool>[true, false].map((bool value) {
                          return DropdownMenuItem<bool>(
                            value: value,
                            child: Text(value ? "Onaylı Hesaplar" : "Tüm Kullanıcılar"),
                          );
                        }).toList(),
                        onChanged: (bool? value) {
                          setState(() {
                            verifyAccound = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Online / Local
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade700), borderRadius: BorderRadius.circular(5)),
                      child: DropdownButton<bool>(
                        value: isOnline,
                        borderRadius: BorderRadius.circular(20),
                        underline: Container(color: Colors.transparent),
                        hint: Text(isOnline ? "Sadece Online" : "Sadece Lokal"),
                        isExpanded: true,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        items: <bool>[true, false].map((bool value) {
                          return DropdownMenuItem<bool>(
                            value: value,
                            child: Text(value ? "Sadece Online" : "Sadece Lokal"),
                          );
                        }).toList(),
                        onChanged: (bool? value) {
                          setState(() {
                            isOnline = value!;
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),

              const Divider(height: 50),
              //Ticket Need and range
              Row(
                children: [
                  //Ticket Need
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade700), borderRadius: BorderRadius.circular(5)),
                      child: DropdownButton<bool>(
                        borderRadius: BorderRadius.circular(20),
                        underline: Container(color: Colors.transparent),
                        hint: Text(ticketNeed ? "Bilet Gerekli " : "Bilet Gerek Yok"),
                        isExpanded: true,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        value: ticketNeed,
                        items: <bool>[true, false].map((bool value) {
                          return DropdownMenuItem<bool>(
                            value: value,
                            child: Text(value ? "Bilet Gerekli " : "Bilet Gerek Yok"),
                          );
                        }).toList(),
                        onChanged: (bool? value) {
                          setState(() {
                            ticketNeed = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Online / Local
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade700), borderRadius: BorderRadius.circular(5)),
                      child: DropdownButton<bool>(
                        borderRadius: BorderRadius.circular(20),
                        underline: Container(color: Colors.transparent),
                        hint: Text(onlyFollow ? "Takip Edilen Hesapalr" : "Herkes"),
                        isExpanded: true,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        value: onlyFollow,
                        items: <bool>[true, false].map((bool value) {
                          return DropdownMenuItem<bool>(
                            value: value,
                            child: Text(value ? "Takip Edilen Hesapalr" : "Herkes"),
                          );
                        }).toList(),
                        onChanged: (bool? value) {
                          setState(() {
                            onlyFollow = value!;
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
              const Divider(),
              // Price
              Row(
                children: [
                  Expanded(
                    child: RadioListTile(
                      title: const Text("Ücretli"),
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
                      title: const Text("Ücretsiz"),
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
              free == true
                  ? Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                          decoration: ITextFieldStyle("En Az"),
                          controller: minPrice,
                        )),
                        const VerticalDivider(),
                        Expanded(
                            child: TextFormField(
                          decoration: ITextFieldStyle("En fazla"),
                          controller: maxPrice,
                        ))
                      ],
                    )
                  : const SizedBox(),
              const Divider(),
              //!----------------------------------------------------------------
              HeadSmallText(text: "Zaman Aralığı"),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: ElevatedButton(
                          onPressed: () async {
                            var tempDate = await showDateRangePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime(2030));

                            setState(() {
                              filterDate = tempDate;
                            });
                          },
                          child: const Text("Tarih Aralığı"))),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(filterDate != null ? DateFormat('yyyy-MM-dd').format(filterDate!.start).toString() : "Başlangıç tarihi"),
                        Text(filterDate != null ? DateFormat('yyyy-MM-dd').format(filterDate!.end).toString() : "Başlangıç tarihi"),
                      ],
                    ),
                  )
                ],
              ),

              //*----------------------------------------------------------------
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: ElevatedButton(
                          onPressed: () async {
                            var tempStartTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                            if (!context.mounted) return;
                            var tempEndTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());

                            setState(() {
                              startHour = tempStartTime;
                              endHour = tempEndTime;
                            });
                          },
                          child: const Text("saat Aralığı"))),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(startHour != null ? startHour!.format(context).toString() : "Başlangıç saati"),
                        Text(endHour != null ? endHour!.format(context).toString() : "bitiş saati"),
                      ],
                    ),
                  )
                ],
              ),

              const Divider(),

              //----------------------------------------------------------------
              const Text("Kat egory"),
              ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: false, // required for min/max child size
                      context: context,
                      builder: (ctx) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          child: MultiSelectDialogField(
                            listType: MultiSelectListType.LIST,
                            initialValue: selectCategory,
                            items: allCategoryList.map((e) => MultiSelectItem(e, e.name.toString())).toList(),
                            onConfirm: (category) {
                              setState(() {
                                selectCategory = category;
                              });
                            },
                          ),
                        );
                      },
                    );
                  },
                  child: const Text("Ketegoriler"))
            ],
          ),
        ),
      ),
    );
  }
}
