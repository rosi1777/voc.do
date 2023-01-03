import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_dafault/common/theme.dart';
import 'package:todo_dafault/presentation/view/widget/circle_tab_indikator.dart';
import 'package:todo_dafault/presentation/view/widget/custom_appbar.dart';
import 'package:todo_dafault/presentation/view/widget/list_badges.dart';
import 'package:todo_dafault/presentation/view/widget/list_task.dart';
import 'package:intl/intl.dart';

import '../view_model/preferences_view_model.dart';
import 'add_task_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const routeName = '/home_view';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  late TabController _tabController;
  late String userToken;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Consumer<PreferenceViewModel>(
            builder: (context, provider, child) {
              userToken = provider.token;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(
                    name: provider.name,
                    date: DateFormat.MMMEd().add_y().format(DateTime.now()),
                    imgUrl: 'assets/images/profile.png',
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ListBadges(token: provider.token),
                  const SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                      labelPadding: const EdgeInsets.only(left: 20, right: 20),
                      controller: _tabController,
                      labelColor: tosca,
                      unselectedLabelColor: blue,
                      isScrollable: true,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicator: CircleTabIndicator(color: tosca, radius: 4),
                      tabs: const [
                        Tab(
                          text: "To Do",
                        ),
                        Tab(
                          text: "Overdue",
                        ),
                        Tab(
                          text: "Done",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        ListTasks(
                          route: "todo",
                          token: provider.token,
                        ),
                        ListTasks(
                          route: "overdue",
                          token: provider.token,
                        ),
                        ListTasks(
                          route: "done",
                          token: provider.token,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff38ABBE),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskView(
                token: userToken,
                addTask: true,
                id: '1',
              ),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: white,
        ),
      ),
    );
  }
}
