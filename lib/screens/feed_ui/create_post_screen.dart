import 'package:flutter/material.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  @override
  Widget build(BuildContext context) {
    print('START: CreatePostScreen()');

    return Scaffold(
      body: Column(
        children: const [
          Spacer(),
        ],
      ),
    );
  }
}
