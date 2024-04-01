import 'package:flutter/material.dart';
import 'package:unimatch/styles/global.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.unimatchSemiBlack,
      body: Center(child: Text('Messages Page',style: TextStyle(color: MyColors.unimatchWhite)),),
    );
  }
}