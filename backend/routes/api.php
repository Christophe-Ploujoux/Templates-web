<?php

use Dingo\Api\Routing\Router;
use Tymon\JWTAuth\Facades\JWTAuth;

header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
/** @var Router $api */
$api = app(Router::class);

$api->version('v1', function (Router $api) {
    $api->group(['prefix' => 'auth'], function(Router $api) {
        $api->post('signup', 'App\\Api\\V1\\Controllers\\AuthController@signUp');
        $api->post('login', 'App\\Api\\V1\\Controllers\\AuthController@login');
        $api->get('login/facebook',  'App\\Api\\V1\\Controllers\\AuthController@loginFacebook');
        $api->post('recovery', 'App\\Api\\V1\\Controllers\\AuthController@sendResetEmail');
        $api->post('reset', 'App\\Api\\V1\\Controllers\\AuthController@resetPassword');
    });

    $api->group(['middleware' => 'jwt.auth'], function(Router $api) {
        $api->get('protected', function() {
            return response()->json([
                'message' => 'Access'
            ]);
        });
        $api->get('user', function() {
            $user = JWTAuth::parseToken()->authenticate();
            return response()->json(["user" => $user]);
        });
        $api->get('refresh', [
            'middleware' => 'jwt.refresh',
            function() {
                return response()->json([
                    'message' => 'By accessing this endpoint, you can refresh your access token at each request. Check out this response headers!'
                ]);
            }
        ]);
    });

    $api->get('config/{file}', function($file) {
        return Config::get($file);
    });
    $api->get('hello', function() {
        return response()->json([
            'message' => 'This is a simple example of item returned by your APIs. Everyone can see it.'
        ]);
    });
});
