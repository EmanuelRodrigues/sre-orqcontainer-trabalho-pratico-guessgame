# 🎮 Guess Game - Aplicação Web com Docker Compose

Este projeto é um simples jogo de adivinhação desenvolvido utilizando o framework Flask. O jogador deve adivinhar uma senha criada aleatoriamente, e o sistema fornecerá feedback sobre o número de letras corretas e suas respectivas posições. A aplicação é composta por uma arquitetura constituída por **frontend**, **backend**, **banco de dados** e **balanceamento de carga com NGINX**, tudo orquestrado via **Docker Compose**.

---

## 🚀 Como Instalar e Rodar

### ✅ Pré-requisitos

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)
- Executar o docker compose na mesma máquina que a aplicação será utilizada.
### 📥 Passos

1. Clone este repositório:

   ```bash
   git clone https://github.com/EmanuelRodrigues/sre-orqcontainer-trabalho-pratico-guessgame
   cd sre-orqcontainer-trabalho-pratico-guessgame
   ```

2. Suba os containers:

   ```bash
   docker-compose up -d
   ```

3. Acesse a aplicação:

   - **Interface Web (Frontend):** [http://localhost:8080](http://localhost:8080)
   - **Backend (via NGINX):** [http://localhost:9090](http://localhost:9090)

---
### Como Jogar

#### 1. Criar um novo jogo
Acesse a url do frontend

Digite uma frase secreta

Envie

Salve o game-id


#### 2. Adivinhar a senha

Acesse a url do frontend

Vá para o endponint breaker

Digite o game_id que foi gerado pelo Creator

Tente adivinhar
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
1. Com o repositório clonado, acesse o componente a ser acessado. Por exemplo, o front-end.

2. Realize as alterações nos códigos conforme necessidade.

3. Execute o build da imagem: docker built -t componente .

4. Faça o push da imagem para o repositório de imagens (registry).

5. Edite o `docker-compose.yml` e altere a tag da imagem desejada.  
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
### Estrutura do Código

#### Rotas:

- **`/create`**: Cria um novo jogo. Armazena a senha codificada em base64 e retorna um `game_id`.
- **`/guess/<game_id>`**: Permite ao usuário adivinhar a senha. Compara a adivinhação com a senha armazenada e retorna o resultado.