<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        // \App\Models\User::factory(10)->create();

    //  \App\Models\Roles::factory()->create([
      //  'id_rol' => 1,
        //'rol' => 'administrador'
      //]);

      \App\Models\TipoMovimiento::factory()->create([ 'movimiento'=> 'Entrada']);
      \App\Models\TipoMovimiento::factory()->create([ 'movimiento'=> 'Salida']);
      \App\Models\TipoMovimiento::factory()->create([ 'movimiento'=> 'Traslado']);
      \App\Models\Ciudades::factory()->create([
        'cod_dane'  => 'prueba',
        'departamento'  => 'Districo capital',
        'nombre_ciudad' => 'Bogota'
        
        ]);
        $this->call(RoleSeeder::class);

        \App\Models\User::factory()->create([
             'name' => 'James Arturo Maldonado',
             'email' => 'jamesarturo@gmail.com',
             'identificacion'=> '1018495835',
             'password'  => bcrypt('123456'),
             'estado' => 'activo',
             
         ])->assignRole('MasterDeveloment');
         \App\Models\User::factory()->create([
          'name' => 'el pruebitas',
          'email' => 'prueba@gmail.com',
          'identificacion'=> '1018',
          'password'  => bcrypt('123456'),
          'estado' => 'activo',
          
      ])->assignRole('Tecnico');
      \App\Models\Cargo::factory()->create([
        'cargo' =>'Bacteriologo Asesor',
       
     
  
  
      ]);
  

    \App\Models\Colaboradores::factory()->create([
      'nombre_colaborador' =>'compro',
      'identificacion' =>'123',
      'telefono' =>'123',
      'id_cargo' => 1


    ]);

      \App\Models\Clientes::factory()->create([
         'nombre_cliente'=> 'Comprolab S.A.S',
         'nit' => '860350711',
         'razon_social' =>'Comerzialisadora de laboraboratorio',
         'detalle' => 'Comprolab S.A.S',
    
    
    ]);
    \App\Models\Sede::factory()->create([
      'nombre_sede' => 'Bodega',
      'direccion'   => 'calle 106 54-63',
      'contacto'    => 'Resepcion',
      'zona'        => '1',
      'telefono'    => '17426486',
      'ciudad_id'   => '1',
      'cliente_id'  => '1',
      'id_colaborador'  => '1',
      'id_colaborador2'  => '1',
      
      ]);
      
      \App\Models\Sede::factory()->create([
        'nombre_sede' => 'Principal',
        'direccion'   => 'calle 106 54-63',
        'contacto'    => 'Resepcion',
        'zona'        => '1',
        'telefono'    => '17426486',
        'ciudad_id'   => '1',
        'cliente_id'  => '1',
        'id_colaborador'  => '1',
        'id_colaborador2'  => '1',
        
        ]);
        

      
  
  
    }
}
