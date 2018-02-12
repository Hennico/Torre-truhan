/// scr_agregarEfectoParedes(tile_set, depth)
var tiles = argument[0];
var tile_depth = argument[1];

var previousTiles = tile_get_ids_at_depth(tile_depth);
for (var i = 0; i < array_length_1d(previousTiles); i++)
    tile_delete(previousTiles[i]);
    
for (var xx = 0; xx < MAPA_ANCHO; xx += CELDA_ANCHO) {
for (var yy = 0; yy < MAPA_ALTO ; yy += CELDA_ALTO) {
    var noTile = false;
    var tile_top = 0;
    var tile_left = 0;
    
    var top_left = position_meeting(xx,yy,obj_pared);
    var top_right = position_meeting(xx+CELDA_ANCHO,yy,obj_pared);
    var bottom_left = position_meeting(xx,yy+CELDA_ALTO,obj_pared);
    var bottom_right = position_meeting(xx+CELDA_ANCHO,yy+CELDA_ALTO,obj_pared);
    
    
    if (top_left) {
        if (top_right) {
            if (bottom_left) {
                if (bottom_right) {
                    noTile = true;
                } else {
                    tile_left = CELDA_ANCHO*2;
                    tile_top  = CELDA_ALTO *0;
                }
            } else {
                if (bottom_right) {
                    tile_left = CELDA_ANCHO*3;
                    tile_top  = CELDA_ALTO *0;
                } else {
                    tile_left = CELDA_ANCHO*0;
                    tile_top  = CELDA_ALTO *3;
                }
            }
        } else {
            if (bottom_left) {
                if (bottom_right) {
                    tile_left = CELDA_ANCHO*2;
                    tile_top  = CELDA_ALTO *1;
                } else {
                    tile_left = CELDA_ANCHO*0;
                    tile_top  = CELDA_ALTO *2;
                }
            } else {
                if (bottom_right) {
                    noTile = true;
                } else {
                    tile_left = CELDA_ANCHO*1;
                    tile_top  = CELDA_ALTO *1;
                }
            }
        }
    } else {
        if (top_right) {
            if (bottom_left) {
                if (bottom_right) {
                    tile_left = CELDA_ANCHO*3;
                    tile_top  = CELDA_ALTO *1;
                } else {
                    noTile = true;
                }
            } else {
                if (bottom_right) {
                    tile_left = CELDA_ANCHO*1;
                    tile_top  = CELDA_ALTO *2;
                } else {
                    tile_left = CELDA_ANCHO*0;
                    tile_top  = CELDA_ALTO *1;
                }
            }
        } else {
            if (bottom_left) {
                if (bottom_right) {
                    tile_left = CELDA_ANCHO*1;
                    tile_top  = CELDA_ALTO *3;
                } else {
                    tile_left = CELDA_ANCHO*1;
                    tile_top  = CELDA_ALTO *0;
                }
            } else {
                if (bottom_right) {
                    tile_left = CELDA_ANCHO*0;
                    tile_top  = CELDA_ALTO *0;
                } else {
                    noTile = true;
                }
            }
        }
    }
    if (!noTile)
        tile_add(tiles, tile_left, tile_top, CELDA_ANCHO, CELDA_ALTO, xx, yy, tile_depth);
}}
