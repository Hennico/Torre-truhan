/// cargar_configuracion()
var savemap = ds_map_secure_load("game.config");
if (savemap[? "version"] != SAVE_VERTION)
    ds_map_destroy(savemap);

if (!ds_exists(savemap, ds_type_map)) {
    savemap = ds_map_create();
    savemap[? "version"] = SAVE_VERTION;
    savemap[? "piso actual"] = 1;
    savemap[? "partida iniciada"] = false;
    ds_map_secure_save(savemap, "game.config");
}

global.pisoActual = savemap[? "piso actual"];
global.partidaIniciada = savemap[? "partida iniciada"];
ds_map_destroy(savemap);
room_goto_next();
