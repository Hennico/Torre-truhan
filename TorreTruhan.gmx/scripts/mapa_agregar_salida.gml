/// mapa_agregar_salida(plano, xIni, yIni)
var plano = argument[0];
var salidaX = argument[1];
var salidaY = argument[2];

var plano_ancho = ds_grid_width(plano);

var usados = ds_map_create();
var sigSalida = ds_queue_create();
ds_queue_enqueue(sigSalida, salidaX, salidaY);

while (!ds_queue_empty(sigSalida)) {
    salidaX = ds_queue_dequeue(sigSalida);
    salidaY = ds_queue_dequeue(sigSalida);
    
    var clave = salidaX + plano_ancho * salidaY;
    usados[? clave] = false;
    
    for (var dir = 0; dir < 360; dir += 90) {
        var sigX = salidaX + dcos(dir);
        var sigY = salidaY + dsin(dir);
        
        var sigClave = sigX + plano_ancho * sigY;
        var celdaPiso = plano[# sigX, sigY] == CeldaValor.piso;
        
        if (!ds_map_exists(usados, sigClave) && celdaPiso) {
            ds_queue_enqueue(sigSalida, sigX, sigY);
        }   
    }
}

ds_map_destroy(usados);
ds_queue_destroy(sigSalida);

plano[# salidaX, salidaY] = CeldaValor.salida;
