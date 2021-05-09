import 'package:flutter/material.dart';

class PageAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Segunda Página'),
        ),
        body: Center(
          child: Text(
            'Parabéns Autenticação feita com Sucesso',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ));
  }
}
