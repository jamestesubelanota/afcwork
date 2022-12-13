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



        Permission::create((['name'=> 'activos.index'])) ->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'activos.create'])) ->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'activos.edit'])) ->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'activos.show']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'activos.destroy']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        //
        Permission::create((['name'=> 'ciudades.index']))->syncRoles([  $role1,  $role2,  ]);
        Permission::create((['name'=> 'ciudades.create']))->syncRoles([  $role1,  $role2,  ]);
        Permission::create((['name'=> 'ciudades.edit']))->syncRoles([  $role1,  $role2,  ]);
        Permission::create((['name'=> 'ciudades.destroy']))->syncRoles([  $role1,  $role2,  ]);
       //
        Permission::create((['name'=> 'colaboradores.index']))->syncRoles([  $role1,  $role2,  ]);
        Permission::create((['name'=> 'colaboradores.create']))->syncRoles([  $role1,  $role2,  ]);
        Permission::create((['name'=> 'colaboradores.edit']))->syncRoles([  $role1,  $role2,  ]);
        Permission::create((['name'=> 'colaboradores.destroy']))->syncRoles([  $role1,  $role2,  ]);
        //
        Permission::create((['name'=> 'contratos.index']))->syncRoles([  $role1,  $role2,     ]);
        Permission::create((['name'=> 'contratos.create']))->syncRoles([  $role1,  $role2,     ]);
        Permission::create((['name'=> 'contratos.edit']))->syncRoles([  $role1,  $role2,    ]);
        Permission::create((['name'=> 'contratos.destroy']))->syncRoles([  $role1,  $role2,     ]);
        //
        Permission::create((['name'=> 'equipos.index']))->syncRoles([  $role1,  $role2,  $role3,   ]);
        Permission::create((['name'=> 'equipos.create']))->syncRoles([  $role1,  $role2,  $role3,   ]);
        Permission::create((['name'=> 'equipos.edit']))->syncRoles([  $role1,  $role2,  $role3,   ]);
        Permission::create((['name'=> 'equipos.destroy']))->syncRoles([  $role1,  $role2,  $role3,   ]);
        //
        Permission::create((['name'=> 'estados.destroy']))->syncRoles([  $role1,  $role2,  ]);
        Permission::create((['name'=> 'estados.index']))->syncRoles([  $role1,  $role2,  ]);
        Permission::create((['name'=> 'estados.create']))->syncRoles([  $role1,  $role2,  ]);
        Permission::create((['name'=> 'estados.edit']))->syncRoles([  $role1,  $role2,  ]);
        //
        Permission::create((['name'=> 'foto.destroy']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'foto.index']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'foto.create']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'foto.edit']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        //
        Permission::create((['name'=> 'marcas.destroy']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'marcas.index']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'marcas.create']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'marcas.edit']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        //
        Permission::create((['name'=> 'movimientos.destroy']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'movimientos.index']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'movimientos.create']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'movimientos.edit']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        //
        Permission::create((['name'=> 'proveedores.destroy']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'proveedores.index']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'proveedores.create']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'proveedores.edit']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        //

        Permission::create((['name'=> 'roles.destroy']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'roles.index']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'roles.create']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'roles.edit']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        //
     
        Permission::create((['name'=> 'sedes.destroy']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'sedes.index']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'sedes.create']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'sedes.edit']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        //
          
        Permission::create((['name'=> 'tipoEquipo.destroy']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'tipoEquipo.index']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'tipoEquipo.create']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'tipoEquipo.edit']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        //
     
     
     
        Permission::create((['name'=> 'tipoMovimiento.destroy']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'tipoMovimiento.index']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'tipoMovimiento.create']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'tipoMovimiento.edit']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        //
        Permission::create((['name'=> 'usuarios.destroy']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'usuarios.index']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'usuarios.create']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        Permission::create((['name'=> 'usuarios.edit']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        //
        Permission::create((['name'=> 'dashboard']))->syncRoles([  $role1,  $role2,  $role3,   $role4]);
        
     

       
     
     
     


     
 
      
     


    }
}
