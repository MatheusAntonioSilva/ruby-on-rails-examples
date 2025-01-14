# Alguns projetos Ruby on Rails - Pós Graduação ou Mini cursos palestrados.

Monorepo - Projetos Ruby on Rails feitos durantes PÓS Graduação em Especialização de Desenvolvimento Full Stack ou utilizados para fins didáticos em mini cursos.

---

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



---

## Testes de Integração APIs Biblioteca Online

Este projeto serve para validação de alguns cenários dos testes de integração da API https://github.com/MatheusAntonioSilva/library

**Setup da Aplicação**

Esta aplicação para ser executada é necessário ter em seu computador apenas o `docker` e o `docker-compose`.

---

Instalando as images:

```
docker-compose build
```

Agora, criação do bano de dados:

```
docker-compose run library-integration-tests bash
```

Agora só executar os testes:

```
bundle exec rspec
```

---

## Checks de Bancos de Dados

Aplicação construida para validação de aula de pós graduação relacionado a Persitência de Dados.
---

- Está APP é composta por simples `checks` se o serviçõs de bancos está **OK** de acordo com o que foi proposto:
  - Uso manual de controle de transação (begin, commit, rollback)
  - Persistência de dados em cache
  - Persistência de escrita em um banco relacional
  - Leitura em banco não relacional
  - Além da atividade extra, ***"atualização de dados de leitura usando persistência através de eventos"*** realizado por meio do uso do Kafka
--- 

### Instalação e Setup da Aplicação

- Execute os comandos a baixo após clonar o projeto
- Crie uma pasta `data` para salvar os dados do `mongo`: `mkdir data && cd data && mkdir mongodb && cd mongodb && mkdir database`

```
docker-compose build
docker-compose up
docker-compose exec app bash
rake db:create
rake db:migrate
rake db:seed
```

### Comportamento

- Para validar ***- Uso manual de controle de transação (begin, commit, rollback)*** acesse: `/checks/relations/control_transaction`
  - Parametro `force_error=true` cai em fluxo onde é feito `rollback`
- Para validar ***- Persistência de dados em cache*** acesse: `/checks/caches`
- Para validar ***Persistência de escrita em um banco relacional*** acesse `/checks/relations/writing` e `/checks/relations/reading` para validar a escrita
- Para validar ***Leitura em banco não relacional*** acesse `/checks/no_relations`
- Para validar ***Atualização de dados de leitura usando persistência através de eventos"*** acesse:
  - `/checks/extras/events/producer` para produzir o evento com o ID de um registro
  - `/checks/extras/events/consumer` para consumir o evento com o ID deste registro, fazer a leitura e atualizar o dado.

### Para mais detalhes

- Para validar o código basta acessar as `controllers` e verificar como está o código.