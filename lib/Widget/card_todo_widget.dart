import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:medication/provider/service_provider.dart';

class CardToDoListWidget extends ConsumerWidget {
  const CardToDoListWidget({Key? key, required this.getIndex})
      : super(key: key);

  final int getIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchStreamProvider);
    var $ScreenHeight = MediaQuery.of(context).size.height / 100;
    // var $ScreenWidth = MediaQuery.of(context).size.width / 100;
    return todoData.when(
      data: (todoData) => Container(
        // width: 15,
        height: $ScreenHeight * 15,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
              width: 22,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: IconButton(
                        icon: const Icon(CupertinoIcons.delete),
                        onPressed: () => ref
                            .read(serviceProvider)
                            .deleteTask(todoData[getIndex].docID),
                      ),
                      title: Text(
                        todoData[getIndex].sugarConcentration,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        todoData[getIndex].notes,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -12),
                      child: Column(
                        children: [
                          Divider(
                            thickness: .80,
                            color: Colors.grey.shade200,
                          ),
                          Row(
                            children: [
                              Text(todoData[getIndex].dateTask),
                              const Gap(10),
                              Text(todoData[getIndex].timeTask)
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      error: (error, stackTrace) => Center(
        child: Text(stackTrace.toString()),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
