## Backend - Biblioteca Online

Este projeto tem a intenção da demonstração de conhecimentos referente a contrução de uma aplicação com diversas APIs backend para acesso, criação, manutenção de livros.

**Neste sistema poderá ser feito**

- Cadastro de usuários de tipo leitor e bibliotecário
- Gerenciamento de seção (login e logout)
- Bibliotecários podem cadastrar, editar, apagar livros
- Leitores poderam favoritas livros
- **Sistema contém teste automatizados** para demonstração de conhecimento também com automatização de testes

**Diferenciais**

- Sistema tem validações de que usuários podem ou não fazer.
- Está hospedado em uma servidor cloud e pode ser acessado por meio do DNS: https://libraryapp-rails.herokuapp.com/
- Possível cadastros de livros por meio das APIs e hospedados em um s3 na aws
- Contém teste de integração

**Disponibilização das API e Como usálas em:**

https://github.com/MatheusAntonioSilva/library/blob/main/Library.postman_collection.json

**Testes de integração em**

https://github.com/MatheusAntonioSilva/library-integration-tests

**Setup da Aplicação**

Esta aplicação para ser executada é necessário ter em seu computador apenas o `docker` e o `docker-compose`.

---

Instalando as images:

```
docker-compose build
```

Agora, criação do bano de dados:

```
docker-compose run library_app bash
rails db:create
rails db:migrate
```

Por ultimo, vamos subir os containers:

```
docker-compose up
```

---

### Casos de uso

#### Cadastro de Contas

- Tentar cadastrar conta sem **first_name**
  - Deverá retornar uma mensagem que não foi possível cadastrar a conta
- Tentar cadastrar conta sem **last_name**
  - Deverá retornar uma mensagem que não foi possível cadastrar a conta
- Tentar cadastrar conta sem **email**
  - Deverá retornar uma mensagem que não foi possível cadastrar a conta
- Tentar cadastrar conta sem **password**
  - Deverá retornar uma mensagem que não foi possível cadastrar a conta
- Tentar cadastrar conta sem **password_confirmation**
  - Deverá retornar uma mensagem que não foi possível cadastrar a conta
- Tentar cadastrar conta com **password** e **password_confirmation**
  - Deverá retornar uma mensagem que não foi possível cadastrar a conta
- Tentar cadastrar conta com **kind** com conteúdo diferente de **librarian** e **reader**
  - Deverá retornar uma mensagem que não foi possível cadastrar a conta

**Com os dados atendendo as validações acima deverá ser criado a conta com sucesso**

#### Cadastro de Livros

- Só usuários autenticados devem podem realização a ação
- Se um **leitor** tentar cadastrar um livro
  - Não deverá ser permitido
- Se tentar cadastrar um livro sem título
  - Deverá retornar uma mensagem que não foi possível cadastrar a livro
- Se tentar cadastrar um livro sem descrição
  - Deverá retornar uma mensagem que não foi possível cadastrar a livro
- Se tentar cadastrar um livro sem autor
  - Deverá retornar uma mensagem que não foi possível cadastrar a livro
- Usuário deve estar autenticado para cadastrar o livro

**Caso seja um bibliotecário e atenda as condições acima deverá ser permitido o cadastro**

### Busca por livros

- Só usuários autenticados devem podem realização a ação
- Deve ser possível buscar por **título, descrição e autor**
- Também deve ser possível buscar por paginação os livros

#### Edição de Livros

- Só usuários autenticados devem podem realização a ação
- Se um **leitor** tentar editar um livro
  - Não deverá ser permitido
- Se tentar editar um livro sem título
  - Deverá retornar uma mensagem que não foi possível editar a livro
- Se tentar cadastrar um livro sem descrição
  - Deverá retornar uma mensagem que não foi possível editar a livro
- Se tentar editar um livro sem autor
  - Deverá retornar uma mensagem que não foi possível editar a livro
- Usuário deve estar autenticado para editar o livro

**Caso seja um bibliotecário e atenda as condições acima deverá ser permitido a edição**

### Exclusão de livros livros

- Se um **leitor** tentar excluir um livro
  - Não deverá ser permitido

**Caso seja um bibliotecário deverá ser permitido a exclusão**

---

### Estrutura do Banco de Dados

![Untitled](https://user-images.githubusercontent.com/25187342/171324934-c3a81e5c-322c-4310-9002-826f8f3721ce.png)




