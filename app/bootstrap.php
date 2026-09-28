<?php

// A sessão é iniciada pelo middleware \Slim\Middleware\SessionCookie.

date_default_timezone_set('America/Sao_Paulo');

define('DS', DIRECTORY_SEPARATOR);
define('ROOT', dirname(dirname(__FILE__)));
define('APP', ROOT.DS.'app');
define('VENDOR', ROOT.DS.'vendor');
define('WWW', ROOT.DS.'www');
define('VIEWS', APP.DS.'views');
define('HELPERS', APP.DS.'helpers');
define('ROUTES', APP.DS.'routes');
define('CACHE', APP.DS.'cache');
define('MODELS', APP.DS.'models');

$env = require APP.DS.'env.php';

define('ENV_DEFAULT', $env['env']);

// Slim 2 converte qualquer erro em exceção; os avisos de depreciação do
// PHP 8.x nas bibliotecas legadas (Slim 2, php-activerecord) derrubariam a app.
error_reporting(E_ALL & ~E_DEPRECATED & ~E_USER_DEPRECATED);

if (ENV_DEFAULT == 'dev') {
    ini_set('display_errors', 1);
}

require VENDOR.DS.'autoload.php';
require HELPERS.DS.'toolkit.php';
require HELPERS.DS.'ValidateDate.php';
require HELPERS.DS.'TwigView.php';

// ini_set("SMTP", config('mail.smtp'));
// ini_set("smtp_port", config('mail.port'));

\ActiveRecord\Config::initialize(function ($cfg) use ($env) {
    $dns = $env['db']['driver'].'://'.$env['db']['username'].':'.$env['db']['password'].'@'.$env['db']['host'].'/'.$env['db']['dbname'];

    $cfg->set_model_directory(MODELS);
    $cfg->set_connections(array(
        'development' => $dns,
    ));
});

\ActiveRecord\Connection::$datetime_format = 'Y-m-d H:i:s';

// O código legado foi escrito para o MySQL sem modo strict (inserts omitem colunas
// NOT NULL sem default); o MySQL 8 liga STRICT_TRANS_TABLES e ONLY_FULL_GROUP_BY por padrão.
\ActiveRecord\ConnectionManager::get_connection()->query("SET SESSION sql_mode = 'NO_ENGINE_SUBSTITUTION'");

$app = new \Slim\Slim(array(
    'templates.path' => VIEWS,
    'view' => new TwigView(),
    'urladm' => '/admin',
    'urlbase_adm' => config('domain').'admin',
    'env' => $env,
));

$view = $app->view();
$view->parserOptions = array(
    'debug' => true,
    'cache' => ENV_DEFAULT == 'dev' ? CACHE : false,
);

$view->parserExtensions = array(
    new \Twig\Extension\DebugExtension(),
);

$app->add(new \Slim\Middleware\SessionCookie());
$app->add(new \Slim\Middleware\Flash());

$authenticate = function ($rule = 'RULE_ADMIN') use ($app) {
    $_SESSION['before'] = $_SERVER['REQUEST_URI'];

    if (!isset($_SESSION['app.user_id'])) {
        return $app->redirect(config('domain'));
    }

    $app->view->appendData(array(
        'app_user' => User::getUserLogger(),
    ));
};

// dd(Sending::encodeToken('$1$OvH3q9io$i6dMOmFCssPomWsQkdlCO/'));

$app->view->appendData(array(
    'urladm' => $app->settings['urladm'],
    'referer' => $app->request->getReferrer(),
    'profile_types' => User::$profile_types,
    'base' => config('domain'),
    'env' => ENV_DEFAULT,
    'evaluation_tags' => Evaluation::$evaluation_tags,
    'csrf_key' => 'csrf_token',
    'csrf_token' => 'token',
));

\Slim\Route::setDefaultConditions(array(
    'id' => '[0-9]+',
    'profile_type' => 'appraiser|valued|admin',
));

foreach (array(
    'admin',
    'front',
    'hooks',
) as $route) {
    require ROUTES.DS.$route.'.php';
}

$app->run();
