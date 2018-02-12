/// scr_mapa_salida(plano, grid_x, grid_y)
if(global.pisoActual > 1)
    instance_create(cellToX(argument[1]), cellToY(argument[2]), obj_entrada);
