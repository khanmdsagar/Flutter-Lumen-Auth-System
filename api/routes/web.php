<?php


use Illuminate\Support\Facades\Mail;
use App\Mail\OTP;

/** @var \Laravel\Lumen\Routing\Router $router */


$router->get('/', function () use ($router) {
    return $router->app->version();
});

$router->get('/send-mail', function () use ($router) {
    Mail::to('khanmdsagar96@gmail.com')->send(new OTP('1234'));
});

$router->post('/api/send-otp', 'UserController@send_otp');
$router->post('/api/authenticate-user', 'UserController@authenticate_user');
$router->post('/api/register-user', ['middleware'=> 'app_check', 'uses'=> 'UserController@register_user']);