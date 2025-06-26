Objetivo

Desenvolver um aplicativo Flutter que realize operações CRUD (Create, Read, Update, Delete) com dados de usuário, utilizando requisições HTTP para se comunicar com uma API externa fornecida pelo CRUD CRUD.

O aplicativo deverá:

    Enviar dados do formulário para a API para criar um novo registro de usuário.
    Consultar os dados de usuários salvos na API e exibir uma lista de usuários.
    Atualizar informações de um usuário ao modificar e enviar dados do formulário.
    Excluir usuários, removendo-os da lista.

Requisitos

    Formulário de Usuário: Campos para coletar:
        Nome
        Sobrenome
        Gênero
        Idade
        Email

    Operações CRUD:
        Create (Criar): Salvar um novo usuário na API.
        Read (Ler): Listar todos os usuários salvos.
        Update (Atualizar): Atualizar as informações de um usuário existente.
        Delete (Deletar): Remover um usuário específico.

    Configuração da API:
        Use o site crudcrud.com para criar uma API temporária para o exercício. Ele gera um endpoint exclusivo para o seu aplicativo, permitindo operações CRUD.
        Salve o endpoint gerado em uma constante para realizar todas as requisições HTTP.

Instruções de Desenvolvimento

    Configuração do CRUD CRUD:
        Acesse crudcrud.com e copie seu endpoint exclusivo (exemplo: https://crudcrud.com/api/unique-endpoint-id).
        Este endpoint será usado em cada operação CRUD como base para as requisições HTTP.

    Estrutura do Projeto:
        Tela de Listagem: Exiba todos os usuários cadastrados em uma lista com nome e sobrenome.
        Formulário de Usuário: Ao adicionar ou editar, utilize um formulário para coletar as informações e enviá-las à API.

    Fluxo de Funcionalidade:
        Adicionar Usuário:
            Use o formulário para coletar dados e envie uma requisição POST ao endpoint da API para criar um novo usuário.
        Visualizar Usuários:
            Ao abrir o aplicativo, faça uma requisição GET para listar todos os usuários cadastrados e exibi-los.
        Atualizar Usuário:
            Ao selecionar um usuário, carregue suas informações no formulário. Permita edições e envie uma requisição PUT para atualizar o usuário na API.
        Excluir Usuário:
            Adicione um botão de exclusão ao lado de cada usuário na lista. Envie uma requisição DELETE ao endpoint específico do usuário.

    Desafios Extras:
        Adicione uma funcionalidade de validação de formulário para garantir que nenhum campo esteja vazio.
        Crie uma mensagem de confirmação ao excluir um usuário para evitar exclusões acidentais.

    Materiais de Apoio:
        Utilizar o pacote http para requisições HTTP: flutter.dev
        Documentação Flutter para Widgets de formulário: Form, TextFormField.

Exemplo de Fluxo de Interface

    Tela Inicial:
        Exibe uma lista de usuários com Nome e Sobrenome.
        Um botão Adicionar Usuário para abrir o formulário.

    Formulário de Usuário:
        Campos de Nome, Sobrenome, Gênero, Idade, Email.
        Botão Salvar que:
            Cria um novo usuário, se o formulário está vazio.
            Atualiza o usuário se informações estão sendo editadas.

    Opções de Ação na Lista:
        Botão de Editar ao lado de cada usuário, que abre o formulário com os dados preenchidos.
        Botão de Excluir, que envia uma requisição DELETE para remover o usuário da API.
