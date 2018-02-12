/// cargar_configuracion()
var savemap = ds_map_secure_load("game.config");
if (ds_exists(savemap, ds_type_map)) {
    if (savemap[? "version"] != SAVE_VERTION)
        ds_map_destroy(savemap);
}

if (!ds_exists(savemap, ds_type_map)) {
    savemap = ds_map_create();
    savemap[? "version"] = SAVE_VERTION;
    savemap[? "piso actual"] = 1;
    savemap[? "partida iniciada"] = false;
    savemap[? "mano diestra"] = OrientacionPad.diestro;
    ds_map_secure_save(savemap, "game.config");
}

global.pisoActual = savemap[? "piso actual"];
global.manoDiestra = savemap[? "mano diestra"];
global.partidaIniciada = savemap[? "partida iniciada"];
ds_map_destroy(savemap);
