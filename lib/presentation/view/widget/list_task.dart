import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_dafault/common/theme.dart';

import '../../../common/state_enum.dart';
import '../../view_model/counter_view_model.dart';
import '../../view_model/task_view_model.dart';
import '../add_task_view.dart';
import '../task_detail_view.dart';

class ListTasks extends StatefulWidget {
  const ListTasks({
    Key? key,
    required this.route,
    required this.token,
    this.isViewDoneOnly = false,
    this.isViewOverdueOnly = false,
    this.signOut,
  }) : super(key: key);

  final bool? isViewDoneOnly;
  final bool? isViewOverdueOnly;
  final String route;
  final VoidCallback? signOut;
  final String token;

  @override
  State<ListTasks> createState() => _ListTasksState();
}

class _ListTasksState extends State<ListTasks> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<TaskViewModel>(context, listen: false)
        .getTask(widget.token, widget.route));
    // Future.microtask(() => Provider.of<CounterViewModel>(context, listen: false)
    //     .getCounter(widget.token));
  }

  @override
  Widget build(BuildContext context) {
    late Widget build;

    return Consumer<TaskViewModel>(builder: (context, data, child) {
      final state = data.taskState;
      if (state == RequestState.loading) {
        return Center(
          child: CircularProgressIndicator(
            color: darkBlue,
            strokeWidth: 2,
          ),
        );
      } else if (state == RequestState.loaded) {
        build = data.task.messages.taskList.isNotEmpty
            ? ListView.builder(
                itemCount: data.task.messages.taskList.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: ((context, index) {
                  var status = data.task.messages.taskList[index].status;
                  var item = data.task.messages.taskList[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        TaskDetailView.routeName,
                        arguments: item,
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xff252836),
                        border: Border(
                          left: BorderSide(
                            width: 5,
                            color: status! == "1" ? tosca : yellow,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 190,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                  child: Text(
                                    item.tittle!,
                                    style: subtitle1,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    const ImageIcon(
                                      AssetImage(
                                        'assets/images/individu.png',
                                      ),
                                      size: 15,
                                      color: Color(0xff0B6994),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      DateFormat.jm().format(
                                        DateTime.parse(item.time!),
                                      ),
                                      style: bodyText1,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            // width: 160,
                            child: widget.route != "all"
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      status == "0"
                                          ? IconButton(
                                              onPressed: () {
                                                Provider.of<TaskViewModel>(
                                                  context,
                                                  listen: false,
                                                ).markAsDoneTasks(
                                                  widget.token,
                                                  item.id!,
                                                );

                                                status = "1";

                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    backgroundColor: darkGrey,
                                                    content: Text(
                                                      'Task marked as done',
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
                                              },
                                              icon: Icon(
                                                Icons.done,
                                                color: tosca,
                                              ),
                                            )
                                          : IconButton(
                                              // ignore: no-empty-block
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.abc_outlined,
                                                color: Colors.transparent,
                                              ),
                                            ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => AddTaskView(
                                                token: widget.token,
                                                addTask: false,
                                                id: item.id,
                                              ),
                                            ),
                                          );
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: tosca,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Provider.of<TaskViewModel>(
                                            context,
                                            listen: false,
                                          ).deleteTasks(
                                            widget.token,
                                            item.id!,
                                          );

                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              backgroundColor: darkGrey,
                                              content: Text(
                                                'Delete succeed',
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
                                            widget.route,
                                          );
                                          Provider.of<CounterViewModel>(
                                            context,
                                            listen: false,
                                          ).getCounter(widget.token);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: tosca,
                                        ),
                                      ),
                                    ],
                                  )
                                : Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      onPressed: () {
                                        // Navigate to Task Details
                                        Navigator.pushNamed(
                                          context,
                                          TaskDetailView.routeName,
                                          arguments: item,
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.chevron_right,
                                        color: Color.fromARGB(
                                          0,
                                          11,
                                          105,
                                          148,
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              )
            : Center(
                child: Text(
                  'Belum ada task',
                  style: subtitle2,
                ),
              );

        return build;
      } else {
        return Center(
          child: Text(
            'Terjadi Kesalahan',
            style: overline,
          ),
        );
      }
    });

    // return ref
    //     .watch(getTaskProvider(
    //       Parameter(token: widget.token!, route: widget.route!),
    //     ))
    //     .when(
    //       data: (data) {
    // build = data.messages.list.isNotEmpty
    //     ? ListView.builder(
    //         itemCount: data.messages.list.length,
    //         shrinkWrap: true,
    //         scrollDirection: Axis.vertical,
    //         itemBuilder: ((context, index) {
    //           var status = data.messages.list[index].status;
    //           var item = data.messages.list[index];

    //           return GestureDetector(
    //             onTap: () {
    //               Navigator.pushNamed(
    //                 context,
    //                 TaskDetailView.routeName,
    //                 arguments: item,
    //               );
    //             },
    //             child: Container(
    //               width: double.infinity,
    //               margin: const EdgeInsets.symmetric(vertical: 5),
    //               padding: const EdgeInsets.all(10),
    //               decoration: BoxDecoration(
    //                 color: const Color(0xff252836),
    //                 border: Border(
    //                   left: BorderSide(
    //                     width: 5,
    //                     color: status! == "1" ? tosca : yellow,
    //                   ),
    //                 ),
    //               ),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 children: [
    //                   SizedBox(
    //                     width: 190,
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         FittedBox(
    //                           child: Text(
    //                             item.tittle!,
    //                             style: subtitle1,
    //                           ),
    //                         ),
    //                         const SizedBox(
    //                           height: 5,
    //                         ),
    //                         Row(
    //                           children: [
    //                             const ImageIcon(
    //                               AssetImage(
    //                                 'assets/images/individu.png',
    //                               ),
    //                               size: 15,
    //                               color: Color(0xff0B6994),
    //                             ),
    //                             const SizedBox(
    //                               width: 5,
    //                             ),
    //                             Text(
    //                               DateFormat.jm().format(
    //                                 DateTime.parse(item.time!),
    //                               ),
    //                               style: bodyText1,
    //                             ),
    //                           ],
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   SizedBox(
    //                     // width: 160,
    //                     child: widget.route != "all"
    //                         ? Row(
    //                             mainAxisAlignment:
    //                                 MainAxisAlignment.spaceBetween,
    //                             children: [
    //                               status == "0"
    //                                   ? IconButton(
    //                                       onPressed: () {
    //                                         ref.read(
    //                                           markAsDoneTaskProvider(
    //                                             Parameter(
    //                                               token: widget.token!,
    //                                               route: item.id!,
    //                                             ),
    //                                           ),
    //                                         );

    //                                         status = "1";

    //                                         ScaffoldMessenger.of(
    //                                           context,
    //                                         ).showSnackBar(
    //                                           SnackBar(
    //                                             backgroundColor:
    //                                                 darkGrey,
    //                                             content: Text(
    //                                               'Task marked as done',
    //                                               style:
    //                                                   overline.copyWith(
    //                                                 color: white,
    //                                               ),
    //                                             ),
    //                                           ),
    //                                         );

    //                                         ref.invalidate(
    //                                           getTaskProvider(
    //                                             Parameter(
    //                                               token: widget.token!,
    //                                               route: widget.route!,
    //                                             ),
    //                                           ),
    //                                         );

    //                                         ref.invalidate(
    //                                           counterDataProvider(
    //                                             widget.token!,
    //                                           ),
    //                                         );
    //                                       },
    //                                       icon: Icon(
    //                                         Icons.done,
    //                                         color: tosca,
    //                                       ),
    //                                     )
    //                                   : IconButton(
    //                                       // ignore: no-empty-block
    //                                       onPressed: () {},
    //                                       icon: const Icon(
    //                                         Icons.abc_outlined,
    //                                         color: Colors.transparent,
    //                                       ),
    //                                     ),
    //                               IconButton(
    //                                 onPressed: () {
    //                                   Navigator.push(
    //                                     context,
    //                                     MaterialPageRoute(
    //                                       builder: (context) =>
    //                                           AddTaskView(
    //                                         token: widget.token!,
    //                                         addTask: false,
    //                                         id: item.id,
    //                                       ),
    //                                     ),
    //                                   );
    //                                 },
    //                                 icon: Icon(
    //                                   Icons.edit,
    //                                   color: tosca,
    //                                 ),
    //                               ),
    //                               IconButton(
    //                                 onPressed: () {
    //                                   ref.read(
    //                                     deleteTaskProvider(
    //                                       Parameter(
    //                                         token: widget.token!,
    //                                         route: item.id!,
    //                                       ),
    //                                     ),
    //                                   );

    //                                   ScaffoldMessenger.of(
    //                                     context,
    //                                   ).showSnackBar(
    //                                     SnackBar(
    //                                       backgroundColor: darkGrey,
    //                                       content: Text(
    //                                         'Delete succed',
    //                                         style: overline.copyWith(
    //                                           color: white,
    //                                         ),
    //                                       ),
    //                                     ),
    //                                   );

    //                                   ref.invalidate(
    //                                     getTaskProvider(
    //                                       Parameter(
    //                                         token: widget.token!,
    //                                         route: widget.route!,
    //                                       ),
    //                                     ),
    //                                   );

    //                                   ref.invalidate(
    //                                     counterDataProvider(
    //                                       widget.token!,
    //                                     ),
    //                                   );
    //                                 },
    //                                 icon: Icon(
    //                                   Icons.delete,
    //                                   color: tosca,
    //                                 ),
    //                               ),
    //                             ],
    //                           )
    //                         : Align(
    //                             alignment: Alignment.centerRight,
    //                             child: IconButton(
    //                               onPressed: () {
    //                                 // Navigate to Task Details
    //                                 Navigator.pushNamed(
    //                                   context,
    //                                   TaskDetailView.routeName,
    //                                   arguments: item,
    //                                 );
    //                               },
    //                               icon: const Icon(
    //                                 Icons.chevron_right,
    //                                 color: Color.fromARGB(
    //                                   0,
    //                                   11,
    //                                   105,
    //                                   148,
    //                                 ),
    //                               ),
    //                             ),
    //                           ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           );
    //         }),
    //       )
    //     : Center(
    //         child: Text(
    //           'Belum ada task',
    //           style: subtitle2,
    //         ),
    //       );

    // return build;
    //       },
    //       error: (error, stackTrace) => Center(
    //         child: Text(
    //           'Terjadi Kesalahan',
    //           style: overline,
    //         ),
    //       ),
    //       loading: () => Center(
    //         child: CircularProgressIndicator(
    //           color: darkBlue,
    //           strokeWidth: 2,
    //         ),
    //       ),
    //     );
  }
}
