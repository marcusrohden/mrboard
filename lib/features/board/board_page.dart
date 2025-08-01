import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mrpostsboard/features/board/store/board_store.dart';
import 'package:mrpostsboard/shared_widgets/info_sheet.dart';
import 'package:mrpostsboard/utils/helper.dart';

class BoardPage extends StatelessWidget {
  BoardPage({super.key});

  final BoardStore boardStore = Modular.get<BoardStore>();

  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message Board'),
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () async {
            await boardStore.logout();
            Modular.to.navigate('/');
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.help_outline,
              color: Colors.blueAccent,
              size: 30,
            ),
            onPressed: () => showInfoSheet(context),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Observer(
                builder: (context) {
                  final items = boardStore.sortedList;

                  return ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final post = items[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    post.authorName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    Helper.formatDateTime(post.createdAt),
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(color: Colors.grey),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                post.content,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: const InputDecoration(
                        hintText: 'Write a message...',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (value) {
                        if (value.trim().isEmpty) return;
                        messageController.clear();
                        boardStore.saveMsg(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static showInfoSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder:
          (context) =>
              Padding(padding: const EdgeInsets.all(8.0), child: InfoSheet()),
    );
  }
}
