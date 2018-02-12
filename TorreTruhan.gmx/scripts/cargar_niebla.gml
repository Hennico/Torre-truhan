/// cargar_niebla()
var clave = "niebla piso " + string(global.pisoActual);
var savemap = ds_map_secure_load("esenarios.save");

if (!ds_map_exists(savemap, clave)) {
    ds_map_destroy(savemap);
    return false;
}

var niebla = savemap[? clave];
ds_map_destroy(savemap);

var nieblaGrid = ds_grid_create(0,0);
ds_grid_read(nieblaGrid, niebla);

if (ds_exists(obj_oscuridad.grilla_niebla, ds_type_grid))
    ds_grid_destroy(obj_oscuridad.grilla_niebla);
obj_oscuridad.grilla_niebla = nieblaGrid;

return true;
