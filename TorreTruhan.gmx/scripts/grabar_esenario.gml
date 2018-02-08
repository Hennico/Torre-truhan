/// grabar_esenario();
var esenarioGrid = ds_grid_create(instance_number(obj_esenario),EsenarioAtrib.cantidadAtributos);
var idx = 0;
with (obj_esenario) {
    esenarioGrid[# idx, EsenarioAtrib.x           ] = x           ;
    esenarioGrid[# idx, EsenarioAtrib.y           ] = y           ;
    esenarioGrid[# idx, EsenarioAtrib.image_index ] = image_index ;
    esenarioGrid[# idx, EsenarioAtrib.image_angle ] = image_angle ;
    esenarioGrid[# idx, EsenarioAtrib.object_index] = object_index;
    
    esenarioGrid[# idx, EsenarioAtrib.humedad        ] = humedad        ;
    esenarioGrid[# idx, EsenarioAtrib.combustible    ] = combustible    ;
    esenarioGrid[# idx, EsenarioAtrib.creacionInfo   ] = creacionInfo   ;
    esenarioGrid[# idx, EsenarioAtrib.bloqueaVision  ] = bloqueaVision  ;
    esenarioGrid[# idx, EsenarioAtrib.intensidadFuego] = intensidadFuego;
    
    idx++;
}
var esenario = ds_grid_write(esenarioGrid);
ds_grid_destroy(esenarioGrid);
return esenario;
