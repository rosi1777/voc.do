import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_dafault/common/theme.dart';
import 'package:todo_dafault/presentation/view/widget/bottom_navbar.dart';
import 'package:todo_dafault/presentation/view_model/counter_view_model.dart';

import '../view_model/task_view_model.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({
    Key? key,
    required this.token,
    required this.addTask,
    this.id,
  }) : super(key: key);

  static const routeName = '/add_task_view';

  final bool addTask;
  final String token;
  final String? id;

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  DateTime? date;
  TimeOfDay? time;

  final _notesController = TextEditingController();
  final _tittleController = TextEditingController();

  @override
  void dispose() {
    _tittleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  String getDate() {
    return date == null
        ? 'Set your date'
        : DateFormat('dd/MM/yyyy').format(date!);
  }

  String getTime() {
    return time == null ? 'Select Time' : time!.format(context);
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();

    final newDate = await showDatePicker(
      context: context,
      initialDate: date ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return;

    setState(() => date = newDate);
  }

  Future pickTime(BuildContext context) async {
    var initialTime = TimeOfDay.now();
    final newTime = await showTimePicker(
      context: context,
      initialTime: time ?? initialTime,
    );

    if (newTime == null) return;

    setState(() => time = newTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue,
      appBar: AppBar(
        title: widget.addTask
            ? Text(
                'Add Task',
                style: headline5,
              )
            : Text(
                'Edit Task',
                style: headline5,
              ),
        centerTitle: true,
        backgroundColor: darkBlue,
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: IconButton(
          color: milkWhite,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, top: 48, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: textField, width: 2),
                  ),
                ),
                height: 32.0,
                width: 310,
                child: TextField(
                  keyboardType: TextInputType.text,
                  style: headline3,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(bottom: 14.0),
                    hintText: 'Tittle',
                    hintStyle: headline3.copyWith(color: grey),
                  ),
                  controller: _tittleController,
                ),
              ),
              const SizedBox(
                height: 19,
              ),
              Text(
                'Schedule detail',
                style: headline4,
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 153,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: textField,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                      child: Row(
                        children: [
                          Image.asset('assets/images/calendar.png'),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            getDate(),
                            style: bodyText1.copyWith(color: milkWhite),
                          ),
                        ],
                      ),
                      onPressed: () {
                        pickDate(context);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 153,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: textField,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                      child: Row(
                        children: [
                          Image.asset('assets/images/time.png'),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            getTime(),
                            style: bodyText1.copyWith(color: milkWhite),
                          ),
                        ],
                      ),
                      onPressed: () {
                        pickTime(context);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Notes',
                style: headline4,
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                height: 158,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(color: darkGrey),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: TextField(
                    maxLines: 10,
                    keyboardType: TextInputType.text,
                    style: overline.copyWith(color: milkWhite),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.only(
                        left: 8,
                        right: 8,
                        top: 8,
                        bottom: 8,
                      ),
                      hintText: 'Type if your task have a note...',
                      hintStyle: overline,
                    ),
                    controller: _notesController,
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Center(
                child: SizedBox(
                  width: 140,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                    ),
                    child: widget.addTask
                        ? Text(
                            'Add',
                            style: button,
                          )
                        : Text(
                            'Update',
                            style: button,
                          ),
                    onPressed: () {
                      final timeData =
                          "${date!.toYyMmDd()} ${time!.to24hours()}:00";
                      final tittle = _tittleController.text;
                      final description = _notesController.text;
                      final token = widget.token;

                      if (widget.addTask) {
                        Provider.of<TaskViewModel>(
                          context,
                          listen: false,
                        ).addTasks(token, tittle, description, timeData);

                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(
                          SnackBar(
                            backgroundColor: darkGrey,
                            content: Text(
                              'Add succeed',
                              style: overline.copyWith(
                                color: white,
                              ),
                            ),
                          ),
                        );

                        Provider.of<TaskViewModel>(
                          context,
                          listen: false,
                        ).getTask(
                          widget.token,
                          'todo',
                        );
                        Provider.of<CounterViewModel>(
                          context,
                          listen: false,
                        ).getCounter(widget.token);

                        Navigator.pushReplacementNamed(
                          context,
                          BottomNavbar.routeName,
                        );
                      } else if (!widget.addTask) {
                        Provider.of<TaskViewModel>(
                          context,
                          listen: false,
                        ).updateTasks(
                          token,
                          widget.id!,
                          tittle,
                          description,
                          timeData,
                        );

                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(
                          SnackBar(
                            backgroundColor: darkGrey,
                            content: Text(
                              'Update succeed',
                              style: overline.copyWith(
                                color: white,
                              ),
                            ),
                          ),
                        );

                        Provider.of<TaskViewModel>(
                          context,
                          listen: false,
                        ).getTask(
                          widget.token,
                          'todo',
                        );
                        Provider.of<CounterViewModel>(
                          context,
                          listen: false,
                        ).getCounter(widget.token);

                        Navigator.pushReplacementNamed(
                          context,
                          BottomNavbar.routeName,
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension TimeOfDayConverter on TimeOfDay {
  String to24hours() {
    final hour = this.hour.toString().padLeft(2, "0");
    final min = minute.toString().padLeft(2, "0");

    return "$hour:$min";
  }
}

extension DateTimeConverter on DateTime {
  String toYyMmDd() {
    final year = this.year.toString();
    final month = this.month.toString();
    final day = this.day.toString();

    return "$year-$month-$day";
  }
}
