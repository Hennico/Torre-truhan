/// cargar_esenario()
var clave = "esenario piso " + string(global.pisoActual);
var total_esenario_map = ds_map_secure_load("esenarios.save");

if (!ds_map_exists(total_esenario_map, clave)) {
    ds_map_destroy(total_esenario_map);
    return false;
}

var esenario = total_esenario_map[? clave];
ds_map_destroy(total_esenario_map);

var esenarioGrid = ds_grid_create(0,0);
ds_grid_read(esenarioGrid,esenario);

var esenario_count = ds_grid_width(esenarioGrid);

for (var idx = 0; idx < esenario_count; idx++) {
    var xx  = esenarioGrid[# idx, EsenarioAtrib.x];
    var yy  = esenarioGrid[# idx, EsenarioAtrib.y];
    var obj = esenarioGrid[# idx, EsenarioAtrib.object_index];
    
    with (instance_create(xx,yy,obj)) {
        image_index = esenarioGrid[# idx, EsenarioAtrib.image_index];
        image_angle = esenarioGrid[# idx, EsenarioAtrib.image_angle];
    }
}
ds_grid_destroy(esenarioGrid);

with (obj_oscuridad) { event_user(0); }
scr_agregarEfectoParedes(background3,-1);
return true;
