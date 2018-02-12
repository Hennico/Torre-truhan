/// grabar_niebla();
var clave = "niebla piso " + string(global.pisoActual);
var nieblaGrid = obj_oscuridad.grilla_niebla;
var niebla = ds_grid_write(nieblaGrid);

var savemap = ds_map_secure_load("esenarios.save");
if (!ds_exists(savemap, ds_type_map))
    savemap = ds_map_create();    
savemap[? clave] = niebla;
ds_map_secure_save(savemap, "esenarios.save");
ds_map_destroy(savemap);
