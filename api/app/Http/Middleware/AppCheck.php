<?php

namespace App\Http\Middleware;

use Closure;

class AppCheck
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
        // Pre-Middleware Action
        $app_key = strip_tags(trim($request->input('app_key')));
        $key = env('APP_KEY');

        
        if($app_key == $key && $app_key != ''){
            $response = $next($request);

            // Post-Middleware Action
            return $response;
        }
        else{
            return [['status' => '401']];
        }

    }
}
