/// Support for doing something awesome.
///
/// More dartdocs go here.
library date_bottom_sheet_picker;

import 'package:flutter/material.dart';
export 'src/date_bottom_sheet_picker_base.dart';

import 'package:flutter/cupertino.dart';


import 'package:intl/intl.dart';

// ignore: must_be_immutable
class DateBottomSheetPicker extends StatefulWidget {
  //Specifies the padding at the top and bottom.
  double paddingVertical;
  //Specifies padding on the left and right.
  double paddingHorizontal;
  // Controller for text field.
  late TextEditingController? controller;
  // Border for text field.
  InputBorder? border;
  //LabelText for text field.
  String? labelText;
  // Shadow for BottomSheet.
  double? elevation;
  // BorderRadius for BottomSheet.
  ShapeBorder? shapeBottomSheet;
  //BottomSheet Color
  Color? backgroundColor;

  // The currently selected date.
  DateTime selectedDate;

  //It creates an age limit, any number you enter will not be available below that age.
  num minAge;

  // Minimum year that the picker can be scrolled.
  final DateTime firstDate;

  // Maximum year that the picker an be scrolled.
  final DateTime lastDate;
  DateBottomSheetPicker({
    Key? key,
    ShapeBorder? shapeBottomSheet,
    InputBorder? border,
    DateTime? firstDate,
    DateTime? lastDate,
    DateTime? selectedDate,
    this.paddingVertical = 10,
    this.paddingHorizontal = 10,
    this.controller,
    this.labelText = 'Date of birth',
    this.elevation = 20,
    this.minAge = 0,
    this.backgroundColor = Colors.white,
  })  : selectedDate = selectedDate ?? DateTime(1995, 4, 21),
        firstDate = firstDate ?? DateTime(1960, 1, 1),
        lastDate = lastDate ??= DateTime(2060),
        border = border ??
            OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        shapeBottomSheet = shapeBottomSheet ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
        super(key: key);

  @override
  State<DateBottomSheetPicker> createState() => _DateBottomSheetPickerState();
}

class _DateBottomSheetPickerState extends State<DateBottomSheetPicker>
    with TickerProviderStateMixin {
  int getMonthlyDate({required int year, required int month}) {
    int day = 0;
    switch (month) {
      case 1:
        day = 31;
        break;
      case 2:
        day = (year % 4 == 0 && year % 100 != 0) || year % 400 == 0 ? 29 : 28;
        break;
      case 3:
        day = 31;
        break;
      case 4:
        day = 30;
        break;
      case 5:
        day = 31;
        break;
      case 6:
        day = 30;
        break;
      case 7:
        day = 31;
        break;
      case 8:
        day = 31;
        break;
      case 9:
        day = 30;
        break;
      case 10:
        day = 31;
        break;
      case 11:
        day = 30;
        break;
      case 12:
        day = 31;
        break;

      default:
        day = 30;
        break;
    }
    return day;
  }

  // late DateTime selectedDate = DateTime(1995, 4, 21);

  // ignore: unused_element
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.selectedDate,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
    );
    if (picked != null && picked != widget.selectedDate) {
      setState(() {
        widget.selectedDate = picked;
        widget.controller!.text =
            DateFormat('yyyy-MM-dd').format(widget.selectedDate.toLocal());
      });
    }
  }

  List<int> getDaysInMonth(int year, int month) {
    // generate a list of days in the given month and year
    int numDays = getMonthlyDate(
      year: year,
      month: month,
    );
    return List.generate(numDays, (index) => index + 1);
  }

  List<int> getYears() {
    return List.generate(DateTime.now().year + 1 - widget.firstDate.year,
            (index) => widget.firstDate.year + index);
  }

  List<String> getMonths() {
    return [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
  }

  int getSelectedDayIndex(DateTime date) {
    return getDaysInMonth(date.year, date.month).indexOf(date.day);
  }

  int getSelectedYearIndex(DateTime date) {
    return getYears().indexOf(date.year);
  }

  int getSelectedMonthIndex(DateTime date) {
    return getMonths().indexOf(getMonthName(date.month));
  }

  String getMonthName(int month) {
    return getMonths()[month - 1];
  }

  FixedExtentScrollController yearController = FixedExtentScrollController();
  FixedExtentScrollController monthController = FixedExtentScrollController();
  FixedExtentScrollController dayController = FixedExtentScrollController();
/*
  late final TextEditingController controller = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(_selectedDate));
*/
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: widget.paddingVertical,
                horizontal: widget.paddingHorizontal),
            child: TextField(
              controller: widget.controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                labelText: widget.labelText,
                suffixIcon: InkResponse(
                  onTap: () {
                    showModalBottomSheet(
                      transitionAnimationController: AnimationController(
                          vsync: this,
                          duration: const Duration(seconds: 1),
                          reverseDuration: const Duration(
                            seconds: 1,
                          )),
                      elevation: widget.elevation,
                      backgroundColor: widget.backgroundColor,
                      shape: widget.shapeBottomSheet,
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (BuildContext context,
                              StateSetter setState /*You can rename this!*/) {
                            return SingleChildScrollView(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                MediaQuery.of(context).size.height * 0.45,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: Text(
                                        widget.controller!.text =
                                            DateFormat('yyyy-MM-dd').format(
                                                widget.selectedDate.toLocal())
                                        /*
                                        DateFormat('yyyy-MM-dd').format(
                                            widget.selectedDate.toLocal())*/
                                        ,
                                        style: const TextStyle(
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Divider(
                                      thickness: 1,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height: 200,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: CupertinoPicker.builder(
                                              scrollController: yearController,
                                              diameterRatio: 1.0,
                                              itemExtent: 60,
                                              onSelectedItemChanged: (value) {
                                                setState(() {
                                                  widget.selectedDate =
                                                      DateTime(
                                                        getYears()[value],
                                                        widget.selectedDate.month,
                                                        getSelectedDayIndex(widget
                                                            .selectedDate) +
                                                            1,
                                                      );
                                                  widget.controller!.text =
                                                      DateFormat('yyyy-MM-dd')
                                                          .format(widget
                                                          .selectedDate);
                                                });
                                                int dayCount = getDaysInMonth(
                                                  widget.selectedDate.year,
                                                  widget.selectedDate.month,
                                                ).length;
                                                if (dayCount <=
                                                    getSelectedDayIndex(
                                                        widget.selectedDate)) {
                                                  dayController
                                                      .jumpToItem(dayCount - 1);
                                                  setState(() {
                                                    widget.selectedDate =
                                                        DateTime(
                                                          widget.selectedDate.year,
                                                          widget.selectedDate.month,
                                                          getDaysInMonth(
                                                              widget
                                                                  .selectedDate
                                                                  .year,
                                                              widget
                                                                  .selectedDate
                                                                  .month)
                                                              .last,
                                                        );
                                                    widget.controller!.text =
                                                        DateFormat('yyyy-MM-dd')
                                                            .format(widget
                                                            .selectedDate);
                                                  });
                                                }
                                                monthController.jumpToItem(
                                                  getSelectedMonthIndex(
                                                      widget.selectedDate),
                                                );
                                              },
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    getYears()[index]
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 16.0),
                                                  ),
                                                );
                                              },
                                              childCount: getYears().length -
                                                  widget.minAge.toInt(),
                                            ),
                                          ),
                                          Expanded(
                                            child: CupertinoPicker.builder(
                                              scrollController: monthController,
                                              diameterRatio: 1.0,
                                              itemExtent: 60,
                                              onSelectedItemChanged: (value) {
                                                setState(() {
                                                  widget.selectedDate =
                                                      DateTime(
                                                        widget.selectedDate.year,
                                                        value + 1,
                                                        getSelectedDayIndex(widget
                                                            .selectedDate) +
                                                            1,
                                                      );
                                                  widget.controller!.text =
                                                      DateFormat('yyyy-MM-dd')
                                                          .format(widget
                                                          .selectedDate);
                                                });
                                                int dayCount = getDaysInMonth(
                                                  widget.selectedDate.year,
                                                  widget.selectedDate.month,
                                                ).length;
                                                if (dayCount <=
                                                    getSelectedDayIndex(
                                                        widget.selectedDate)) {
                                                  // dayController.jumpToItem(dayCount - 1);
                                                  dayController.animateToItem(
                                                      dayCount - 1,
                                                      curve: Curves.bounceIn,
                                                      duration: const Duration(
                                                          microseconds: 750));
                                                  setState(() {
                                                    widget.selectedDate =
                                                        DateTime(
                                                          widget.selectedDate.year,
                                                          widget.selectedDate.month,
                                                          getDaysInMonth(
                                                              widget
                                                                  .selectedDate
                                                                  .year,
                                                              widget
                                                                  .selectedDate
                                                                  .month)
                                                              .last,
                                                        );
                                                    widget.controller!.text =
                                                        DateFormat('yyyy-MM-dd')
                                                            .format(widget
                                                            .selectedDate);
                                                  });
                                                }
                                                yearController.jumpToItem(
                                                    getSelectedYearIndex(
                                                        widget.selectedDate));
                                              },
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    getMonths()[index],
                                                    style: const TextStyle(
                                                        fontSize: 16.0),
                                                  ),
                                                );
                                              },
                                              childCount: getMonths().length,
                                            ),
                                          ),
                                          Expanded(
                                            child: CupertinoPicker.builder(
                                              scrollController: dayController,
                                              diameterRatio: 1.0,
                                              itemExtent: 60,
                                              onSelectedItemChanged: (value) {
                                                setState(
                                                      () {
                                                    widget.selectedDate =
                                                        DateTime(
                                                          widget.selectedDate.year,
                                                          widget.selectedDate.month,
                                                          getDaysInMonth(
                                                              widget.selectedDate
                                                                  .year,
                                                              widget.selectedDate
                                                                  .month)[value],
                                                        );

                                                    widget.controller!.text =
                                                        DateFormat('yyyy-MM-dd')
                                                            .format(widget
                                                            .selectedDate);
                                                  },
                                                );
                                              },
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    getDaysInMonth(
                                                        widget.selectedDate
                                                            .year,
                                                        widget.selectedDate
                                                            .month)[index]
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 16.0),
                                                  ),
                                                );
                                              },
                                              childCount: getDaysInMonth(
                                                  widget.selectedDate.year,
                                                  widget.selectedDate.month)
                                                  .length,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      thickness: 1,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        MaterialButton(
                                          shape: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(12.0),
                                          ),
                                          minWidth: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.45,
                                          height: 60,
                                          child: const Text("Cancel"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        MaterialButton(
                                          shape: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(12.0),
                                          ),
                                          color: Theme.of(context).primaryColor,
                                          minWidth: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.45,
                                          height: 60,
                                          child: const Text("Selected"),
                                          onPressed: () {
                                            widget.controller!.text = widget
                                                .selectedDate
                                                .toString()
                                                .split(" ")[0];
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  child: const Icon(Icons.calendar_month_rounded),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

