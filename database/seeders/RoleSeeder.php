<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;
class RoleSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()

    { 
       
        $role1 = Role::create(['name' => 'MasterDeveloment']);
        $role2 = Role::create(['name' => 'Admin']);
        $role3 = Role::create(['name' => 'Tecnico']);
        $role4 = Role::create(['name' => 'ingeniero']);


        Permission::create((['name'=> 'roles.index'
        ,'descripcion' =>'Ver informacion de roles'])) ->syncRoles([  $role1,  $role2]);
        Permission::create((['name'=> 'roles.create'
        ,'descripcion' =>'registrar  roles'])) ->syncRoles([  $role1,  $role2]);
        Permission::create((['name'=> 'roles.edit'
        ,'descripcion' =>'Editar roles'])) ->syncRoles([  $role1,  $role2]);
        Permission::create((['name'=> 'roles.destroy'
        ,'descripcion' =>'Eliminar roles'])) ->syncRoles([  $role1,  $role2]);
    //                
        Permission::create((['name'=> 'activos.index'
                              ,'descripcion' =>'Ver informacion de activos'])) ->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'activos.create'
                              ,'descripcion' =>'Crear un Activo'])) ->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'activos.edit'
                              ,'descripcion' =>'Editar un activo'])) ->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'activos.show'
                              ,'descripcion' =>'ver detalles del activo']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'activos.destroy'
                              ,'descripcion' =>'eliminar un activo']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        //
        Permission::create((['name'=> 'ciudades.index'
                              ,'descripcion' =>'Ver ciudades']))->syncRoles([  $role1,  $role2,  ]);
        Permission::create((['name'=> 'ciudades.create'
                              ,'descripcion' =>'Crear ciudades']))->syncRoles([  $role1,  $role2,  ]);
        Permission::create((['name'=> 'ciudades.edit'
                              ,'descripcion' =>'Editar ciudades']))->syncRoles([  $role1,  $role2,  ]);
        Permission::create((['name'=> 'ciudades.destroy'
                              ,'descripcion' =>'Eliminar ciudad']))->syncRoles([  $role1,  $role2,  ]);
       //
        Permission::create((['name'=> 'colaboradores.index'
                              ,'descripcion' =>'Ver informacion de un colaborador']))->syncRoles([  $role1,  $role2,  ]);
        Permission::create((['name'=> 'colaboradores.create'
                              ,'descripcion' =>'Crear un colaborador']))->syncRoles([  $role1,  $role2,  ]);
        Permission::create((['name'=> 'colaboradores.edit'
                              ,'descripcion' =>'Editar un colaborador']))->syncRoles([  $role1,  $role2,  ]);
        Permission::create((['name'=> 'colaboradores.destroy'
                              ,'descripcion' =>'Eliminar un colaborador']))->syncRoles([  $role1,  $role2,  ]);
        //
        Permission::create((['name'=> 'contratos.index'
                              ,'descripcion' =>'Ver informacion de contratos']))->syncRoles([  $role1,  $role2,     ]);
        Permission::create((['name'=> 'contratos.create'
                              ,'descripcion' =>'crear contrato']))->syncRoles([  $role1,  $role2,     ]);
        Permission::create((['name'=> 'contratos.edit'
                              ,'descripcion' =>'editar contrato']))->syncRoles([  $role1,  $role2,    ]);
        Permission::create((['name'=> 'contratos.destroy'
                              ,'descripcion' =>'Eliminar contrato']))->syncRoles([  $role1,  $role2,     ]);
        //
        Permission::create((['name'=> 'equipos.index'
                              ,'descripcion' =>'Ver informaqcion de  equipos']))->syncRoles([  $role1,  $role2,  $role3,   ]);
        Permission::create((['name'=> 'equipos.create'
                              ,'descripcion' =>'Registrar un Equipo']))->syncRoles([  $role1,  $role2,  $role3,   ]);
        Permission::create((['name'=> 'equipos.edit'
                              ,'descripcion' =>' Editar un equipo']))->syncRoles([  $role1,  $role2,  $role3,   ]);
        Permission::create((['name'=> 'equipos.destroy'
                              ,'descripcion' =>'Eliminar un equipo']))->syncRoles([  $role1,  $role2,  $role3,   ]);
        //
        Permission::create((['name'=> 'estados.destroy'
                              ,'descripcion' =>'Eliminar un estado']))->syncRoles([  $role1,  $role2,  ]);
        Permission::create((['name'=> 'estados.index'
                              ,'descripcion' =>'Ver estador registrados']))->syncRoles([  $role1,  $role2,  ]);
        Permission::create((['name'=> 'estados.create'
                              ,'descripcion' =>'Registrar un estado']))->syncRoles([  $role1,  $role2,  ]);
        Permission::create((['name'=> 'estados.edit'
                              ,'descripcion' =>'Editar un estado']))->syncRoles([  $role1,  $role2,  ]);
        //
        Permission::create((['name'=> 'foto.destroy'
                              ,'descripcion' =>'Eliminar fotos']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'foto.index'
                              ,'descripcion' =>'Ver las fotos registradas']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'foto.create'
                              ,'descripcion' =>'Registrar foto']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'foto.edit'
                              ,'descripcion' =>'Editar foto']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        //
        Permission::create((['name'=> 'marcas.destroy'
                              ,'descripcion' =>'Eliminar marcas']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'marcas.index'
                              ,'descripcion' =>'Ver marcas registradas']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'marcas.create'
                              ,'descripcion' =>'Registrar un marca']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'marcas.edit',
                              'descripcion' => 'Editar marcas']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        //
        Permission::create((['name'=> 'movimientos.destroy'
                              ,'descripcion' =>'Eliminar Moviminetos']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'movimientos.index'
                              ,'descripcion' =>'Ver informacion de movimientos ']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'movimientos.create'
                              ,'descripcion' =>'Registar moviminetos']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'movimientos.edit'
                              ,'descripcion' =>'Editr movimineto']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        //
        Permission::create((['name'=> 'proveedores.destroy'
                              ,'descripcion' =>'Eliminar proveedores']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'proveedores.index' ,'descripcion' =>'Ver informacion de proveedores']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'proveedores.create'
                              ,'descripcion' =>'Registrar un proveedor ']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'sedes.destroy'
                              ,'descripcion' =>'Eliminar las sedes']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'sedes.index'
                              ,'descripcion' =>'Revisar informacion del las sedes']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'sedes.create'
                              ,'descripcion' =>'Registrar una sede']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'sedes.edit'
                              ,'descripcion' =>'Editar una sede']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        //
          
        Permission::create((['name'=> 'tipoEquipo.destroy'
                              ,'descripcion' =>'Eliminar caracteriatica de equipo']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'tipoEquipo.index'
                              ,'descripcion' =>'Ver informacion de equipos']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'tipoEquipo.create'
                              ,'descripcion' =>'Registar un tipo de equipo']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'tipoEquipo.edit'
                              ,'descripcion' =>'Editar un tipo de equipo']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        //
     
     
     
        Permission::create((['name'=> 'tipoMovimiento.destroy',
                              'descripcion' => 'Eliminar Caracteristica de movimiento']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'tipoMovimiento.index',
                              'descripcion' => 'Ver informacion de tipo de movmientos']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'tipoMovimiento.create',
                              'descripcion' => 'Registrar un tipo de movimiento ']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'tipoMovimiento.edit',
                              'descripcion' => 'Editar tipo de movimiento ']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        //
        Permission::create((['name'=> 'usuarios.destroy',
                              'descripcion' => 'Eliminar usuarios']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'usuarios.index',
                              'descripcion' => 'Ver informacion usuarios']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'usuarios.create',
                              'descripcion' => 'Registrar un usuario']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'usuarios.edit' , 'descripcion' => 'Editar usuarios']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        //
        Permission::create((['name'=> 'entrada.destroy',
                              'descripcion' => 'Eliminar movimientos de entrada']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'entrada.index',
                              'descripcion' => 'Ingreso a movimientos de entrada']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'entrada.create',
                              'descripcion' => 'Registar movimientos de entrada']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'entrada.edit',
                              'descripcion' => 'Editar movimientos de entrada']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'dashboard',
                              'descripcion' => 'ingreso al dashboar']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        
     

       
        Permission::create((['name'=> 'clientes.destroy'
                              ,'descripcion' =>'Eliminar clientes']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'clientes.index'
                              ,'descripcion' =>'Ver informacion de  clientes']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'clientes.create'
                              ,'descripcion' =>'Registrar clientes']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'clientes.edit'
                              ,'descripcion' =>'Editar clientes']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
       
        
     
     


     
 
      
     


    }
}
