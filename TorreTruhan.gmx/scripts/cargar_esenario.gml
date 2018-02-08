/// cargar_esenario(esenario)
var esenario = argument[0];

var esenarioGrid = ds_grid_create(0,0);
ds_grid_read(esenarioGrid,esenario);

var esenario_count = ds_grid_height(esenarioGrid);

for (var idx = 0; idx < esenario_count; idx++) {
    var xx  = esenarioGrid[# idx, EsenarioAtrib.x];
    var yy  = esenarioGrid[# idx, EsenarioAtrib.y];
    var obj = esenarioGrid[# idx, EsenarioAtrib.object_index];
    
    with (instance_create(xx,yy,obj)) {
        image_index = esenarioGrid[# idx, EsenarioAtrib.image_index];
        image_angle = esenarioGrid[# idx, EsenarioAtrib.image_angle];
        
        humedad         = esenarioGrid[# idx, EsenarioAtrib.humedad        ];
        combustible     = esenarioGrid[# idx, EsenarioAtrib.combustible    ];
        creacionInfo    = esenarioGrid[# idx, EsenarioAtrib.creacionInfo   ];
        bloqueaVision   = esenarioGrid[# idx, EsenarioAtrib.bloqueaVision  ];
        intensidadFuego = esenarioGrid[# idx, EsenarioAtrib.intensidadFuego];
        
        event_user(ev_inicializarse); /// Inicializar con parametros "creacionInfo"
    }
}
ds_grid_destroy(esenarioGrid);

