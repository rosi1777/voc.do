import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_dafault/common/theme.dart';

import '../../domain/entities/task.dart';

class TaskDetailView extends StatelessWidget {
  final Task task;
  static const routeName = '/task_detail_view';
  const TaskDetailView({Key? key, required this.task}) : super(key: key);

  String getDate() {
    return DateFormat('dd/MM/yyyy').format(DateTime.parse(task.time!));
  }

  String getTime() {
    return DateFormat.jm().format(DateTime.parse(task.time!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue,
      appBar: AppBar(
        title: Text(
          'Task Detail',
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
                padding: const EdgeInsets.only(bottom: 5),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: textField, width: 2),
                  ),
                ),
                height: 43.0,
                width: 310,
                child: Column(
                  children: [
                    Text(
                      task.tittle!,
                      style: headline3,
                    ),
                  ],
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
                    width: 145,
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
                          Image.asset(
                            'assets/images/calendar.png',
                            color: milkWhite,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            getDate(),
                            style: bodyText1.copyWith(color: milkWhite),
                          ),
                        ],
                      ),
                      // ignore: no-empty-block
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 145,
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
                          Image.asset(
                            'assets/images/time.png',
                            color: milkWhite,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            getTime(),
                            style: bodyText1.copyWith(color: milkWhite),
                          ),
                        ],
                      ),
                      // ignore: no-empty-block
                      onPressed: () {},
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
                padding: const EdgeInsets.only(
                  left: 8,
                  right: 8,
                  top: 8,
                  bottom: 8,
                ),
                height: 158,
                width: 374,
                decoration: BoxDecoration(
                  color: textField,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(
                    task.description!,
                    style: overline.copyWith(color: milkWhite),
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
