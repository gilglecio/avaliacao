<?php
return [
    "env" => getenv('APP_ENV') ?: "dev",
	"db" => [
		"driver" => "mysql",
		"host" => getenv('DB_HOST') ?: "avaliacao-db",
		"username" => getenv('DB_USERNAME') ?: "root",
		"password" => getenv('DB_PASSWORD') ?: "avaliacao",
		"dbname" => getenv('DB_DATABASE') ?: "avaliacao",
		"charset" => "utf8"
    ],
	"mail" => [
        "smtp" => "smtp.live.com",
        "port" => 25,
        "email" => "gilglecio_dev@hotmail.com",
        "name" => "Gilglécio Santos",
        "pass" => ""
    ],
	"domain" => getenv('APP_URL') ?: "http://localhost:4087/"
];
