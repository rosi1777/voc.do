import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_dafault/common/theme.dart';
import 'package:todo_dafault/presentation/view/widget/list_task.dart';

import '../view_model/preferences_view_model.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});
  static const routeName = '/history_view';

  _buildBadgeCategory(String? title, String? iconUrl, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      padding: const EdgeInsets.all(10),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(8), color: filter),
      child: Row(
        children: [
          ImageIcon(
            AssetImage(iconUrl!),
            size: 15,
            color: navItem,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title!,
            style: bodyText1.copyWith(
              color: navItem,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: textField,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Row(
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    Image.asset(
                      'assets/images/search.png',
                      width: 17,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: TextFormField(
                        style: overline.copyWith(color: milkWhite),
                        decoration: InputDecoration.collapsed(
                          hintText: 'Searc your pass schedule...',
                          hintStyle: overline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                _buildBadgeCategory(
                  'Work',
                  'assets/images/work.png',
                  context,
                ),
                const SizedBox(
                  width: 10,
                ),
                _buildBadgeCategory(
                  'Personal',
                  'assets/images/individu.png',
                  context,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Consumer<PreferenceViewModel>(
              builder: (context, provider, child) {
                return Expanded(
                  child: ListTasks(
                    route: "all",
                    token: provider.token,
                  ),
                );
              },
            ),
          ]),
        ),
      ),
    );
  }
}
