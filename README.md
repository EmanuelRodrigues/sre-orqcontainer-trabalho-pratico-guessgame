Este projeto é uma aplicação web do tipo "Guess Game", contendo uma arquitetura composta por frontend, backend, banco de dados e balanceamento de carga com NGINX, tudo orquestrado via Docker Compose.

🚀 Como Instalar e Rodar
✅ Pré-requisitos
Docker
Docker Compose

📥 Passos
Clone este repositório:
git clone https://github.com/seu-usuario/guess-game.git
cd guess-game

Suba os containers:
docker-compose up -d

Acesse a aplicação:
Interface web (frontend): http://localhost:8080
Backend: http://localhost:2600


📐 Decisões de Design
🔧 Serviços
Frontend (React):

Dois containers (guess-game-frontend-1 e guess-game-frontend-2) são utilizados para simular múltiplas instâncias, permitindo o balanceamento de carga.

Imagem: emanuelbrodrigues/emanuelbrodrigues-orqcontainer-guessgame-frontend:1.

Backend (Flask):

Fornece a API da aplicação, conectando-se ao banco de dados PostgreSQL.

Imagem: emanuelbrodrigues/emanuelbrodrigues-orqcontainer-guessgame-backend:1.

Banco de Dados (PostgreSQL):

Utiliza imagem oficial postgres:15.3-alpine.

Armazena os dados persistentes do jogo.

Utiliza volume nomeado postgres-data.

NGINX:

Atua como balanceador de carga para as instâncias de frontend.

Encaminha requisições HTTP para as instâncias React.

Utiliza uma configuração personalizada (configuracao-nginx.conf).



🔁 Estratégia de Balanceamento de Carga
O NGINX é configurado para balancear a carga entre as duas instâncias do frontend React, melhorando a disponibilidade e permitindo escalabilidade horizontal.

A configuração está no arquivo configuracao-nginx.conf (que deve estar no mesmo diretório do docker-compose.yml). O NGINX escuta na porta 8080 do host e distribui as requisições entre os containers guess-game-frontend-1 e guess-game-frontend-2.

📦 Volumes
postgres-data: volume persistente onde os dados do banco PostgreSQL são armazenados, garantindo que os dados não se percam caso o container seja reiniciado ou removido.

🌐 Redes
A rede padrão do Docker Compose é utilizada automaticamente, permitindo que os serviços se comuniquem entre si por seus nomes de container, como:

http://guess-game-backend:3000 (acessado pelos frontends)

guess-game-database (acessado pelo backend)


🔄 Atualização dos Componentes
Cada serviço é baseado em uma imagem Docker versionada. Para atualizar qualquer componente:

🔁 Atualizar a Imagem
Edite o docker-compose.yml e altere a tag da imagem (por exemplo, de :1 para :2):

yaml
Copiar
Editar
image: emanuelbrodrigues/emanuelbrodrigues-orqcontainer-guessgame-frontend:2
Execute os comandos:

bash
Copiar
Editar
docker-compose pull
docker-compose up -d