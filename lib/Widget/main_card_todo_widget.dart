import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medication/Widget/card_todo_widget.dart';
import 'package:medication/provider/service_provider.dart';

class MainToDoCard extends ConsumerWidget {
  const MainToDoCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchStreamProvider);
    return ListView.builder(
      itemCount: todoData.value?.length ?? 0,
      shrinkWrap: true,
      itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: CardToDoListWidget(getIndex: index)),
    );
  }
}
