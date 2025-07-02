# 🎮 Guess Game - Aplicação Web com Docker Compose

Este projeto é uma aplicação web do tipo **"Guess Game"**, com uma arquitetura composta por **frontend**, **backend**, **banco de dados** e **balanceamento de carga com NGINX**, tudo orquestrado via **Docker Compose**.

---

## 🚀 Como Instalar e Rodar

### ✅ Pré-requisitos

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

### 📥 Passos

1. Clone este repositório:

   ```bash
   git clone https://github.com/seu-usuario/guess-game.git
   cd guess-game
   ```

2. Suba os containers:

   ```bash
   docker-compose up -d
   ```

3. Acesse a aplicação:

   - **Interface Web (Frontend):** [http://localhost:8080](http://localhost:8080)
   - **Backend (via NGINX):** [http://localhost:9090](http://localhost:9090)

---

## 📐 Decisões de Design

### 🔧 Serviços

#### 🖥️ Frontend (React)

- O container `guess-game-frontend-1` serve a interface do usuário.
- O frontend se comunica com o backend através da URL `http://localhost:9090`, que é gerenciada pelo NGINX.
- **Imagem:**  
  `emanuelbrodrigues/emanuelbrodrigues-orqcontainer-guessgame-frontend:1`

#### 🧠 Backend (Flask)

- Duas instâncias (`guess-game-backend-1` e `guess-game-backend-2`) atuam como API da aplicação, conectando-se ao banco de dados PostgreSQL.
- **Imagem:**  
  `emanuelbrodrigues/emanuelbrodrigues-orqcontainer-guessgame-backend:1`

#### 🗄️ Banco de Dados (PostgreSQL)

- Utiliza a imagem oficial `postgres:15.3-alpine`.
- Armazena os dados persistentes do jogo.
- Utiliza um volume nomeado: `postgres-data`.

#### 🌐 NGINX

- Atua como **balanceador de carga** para as instâncias do backend.
- Redireciona requisições do frontend para os containers Flask.
- Utiliza uma configuração customizada definida no arquivo `configuracao-nginx.conf`.
- Escuta na porta **9090** do host.

---

## 🔁 Estratégia de Balanceamento de Carga

O **NGINX** é responsável por balancear a carga entre as duas instâncias do backend Flask, garantindo **alta disponibilidade** e **escalabilidade horizontal**.

- A configuração está no arquivo: `configuracao-nginx.conf`
- O NGINX escuta na **porta 9090** do host.
- Distribui requisições entre `guess-game-backend-1` e `guess-game-backend-2`.

---

## 📦 Volumes

- `postgres-data`: volume persistente onde os dados do banco PostgreSQL são armazenados, garantindo durabilidade mesmo após reinícios.

---

## 🌐 Redes

A rede padrão do Docker Compose é utilizada automaticamente, permitindo comunicação entre os serviços pelos nomes dos containers:

- **Frontend acessa o backend via NGINX:**  
  `REACT_APP_BACKEND_URL=http://localhost:9090`

- **Backends acessam o banco de dados diretamente:**  
  `FLASK_DB_HOST=guess-game-database`

---

## 🔄 Atualização dos Componentes

Cada serviço utiliza imagens Docker **versionadas**, facilitando o processo de atualização.

### 🛠️ Como atualizar uma imagem

1. Edite o `docker-compose.yml` e altere a tag da imagem desejada.  
   Exemplo:

   ```yaml
   image: emanuelbrodrigues/emanuelbrodrigues-orqcontainer-guessgame-backend:2
   ```

2. Atualize e reinicie os containers:

   ```bash
   docker-compose pull
   docker-compose up -d
   ```

---

## 🧪 Testando a Aplicação

- Após subir os containers, verifique se o frontend está acessível via navegador em [http://localhost:8080](http://localhost:8080).
- Teste se o backend responde corretamente às chamadas feitas pelo frontend.
- Observe os logs dos serviços para diagnosticar qualquer erro:

  ```bash
  docker-compose logs -f
  ```

---