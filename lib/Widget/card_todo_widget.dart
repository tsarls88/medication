import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class CardToDoListWidget extends ConsumerWidget {
  const CardToDoListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var $ScreenHeight = MediaQuery.of(context).size.height / 100;
    var $ScreenWidth = MediaQuery.of(context).size.width / 100;
    return ProviderScope(
      child: Container(
        width: $ScreenWidth * 88,
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
              width: 20,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        '7.8',
                        style: TextStyle(
                          fontSize: $ScreenHeight * 2.3,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        'Blood Sugar Result ',
                        style: TextStyle(
                          fontSize: $ScreenHeight * 2.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      trailing: Transform.scale(
                        scale: 1.5,
                        child: Checkbox(
                          activeColor: Colors.blue.shade800,
                          shape: const CircleBorder(),
                          value: true,
                          onChanged: (value) => print(value),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -12),
                      child: Container(
                        child: Column(
                          children: [
                            Divider(
                              thickness: .80,
                              color: Colors.grey.shade200,
                            ),
                            Row(
                              children: const [
                                Text('Today'),
                                Gap(10),
                                Text('10:30PM - 11:30PM')
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
