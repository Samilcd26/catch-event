import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../../Data/Models/category_model.dart';
import '../../../Data/Models/filter_organizer_model.dart';
import '../../../Data/State/root_cubit.dart';
import '../../../core/product/helper/text.dart';
import '../../../core/product/helper/text_field.dart';
import '../viewModel/event_categories.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key, required this.parentContex});
  final BuildContext parentContex;
  @override
  State<FilterPage> createState() => _FilterPageState();
}

//! ------------------------------------------------------------------------------------------------
TimeOfDay? startHour;
TimeOfDay? endHour;
RangeValues visibleRange = RangeValues(0, 10);
List<CategoryModel?> selectCategory = allCategoryList;
bool? isOnline = null;
bool? onlyFollow = null;
bool? ticketNeed = null;
bool? free = null;
bool? verifyAccound = null;
DateTimeRange? filterDate;
final minPrice = TextEditingController();
final maxPrice = TextEditingController();

//! ------------------------------------------------------------------------------------------------
class _FilterPageState extends State<FilterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          heroTag: "AcceptBtn",
          backgroundColor: Colors.green,
          child: Icon(Icons.check),
          onPressed: () {
            List<String> _categories = [];
            selectCategory.map((e) => _categories.add(e!.name.toString()));
            FilterOrganizerModel _filter = FilterOrganizerModel(
                "Türkiye",
                "Eskişehir",
                1,
                filterDate?.start.toString(),
                filterDate?.end.toString(),
                endHour.toString(),
                startHour.toString(),
                _categories,
                isOnline,
                onlyFollow,
                ticketNeed,
                free,
                verifyAccound,
                int.parse(minPrice.text),
                int.tryParse(maxPrice.text));

            context.read<RootCubit>().filterModel = _filter;
            context.read<RootCubit>().getAllOrganizerByFilter();
          }),
      appBar: AppBar(backgroundColor: Colors.black),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(height: 20),
              //Online or Local
              Row(
                children: [
                  //account Status
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade700), borderRadius: BorderRadius.circular(5)),
                      child: DropdownButton<bool>(
                        borderRadius: BorderRadius.circular(20),
                        underline: Container(color: Colors.transparent),
                        hint: Text("Acound"),
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
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade700), borderRadius: BorderRadius.circular(5)),
                      child: DropdownButton<bool>(
                        value: isOnline,
                        borderRadius: BorderRadius.circular(20),
                        underline: Container(color: Colors.transparent),
                        hint: Text("Acound"),
                        isExpanded: true,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        items: <bool>[true, false].map((bool value) {
                          return DropdownMenuItem<bool>(
                            value: value,
                            child: Text(value ? "Online" : "Local"),
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
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade700), borderRadius: BorderRadius.circular(5)),
                      child: DropdownButton<bool>(
                        borderRadius: BorderRadius.circular(20),
                        underline: Container(color: Colors.transparent),
                        hint: Text("Acound"),
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
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade700), borderRadius: BorderRadius.circular(5)),
                      child: DropdownButton<bool>(
                        borderRadius: BorderRadius.circular(20),
                        underline: Container(color: Colors.transparent),
                        hint: Text("Acound"),
                        isExpanded: true,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        value: onlyFollow,
                        items: <bool>[true, false].map((bool value) {
                          return DropdownMenuItem<bool>(
                            value: value,
                            child: Text(value ? "Only Follow" : "Herkes"),
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
              HeadSmallText(text: "Price"),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile(
                      title: const Text("not free"),
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
                      title: const Text("free"),
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
              free != null
                  ? Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                          decoration: ITextFieldStyle("En Az"),
                          controller: minPrice,
                        )),
                        VerticalDivider(),
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
                            var _tempDate =
                                await showDateRangePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime(2030));

                            setState(() {
                              filterDate = _tempDate;
                            });
                          },
                          child: Text("Tarih Aralığı"))),
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
                            var tempEndTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());

                            setState(() {
                              startHour = tempStartTime;
                              endHour = tempEndTime;
                            });
                          },
                          child: Text("saat Aralığı"))),
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
              Text("Kat egory"),
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
                  child: Text("Ketegoriler"))
            ],
          ),
        ),
      ),
    );
  }
}
