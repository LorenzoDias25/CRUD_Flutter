import 'package:flutter/material.dart';
import 'user.dart';

class UserForm extends StatefulWidget {
  final User? user;
  final Function(User) onSubmit;

  const UserForm({super.key, this.user, required this.onSubmit});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  String? selectedGenero;
  bool _generoInvalido = false;

  late TextEditingController nomeController;
  late TextEditingController sobrenomeController;
  late TextEditingController generoController;
  late TextEditingController idadeController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    nomeController = TextEditingController(text: widget.user?.nome);
    sobrenomeController = TextEditingController(text: widget.user?.sobrenome);
    selectedGenero = widget.user?.genero;
    idadeController = TextEditingController(
      text: widget.user?.idade != null ? widget.user!.idade.toString() : '',
    );
    emailController = TextEditingController(text: widget.user?.email);
  }

  @override
  void dispose() {
    nomeController.dispose();
    sobrenomeController.dispose();
    generoController.dispose();
    idadeController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void _submit() {
    setState(() {
      _generoInvalido = selectedGenero == null;
    });

    if (_formKey.currentState!.validate() && !_generoInvalido) {
      final user = User(
        id: widget.user?.id,
        nome: nomeController.text,
        sobrenome: sobrenomeController.text,
        genero: selectedGenero!,
        idade: int.parse(idadeController.text),
        email: emailController.text,
      );
      widget.onSubmit(user);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user == null ? 'Novo Usuário' : 'Editar Usuário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: sobrenomeController,
                decoration: InputDecoration(labelText: 'Sobrenome'),
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Gênero', style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                selectedGenero = 'Masculino';
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: selectedGenero == 'Masculino'
                                  ? Colors.blue
                                  : Colors.grey.shade300,
                              foregroundColor: selectedGenero == 'Masculino'
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            child: const Text('Masculino'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                selectedGenero = 'Feminino';
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: selectedGenero == 'Feminino'
                                  ? Colors.pink
                                  : Colors.grey.shade300,
                              foregroundColor: selectedGenero == 'Feminino'
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            child: const Text('Feminino'),
                          ),
                        ),
                      ],
                    ),
                    if (_generoInvalido)
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Selecione um gênero',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                ),
              ),

              TextFormField(
                controller: idadeController,
                decoration: InputDecoration(labelText: 'Idade'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _submit, child: const Text('Salvar')),
            ],
          ),
        ),
      ),
    );
  }
}
