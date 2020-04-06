Projeto Sell2Brazil - Vinicius Giannini

para iniciar o projeto rode os seguintes comando dentro do diretorio prinicipal do projeto (onde existem diversos dockerfiles):
-docker-compose down (remove todos containers relacionados ao projeto)
-docker volume prune (deleta todos os volume relacionados ao projeto)
-docker-compose up --build (builda e inicia todos os containers, alem rodar comando de configuração como 'npm install', 'composer install' e etc.)

A aplicação estara disponivel na porta 80 do seu locahost (http://localhost:80) e o backend funcionando como API estara na porta 8000.
