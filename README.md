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
   - **Backend:** [http://localhost:2600](http://localhost:2600)

---

## 📐 Decisões de Design

### 🔧 Serviços

#### 🖥️ Frontend (React)

- Dois containers (`guess-game-frontend-1` e `guess-game-frontend-2`) simulam múltiplas instâncias para permitir o balanceamento de carga.
- **Imagem:**  
  `emanuelbrodrigues/emanuelbrodrigues-orqcontainer-guessgame-frontend:1`

#### 🧠 Backend (Flask)

- Fornece a API da aplicação e se conecta ao banco de dados PostgreSQL.
- **Imagem:**  
  `emanuelbrodrigues/emanuelbrodrigues-orqcontainer-guessgame-backend:1`

#### 🗄️ Banco de Dados (PostgreSQL)

- Utiliza a imagem oficial `postgres:15.3-alpine`.
- Armazena dados persistentes do jogo.
- Usa um volume nomeado: `postgres-data`.

#### 🌐 NGINX

- Atua como **balanceador de carga** para as instâncias do frontend.
- Redireciona requisições HTTP para os containers React.
- Utiliza uma configuração customizada: `configuracao-nginx.conf`.

---

## 🔁 Estratégia de Balanceamento de Carga

O **NGINX** é configurado para balancear a carga entre as duas instâncias do frontend React, o que melhora a disponibilidade e permite **escalabilidade horizontal**.

- A configuração está no arquivo: `configuracao-nginx.conf`
- O NGINX escuta na **porta 8080** do host.
- Distribui requisições entre os containers `guess-game-frontend-1` e `guess-game-frontend-2`.

---

## 📦 Volumes

- `postgres-data`: volume persistente onde os dados do banco PostgreSQL são armazenados, garantindo que não se percam mesmo após reinicialização ou remoção dos containers.

---

## 🌐 Redes

A rede padrão do Docker Compose é utilizada automaticamente, permitindo comunicação entre os serviços pelos nomes dos containers:

- Frontends acessam:  
  `http://guess-game-backend:3000`

- Backend acessa:  
  `guess-game-database`

---

## 🔄 Atualização dos Componentes

Cada serviço utiliza imagens Docker **versionadas**. Para atualizar qualquer componente:

### 🛠️ Atualizar a Imagem

1. Edite o `docker-compose.yml` e altere a tag da imagem.  
   Exemplo:

   ```yaml
   image: emanuelbrodrigues/emanuelbrodrigues-orqcontainer-guessgame-frontend:2
   ```

2. Execute os comandos:

   ```bash
   docker-compose pull
   docker-compose up -d
   ```