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
        
        'departamento'  => 'Districo capital',
        'nombre_ciudad' => 'Bogota'
        
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
      'cliente_id'  => '1'
      
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
          
      ])->assignRole('ingeniero');
    }
}
