/// grabar_configuracion()
var savemap = ds_map_create();
savemap[? "version"] = SAVE_VERTION;
savemap[? "piso actual"] = global.pisoActual;
room_goto_next();
