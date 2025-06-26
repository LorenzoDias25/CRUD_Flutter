import 'package:flutter/material.dart';
import 'user.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${user.nome} ${user.sobrenome}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome: ${user.nome}', style: TextStyle(fontSize: 18)),
            Text('Sobrenome: ${user.sobrenome}', style: TextStyle(fontSize: 18)),
            Text('Gênero: ${user.genero}', style: TextStyle(fontSize: 18)),
            Text('Idade: ${user.idade}', style: TextStyle(fontSize: 18)),
            Text('Email: ${user.email}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
