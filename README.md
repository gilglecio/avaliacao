# Sistema de avaliação

Requisitos: Docker e Docker Compose. A aplicação roda em PHP 8.2 (servidor embutido do PHP) com MySQL 8.4.

- Clonar o repositório.
- Entrar no repositório clonado `cd avaliacao`
- Copiar as variáveis de ambiente `cp .env.example .env`
- Criar uma rede `docker network create avaliacao`
- Levantar os containers `docker compose up -d --build`
- Instalar as dependências `docker exec -it avaliacao-api composer install`
- Rodar as migrações `docker exec -it avaliacao-api ./db "migrate --no-interaction"`
- Criar usuário de teste, acesse: `http://localhost:4087/add/user/testador`
- Login, acesse `http://localhost:4087` use o login `testador` e a senha `testador` e faça login.
- phpMyAdmin: `http://localhost:4088`
- Enjoy!

## Observações sobre o PHP 8

- O `php-activerecord` (dev-master, sem manutenção) recebe correções de compatibilidade com PHP 8
  via `cweagans/composer-patches`, aplicadas automaticamente no `composer install` (ver `patches/`).
- O Slim 2 transforma qualquer warning/notice em exceção; os avisos de depreciação são desligados
  em `app/bootstrap.php`.
- A conexão da aplicação usa `sql_mode = NO_ENGINE_SUBSTITUTION` (sem modo strict), pois o código legado
  insere registros omitindo colunas `NOT NULL` sem valor padrão.
