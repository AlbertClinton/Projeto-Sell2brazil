<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\User;
use Illuminate\Support\Facades\Validator;

class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return User::all();
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $data = $request->all();

        $validator = Validator::make($data, [
            'name'=>['required', 'string', 'max:255'],
            'cpf'=>['required', 'numeric'],
            'email'=>['required', 'email'],
            'password'=>['required', 'confirmed']
        ], [
            'name.required'=>'Insira um nome',
            'name.max'=>'Insira um nome com no maximo 255 caracteres',
            'cpf.required'=>'Insira um cpf',
            'email.required'=>'Insira um email',
            'email.email'=>'Insira um email valido',
            'password.required'=>'Insira uma senha e sua confirmação',
            'password.confirmed'=>'Confirme a sua senha'
        ]);
        if($validator->fails()){
            return $validator->errors();
        }

        $user= User::create($data);
        return $user;
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        return User::findOrFail($id);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $user=User::findOrFail($id);
        $data = $request->all();

         $validator = Validator::make($data, [
            'name'=>['required', 'string', 'max:255'],
            'cpf'=>['required', 'numeric'],
            'email'=>['required', 'email'],
        ], [
            'name.required'=>'Insira um nome',
            'name.max'=>'Insira um nome com no maximo 255 caracteres',
            'cpf.required'=>'Insira um cpf',
            'email.required'=>'Insira um email',
            'email.email'=>'Insira um email valido',
        ]);

        if($validator->fails()){
            return $validator->errors();
        }

        $user->update($data);
        return $user;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        return User::findOrFail($id)->delete();
    }
}
