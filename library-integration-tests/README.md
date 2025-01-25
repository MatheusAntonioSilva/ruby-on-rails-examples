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
