/// scr_iluminar(niebla, iluminacion)
var niebla = argument[0];
var iluminacion = argument[1];

var iluminado = ds_map_create();
ds_map_clear(iluminado);

for (var xx = 0; xx < PLANO_ANCHO; xx++) {
for (var yy = 0; yy < PLANO_ALTO ; yy++) {
    var clave = xx+PLANO_ANCHO*yy;
    if (!ds_map_exists(iluminado, clave)) {
        if (iluminacion[# xx,yy] > 0) {
            iluminado[? clave] = 1;
            var cola = ds_queue_create();
            var decenzo = (1-MIN_VALOR_NIEBLA)/iluminacion[# xx,yy];
            ds_queue_enqueue(cola, xx, yy);
            
            while(!ds_queue_empty(cola)) {
                var xAct = ds_queue_dequeue(cola);
                var yAct = ds_queue_dequeue(cola);
                
                var relX = cellToX(xAct)+CELDA_ANCHO/2;
                var relY = cellToY(yAct)+CELDA_ALTO /2;
                
                clave = xAct+PLANO_ANCHO*yAct;
                niebla[# xAct, yAct] = iluminado[? clave];
                
                var todaviaIlumina = iluminado[? clave] > MIN_VALOR_NIEBLA;
                var lugarIluminable = !position_meeting(relX, relY, obj_pared);
                
                if (todaviaIlumina && lugarIluminable) {
                    for (var dir = 0; dir < 360; dir += 90) {
                        var newX = xAct+dcos(dir);
                        var newY = yAct+dsin(dir);
                        var newClave = newX+PLANO_ANCHO*newY;
                        
                        if (!ds_map_exists(iluminado, newClave)) {
                            ds_queue_enqueue(cola, newX, newY);
                            iluminado[? newClave] = iluminado[? clave] - decenzo;
                        }
                    }
                }
            }
            
            ds_queue_destroy(cola);
        } else {
            niebla[# xx,yy] = min (niebla[# xx,yy], MIN_VALOR_NIEBLA);
        }
    }
}}

ds_map_destroy(iluminado);

