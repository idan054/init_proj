import 'package:example/common/models/post/post_model.dart';
import 'package:example/common/models/user/user_model.dart';
import 'package:flutter/material.dart';
import 'chat/chat_model.dart';
import 'message/message_model.dart';

class Sample {
  static final user = UserModel(
      gender: GenderTypes.male,
      age: 19,
      name: 'Dan',
      photoUrl: 'https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/null_Profile_2023-02-01%2015:02:25.754985?alt=media&token=bf8bee4e-97ed-4f88-acbe-d90cad4876d9',
      uid: 'XYZ',
      email: 'A@B',
      birthday: DateTime.now());

  static final post = PostModel(
    textContent: 'Hello post',
    id: 'id 123',
    creatorUser: user,
    enableComments: true,
    timestamp: DateTime(2023, 2, 2),
  );

  static final msg = MessageModel(
      timestamp: DateTime(2023, 2, 2),
      read: true,
      toId: 'X',
      fromId: 'Y',
      textContent: 'Hello, Im a sample notification',
      createdAt: 'Bobi TON',
      id: 'WhatId');

  static final chat = ChatModel(
      users: [user, user],
      messages: [msg, msg],
      lastMessage: msg,
      id: 'chatId',
      usersIds: ['XY', 'AB']);
}
