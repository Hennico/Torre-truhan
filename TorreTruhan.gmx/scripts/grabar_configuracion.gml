/// grabar_configuracion()
var savemap = ds_map_create();
savemap[? "version"] = SAVE_VERTION;
savemap[? "piso actual"] = global.pisoActual;
savemap[? "mano diestra"] = global.manoDiestra;
savemap[? "partida iniciada"] = global.partidaIniciada;
ds_map_secure_save(savemap, "game.config");
ds_map_destroy(savemap);
