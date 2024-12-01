# DataPrep-Transform_Mack

Este projeto foi desenvolvido com o objetivo de criar um banco de dados transacional e analítico utilizando a base de dados Olist disponível no Kaggle. O projeto foi realizado utilizando PostgreSQL, Python e Docker, e envolve as seguintes etapas:

1. Criação de um banco de dados transacional baseado na documentação disponível em [Kaggle Olist Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce?resource=download).

2. Criação de um modelo lógico e físico Star Schema e Wide Table para o banco de dados analítico.

3. Desenvolvimento de um fluxo para carga inicial dos dados brutos para dados especialistas (Star Schema e Wide Table).

4. Definição da abordagem de tempestividade no fluxo de transformação, justificando a escolha entre Batch, Micro-Batch ou Fluxo Contínuo.

# Ferramentas utilizadas

PostgreSQL: Sistema de gerenciamento de banco de dados utilizado para criar os bancos transacional e analítico.

Python: Linguagem de programação utilizada para desenvolvimento dos scripts de carga e transformação de dados.

Docker: Plataforma de contêineres utilizada para facilitar a configuração e execução do ambiente de desenvolvimento.

# Estrutura do repositório

.
├── sql
│   ├── script-create-olist.sql
│   ├── star-schema-olist.sql
│   ├── wide-table-olist.sql
├── python
│   ├── load.py
│   ├── transform-starstarschema-olist.py
│   └── transform-wide-table-olist.py
├── docker
│   ├── Dockerfile
│   └── docker-compose.yml
├── docs
│   └── Tempestividade.md
├── README.md



