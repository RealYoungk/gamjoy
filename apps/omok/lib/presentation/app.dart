import 'package:flutter/material.dart';

import 'lobby/lobby_page.dart';

class OmokApp extends StatelessWidget {
  const OmokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '오목',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LobbyPage(),
    );
  }
}
