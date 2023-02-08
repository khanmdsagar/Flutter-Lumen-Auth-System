<?php


use Illuminate\Support\Facades\Mail;
use App\Mail\OTP;

/** @var \Laravel\Lumen\Routing\Router $router */


$router->get('/', function () use ($router) {
    return $router->app->version();
});

$router->post('/api/send-otp', ['middleware'=> 'app_check', 'uses'=> 'UserController@send_otp']);
$router->post('/api/authenticate-user', 'UserController@authenticate_user');
$router->post('/api/register-user', ['middleware'=> 'app_check', 'uses'=> 'UserController@register_user']);