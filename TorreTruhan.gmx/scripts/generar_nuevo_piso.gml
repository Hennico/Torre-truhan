/// generar_nuevo_piso()
var planos = ds_grid_create(PLANO_ANCHO, PLANO_ALTO);
ds_grid_mazeify(planos,CeldaValor.pared, CeldaValor.piso, global.entradaX,global.entradaY, MazePolishOption.both);

mapa_agregar_salida(planos, global.entradaX, global.entradaY);
scr_mapa_instanciar(planos);
ds_grid_destroy(planos);
grabar_esenario();

with (obj_oscuridad) { event_user(0); }
scr_agregarEfectoParedes(background3,-1);
