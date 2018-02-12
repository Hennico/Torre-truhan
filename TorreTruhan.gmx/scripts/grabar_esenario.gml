/// grabar_esenario();
var clave = "esenario piso " + string(global.pisoActual);
var esenarioGrid = ds_grid_create(instance_number(obj_esenario),EsenarioAtrib.cantidadAtributos);
var idx = 0;
with (obj_esenario) {
    esenarioGrid[# idx, EsenarioAtrib.x           ] = x           ;
    esenarioGrid[# idx, EsenarioAtrib.y           ] = y           ;
    esenarioGrid[# idx, EsenarioAtrib.image_index ] = image_index ;
    esenarioGrid[# idx, EsenarioAtrib.image_angle ] = image_angle ;
    esenarioGrid[# idx, EsenarioAtrib.object_index] = object_index;
    idx++;
}
var esenario = ds_grid_write(esenarioGrid);
ds_grid_destroy(esenarioGrid);

var total_esenario_map = ds_map_secure_load("esenarios.save");
if (!ds_exists(total_esenario_map, ds_type_map))
    total_esenario_map = ds_map_create();    
total_esenario_map[? clave] = esenario;
ds_map_secure_save(total_esenario_map, "esenarios.save");
ds_map_destroy(total_esenario_map);
