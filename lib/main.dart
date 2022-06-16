import 'package:flutter/material.dart';
import 'views/listar_filmes.dart';

main() {
  runApp(const HomeApp());
}

class HomeApp extends StatelessWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ListarFilmes(),
    );
  }
}
