/// scr_mapa_instanciar(grilla)
var plano = argument[0];
var plano_ancho = ds_grid_width (plano);
var plano_alto  = ds_grid_height(plano);

for(var xx = 0; xx < plano_ancho; xx++) {
for(var yy = 0; yy < plano_alto ; yy++) {
    script_execute(plano[# xx,yy], plano, xx, yy);
}}

enum CeldaValor {
    piso   = scr_mapa_piso  ,
    vacio  = scr_mapa_vacio ,
    pared  = scr_mapa_pared ,
    salida = scr_mapa_salida,
    entrada = scr_mapa_entrada,
}
