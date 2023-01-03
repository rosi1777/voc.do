import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_dafault/common/state_enum.dart';
import 'package:todo_dafault/common/theme.dart';
import 'package:todo_dafault/presentation/view_model/counter_view_model.dart';

class ListBadges extends StatefulWidget {
  const ListBadges({Key? key, required this.token}) : super(key: key);

  final String token;

  @override
  State<ListBadges> createState() => _ListBadgesState();
}

class _ListBadgesState extends State<ListBadges> {
  _buildBadgeContainer({
    int? amount,
    String? desc,
    Color? colors,
    BuildContext? context,
  }) {
    return Container(
      width: MediaQuery.of(context!).size.width * 0.27,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: colors,
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            amount.toString(),
            style: bodyText2.copyWith(fontSize: 17),
          ),
          Text(desc!, style: bodyText2.copyWith(fontSize: 15)),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<CounterViewModel>(context, listen: false)
        .getCounter(widget.token));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CounterViewModel>(builder: (context, data, child) {
      final state = data.counterState;
      if (state == RequestState.loading) {
        return Center(
          child: CircularProgressIndicator(
            color: darkBlue,
            strokeWidth: 2,
          ),
        );
      } else if (state == RequestState.loaded) {
        var counter = data.counter.messages;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildBadgeContainer(
              amount: counter.todo == null ? 0 : counter.todo!,
              desc: 'To Do',
              colors: yellow,
              context: context,
            ),
            _buildBadgeContainer(
              amount: counter.overdue ?? 0,
              desc: 'Overdue',
              colors: red,
              context: context,
            ),
            _buildBadgeContainer(
              amount: counter.done ?? 0,
              desc: 'Done',
              colors: tosca,
              context: context,
            ),
          ],
        );
      } else {
        return Center(
          child: Text(
            'Terjadi Kesalahan',
            style: overline,
          ),
        );
      }
    });

    // return Consumer(
    //   builder: (
    //     context,
    //     ref,
    //     child,
    //   ) =>
    //       ref.watch(counterDataProvider(token!)).when(
    //             data: (data) {
    //   var counter = data.messages;

    //   return Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       _buildBadgeContainer(
    //         amount: counter.todo == null ? 0 : counter.todo!,
    //         desc: 'To Do',
    //         colors: yellow,
    //         context: context,
    //       ),
    //       _buildBadgeContainer(
    //         amount: counter.overdue ?? 0,
    //         desc: 'Overdue',
    //         colors: red,
    //         context: context,
    //       ),
    //       _buildBadgeContainer(
    //         amount: counter.done ?? 0,
    //         desc: 'Done',
    //         colors: tosca,
    //         context: context,
    //       ),
    //     ],
    //   );
    // },
    // error: (error, stackTrace) => Center(
    //   child: Text(
    //     'Terjadi Kesalahan',
    //     style: overline,
    //   ),
    // ),
    // loading: () => Center(
    //   child: CircularProgressIndicator(
    //     color: darkBlue,
    //     strokeWidth: 2,
    //   ),
    // ),
    //           ),
    // );
  }
}
