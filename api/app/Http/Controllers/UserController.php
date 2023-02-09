<?php

namespace App\Http\Controllers;

use App\Mail\OTP;
use Carbon\Carbon;
use \Firebase\JWT\JWT;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Crypt;

class UserController extends Controller
{
    function send_otp(Request $request){
        $email   = strip_tags(trim($request->input('email')));
        $otp     = strip_tags(trim($request->input('otp')));

        try {
            Mail::to($email)->send(new OTP($otp));
            return ['status' => 'success'];
        }
        catch (\Exception $e){
            return ['status' => 'failed'];
        }
    }

    function authenticate_user(Request $request){
        $email   = strip_tags(trim($request->input('email')));
        $is_user = DB::table('users')->where('email', $email)->count();

        if($is_user){
            $key = env('APP_KEY');
            $payload = array(
                "site" => "nesternet.com",
                "email" => $email,
                "iat" => time(),
                "exp" => time() + 604800
            );

            try{
                $jwt = JWT::encode($payload, $key, 'HS256');
                return ['token' => $jwt, 'status' => 'success'];
            }
            catch(\Exception $e){
                return ['status' => "failed"];
            }
        }
        else{
            return ['status' => "404"];
        }
    }

    function register_user(Request $request){
        $email    = strip_tags(trim($request->input('email')));
        $fullname = strip_tags(trim($request->input('fullname')));

        $is_user  = DB::table('users')->where('email', $email)->count();

        if(!$is_user){
            try {
                $result = DB::table('users')->insert([
                    'fullname'    => $fullname,
                    'email'       => $email,
                    "joining_date" => Carbon::now()->toDateString(),
                ]);
    
                if($result){
                    return [['status' => "success"]];
                }
                else{
                    return [['status' => "failed"]];
                }
            }
            catch (\Exception $e){
                return [['status' => "failed"]];
            }
        }
        else{
            return [['status' => "user exists"]];
        }
    }

}
