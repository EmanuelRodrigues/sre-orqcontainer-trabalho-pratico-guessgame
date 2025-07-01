# 🎮 Guess Game - Sistema Distribuído com Containers

Este projeto implementa uma aplicação de adivinhação de número (Guess Game) dividida em **três serviços** principais: frontend (React), backend (Flask) e banco de dados (PostgreSQL), todos orquestrados via Docker Compose.

⚙️ Componentes
🖥️ Frontend (guess-game-frontend)
Desenvolvido com React.

Comunica-se com o backend via a variável REACT_APP_BACKEND_URL.

Expõe a aplicação na porta 1800.

🐍 Backend (guess-game-backend)
API construída com Flask.

Expõe a porta 3000, redirecionada para 2600 na máquina host.

Conecta-se ao banco de dados PostgreSQL via variáveis de ambiente.

🗄️ Banco de Dados (guess-game-database)
Utiliza a imagem oficial do PostgreSQL 15.3-alpine.

Persistência de dados via volume postgres-data.

Porta padrão do Postgres (5432) exposta como 5132.

🚀 Como executar
Pré-requisitos: Docker e Docker Compose instalados

🚀 Como executar
Pré-requisitos: Docker e Docker Compose instalados

Clone o repositório:

bash
Copiar
Editar
git clone https://github.com/EmanuelRodrigues/sre-orqcontainer-trabalho-pratico-guessgame.git
cd sre-orqcontainer-trabalho-pratico-guessgame
Suba os serviços:

bash
Copiar
Editar
docker compose up -d
Acesse:

Frontend: http://localhost:1800

Backend API: http://localhost:2600

PostgreSQL: localhost:5132 (usuário: postgres, senha: password)

🛠️ Variáveis de Ambiente
Frontend
Variável	Descrição
REACT_APP_BACKEND_URL	URL do backend Flask (ex: http://localhost:2600)

Backend
Variável	Descrição
FLASK_DB_TYPE	Tipo de banco (postgres)
FLASK_DB_USER	Usuário do banco
FLASK_DB_PASSWORD	Senha do banco
FLASK_DB_NAME	Nome do banco de dados
FLASK_DB_HOST	Host do banco de dados
FLASK_DB_PORT	Porta do banco de dados

🧪 Testes
Testes do backend localizados em backend/tests/

Testes do frontend com Cypress em frontend/cypress/

🐳 Imagens Docker utilizadas
Serviço	Imagem
Frontend	emanuelbrodrigues/emanuelbrodrigues-orqcontainer-guessgame-frontend:1
Backend	emanuelbrodrigues/emanuelbrodrigues-orqcontainer-guessgame-backend:1
Banco de dados	postgres:15.3-alpine

🧠 Objetivo do Projeto
Este projeto foi desenvolvido como parte do trabalho prático da disciplina de Orquestração de Containers (SRE), com o objetivo de demonstrar:

Separação de responsabilidades entre frontend, backend e banco

Utilização de variáveis de ambiente para integração

Empacotamento em imagens Docker públicas

Orquestração com Docker Compose