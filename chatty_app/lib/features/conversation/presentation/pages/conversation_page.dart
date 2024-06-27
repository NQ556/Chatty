import 'package:chatty_app/core/common/widgets/search_box.dart';
import 'package:chatty_app/features/conversation/presentation/widgets/empty_list.dart';
import 'package:flutter/material.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage({super.key});

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        // Search
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: SearchBox(
            hintText: "Search",
            textEditingController: searchController,
          ),
        ),

        // Conversation list
        Expanded(
          child: EmptyList(),
        ),
      ],
    ));
  }
}
