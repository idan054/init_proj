import 'package:flutter/material.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({Key? key}) : super(key: key);

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  @override
  Widget build(BuildContext context) {
    print('START: CreateUserScreen()');

    return Scaffold(
      body: Column(
        children: const [
          Spacer(),
        ],
      ),
    );
  }
}
