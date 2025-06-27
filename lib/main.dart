import 'package:flutter/material.dart';
import 'user.dart';              // Modelo do usuário
import 'user_form.dart';        // Tela de formulário para criar/editar usuário
import 'user_service.dart';     // Serviço com as funções HTTP
import 'user_detail.dart';      // Tela para exibir detalhes do usuário

void main() {
  runApp(const MyApp());        // Inicializa o app Flutter
}

// Componente raiz do app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD Usuários',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const UserListScreen(), // Tela inicial do app
    );
  }
}

// Tela principal que exibe a lista de usuários
class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<User> users = [];        // Lista de usuários vinda da API
  bool isLoading = true;        // Indica se está carregando os dados

  // Função que busca os usuários da API
  void _loadUsers() async {
    setState(() => isLoading = true);
    try {
      users = await UserService.getUsers();
    } catch (e) {
      // Exibe erro, se falhar a requisição
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar usuários: $e')),
      );
    }
    setState(() => isLoading = false);
  }

  // Função que adiciona ou atualiza um usuário (POST ou PUT)
  void _addOrUpdateUser(User user) async {
    if (user.id == null) {
      await UserService.createUser(user); // Criação
    } else {
      await UserService.updateUser(user); // Atualização
    }
    _loadUsers(); // Atualiza a lista
  }

  // Função para excluir um usuário (com confirmação)
  void _deleteUser(User user) async {
    final confirm = await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirmar exclusão'),
        content: Text('Tem certeza que deseja excluir ${user.nome}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
    if (confirm) {
      await UserService.deleteUser(user.id!);
      _loadUsers();
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUsers(); // Carrega os usuários ao abrir a tela
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Usuários')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) // Indicador de carregamento
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (ctx, i) {
                final user = users[i];

                return GestureDetector(
                  onDoubleTap: () {
                    // Abre a tela de detalhes ao clicar duas vezes no nome
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => UserDetailScreen(user: user),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text('${user.nome} ${user.sobrenome}'), // Nome do usuário
                    subtitle: Text(user.email),                    // Email do usuário
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => UserForm(
                                user: user,
                                onSubmit: _addOrUpdateUser,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteUser(user),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => UserForm(onSubmit: _addOrUpdateUser),
          ),
        ),
        child: const Icon(Icons.add), // Botão para adicionar novo usuário
      ),
    );
  }
}
