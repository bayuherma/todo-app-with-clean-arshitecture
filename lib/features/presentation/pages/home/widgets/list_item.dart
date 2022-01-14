import 'package:flutter/material.dart';
import 'package:todo/features/presentation/cubit/todo/todo_cubit.dart';

import '../../../../../theme.dart';

class ListItem extends StatelessWidget {
  final TodoLoaded todoLoadedState;
final int index;
  const ListItem({
    Key? key,
    required this.todoLoadedState, required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(
            value: false,
            onChanged: (bool? value) {},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          Expanded(
            child: Text(
              '${todoLoadedState.todos[index].todo}',
              style: kBlackTextStyle.copyWith(fontWeight: semiBold),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: false,
            ),
          ),
        ],
      ),
    );
  }
}
